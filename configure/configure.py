#!/usr/bin/python
#
# Generate the build trees and Makefiles for PyQwt.


import compileall
import glob
import optparse
import os
import pprint
import re
import shutil
import sys
import traceback


class Die(Exception):
    def __init__(self, info):
        Exception.__init__(self, info)

    # __init__()

# class Die


try:
    required = 'Requires at least SIP-4.6 and its development tools.'
    import sipconfig
except ImportError:
    raise Die, required
if 0x040600 > sipconfig._pkg_config['sip_version']:
    raise Die, required
del required


def get_pyqt_configuration(options):
    """Return the PyQt configuration for Qt3 or Qt4.
    """

    if options.qt == 3:
        required = 'Requires at least PyQt-3.17.2 and its development tools.'
        options.qwt = 'qwt5qt3'
        options.iqt = 'iqt5qt3'
        try:
            import pyqtconfig as pyqtconfig
        except ImportError:
            raise Die, required
        if 0x031102 > pyqtconfig._pkg_config['pyqt_version']:
            raise Die, required
    elif options.qt == 4:
        required = 'Requires at least PyQt-4.2 and its development tools.'
        options.qwt = 'qwt5qt4'
        options.iqt = 'iqt5qt4'
        try:
            import PyQt4.pyqtconfig as pyqtconfig
        except ImportError:
            raise Die, required
        if 0x040200 > pyqtconfig._pkg_config['pyqt_version']:
            raise Die, required

    try:
        configuration = pyqtconfig.Configuration()
    except AttributeError:
        raise Die, (
            'Check if SIP and PyQt or PyQt4 have been installed properly.'
            )

    return configuration

# get_pyqt_configuration()


def compile_qt_program(name, configuration,
                       extra_defines=[],
                       extra_include_dirs=[],
                       extra_lib_dirs=[],
                       extra_libs=[],
                       ):
    """Compile a simple Qt application.

    name is the name of the single source file
    configuration is the pyqtconfig.Configuration()
    extra_defines is a list of extra preprocessor definitions
    extra_include_dirs is a list of extra directories to search for headers
    extra_lib_dirs is a list of extra directories to search for libraries
    extra_libs is a list of extra libraries
    """    
    makefile = sipconfig.ProgramMakefile(
        configuration, console=True, qt=True, warnings=True)
    
    makefile.extra_defines.extend(extra_defines)
    makefile.extra_include_dirs.extend(extra_include_dirs)
    makefile.extra_lib_dirs.extend(extra_lib_dirs)
    makefile.extra_libs.extend(extra_libs)

    exe, build = makefile.build_command(name)

    # zap a spurious executable
    try:
        os.remove(exe)
    except OSError:
        pass

    os.system(build)

    if not os.access(exe, os.X_OK):
        return None

    if sys.platform != 'win32':
        exe = './' + exe

    return exe

# compile_qt_program()

    
def copy_files(sources, directory):
    """Copy a list of files to a directory
    """ 
    for source in sources:
        shutil.copy2(source, os.path.join(directory, os.path.basename(source)))

# copy_files()


def fix_build_file(name, extra_sources, extra_headers, extra_moc_headers):
    """Extend the targets of a SIP build file with extra files 
    """    
    keys = ('target', 'sources', 'headers', 'moc_headers')
    sbf = {}
    for key in keys:
        sbf[key] = []

    # Parse,
    nr = 0
    for line in open(name, 'r'):
        nr += 1
        if line[0] != '#':
            eq = line.find('=')
            if eq == -1:
                raise Die, ('"%s\" line %d: Line must be in the form '
                            '"key = value value...."' % (name, nr)
                            )
        key = line[:eq].strip()
        value = line[eq+1:].strip()
        if key in keys:
            sbf[key].append(value)

    # extend,
    sbf['sources'].extend(extra_sources)
    sbf['headers'].extend(extra_headers)
    sbf['moc_headers'].extend(extra_moc_headers)

    # and write.
    output = open(name, 'w')
    for key in keys:
        if sbf[key]:
            print >> output, '%s = %s' % (key, ' '.join(sbf[key]))

# fix_build_file()


def fix_typedefs(sources):
    """Work around a code generation bug in SIP-4.5.x
    """
    for source in sources:
        old = open(source).read()
        new = old.replace('"QtCore"', '"PyQt4.QtCore"')
        if new != old:
            open(source, 'w').write(new)

# fix_typedefs()


def lazy_copy_file(source, target):
    """Lazy copy a file to another file:
    - check for a SIP time stamp to skip,
    - check if source and target do really differ,
    - copy the source file to the target if they do,
    - return True on copy and False on no copy.
    """
    if not os.path.exists(target):
        shutil.copy2(source, target)
        return True

    sourcelines = open(source).readlines()
    targetlines = open(target).readlines()

    # global length check
    if len(sourcelines) != len(targetlines):
        shutil.copy2(source, target)
        return True
    
    # skip a SIP time stamp 
    if (len(sourcelines) > 3
        and sourcelines[3].startswith(' * Generated by SIP')
        ):
        line = 4
    else:
        line = 0
        
    # line by line check
    while line < len(sourcelines):
        if sourcelines[line] != targetlines[line]:
            shutil.copy2(source, target)
            return True
        line = line + 1
        
    return False

# lazy_copy_file()


def check_numarray(configuration, options, package):
    """See if the numarray extension has been installed.
    """
    if options.disable_numarray:
        options.excluded_features.append("-x HAS_NUMARRAY")
        return options

    try:
        import numarray
        # Try to find numarray/arrayobject.h.

        numarray_inc = os.path.join(
            configuration.py_inc_dir, "numarray", "arrayobject.h")
        if os.access(numarray_inc, os.F_OK):
            print "Found numarray-%s.\n" % numarray.__version__
            options.extra_defines.append("HAS_NUMARRAY")
        else:
            print ("numarray has been installed, "
                   "but its headers are not in the standard location.\n"
                   "%s will be build without support for numarray.\n"
                   "(Linux users may have to install a development package)\n"
                   ) % (package,)
            raise ImportError
    except ImportError:
        options.excluded_features.append("-x HAS_NUMARRAY")
        print ("Failed to import numarray: "
               "%s will be build without support for numarray.\n"
               ) % (package,)

    return options

# check_numarray()


def check_numeric(configuration, options, package):
    """See if the Numeric extension has been installed.
    """
    if options.disable_numeric:
        options.excluded_features.append("-x HAS_NUMERIC")
        return options

    try:
        import Numeric
        # Try to find Numeric/arrayobject.h.
        numeric_inc = os.path.join(
            configuration.py_inc_dir, "Numeric", "arrayobject.h")
        if os.access(numeric_inc, os.F_OK):
            print "Found Numeric-%s.\n" % Numeric.__version__
            options.extra_defines.append("HAS_NUMERIC")
        else:
            print ("Numeric has been installed, "
                   "but its headers are not in the standard location.\n"
                   "%s will be build without support for Numeric.\n"
                   "(Linux users may have to install a development package)\n"
                   ) % (package,)
            raise ImportError
    except ImportError:
        options.excluded_features.append("-x HAS_NUMERIC")
        print ("Failed to find Numeric2: "
               "%s will be build without support for Numeric.\n"
               ) % (package,)

    return options

# check_numeric()


def check_numpy(configuration, options, package):
    """See if the NumPy extension has been installed.
    """
    if options.disable_numpy:
        options.excluded_features.append("-x HAS_NUMPY")
        return options

    try:
        import numpy

        # Try to find numpy/arrayobject.h.
        from  numpy.distutils.misc_util import get_numpy_include_dirs
        include_dirs = get_numpy_include_dirs()
        for inc_dir in include_dirs:
            header = os.path.join(inc_dir, 'numpy', 'arrayobject.h')
            if os.access(header, os.F_OK):
                break
        else:
            print ('NumPy has been installed, '
                   'but its headers are not in the standard location.\n'
                   '%s will be build without support for NumPy.\n'
                   '(Linux users may have to install a development package)\n'
                   ) % (package,)
            raise ImportError
        print 'Found NumPy-%s.\n' % numpy.__version__
        options.extra_defines.append('HAS_NUMPY')
        options.extra_include_dirs.extend(include_dirs)
    except ImportError:
        options.excluded_features.append("-x HAS_NUMPY")
        print ("Failed to find NumPy: "
               "%s will be build without support for NumPy.\n"
               ) % (package,)

    return options

# check_numpy()


def check_compiler(configuration, options):
    """Check compiler specifics.
    """
    print 'Do not get upset by error messages in the next 3 compiler checks:'
    
    makefile = sipconfig.Makefile(configuration)
    generator = makefile.optional_string('MAKEFILE_GENERATOR', 'UNIX')
    if generator in ['MSVC', 'MSVC.NET']:
        options.extra_cxxflags.extend(['-GR'])

    program = '\n'.join([
        r'#include <stddef.h>',
        r'class a { public: void f(size_t); };',
        r'void a::f(%s) {};',
        r'int main() { return 0; }',
        r'',
        ])
    name = "size_t_check.cpp"
    new = [
        '// Automagically generated by configure.py',
        '',
        '// Uncomment one of the following three lines',
        ]

    for ctype in ('unsigned int', 'unsigned long', 'unsigned long long'):
        open(name, "w").write(program % ctype)
        print "Check if 'size_t' and '%s' are the same type:" % ctype
        if compile_qt_program(name, configuration):
            comment = ''
            print "YES"
        else:
            print "NO"
            comment =  '// '
        new.append('%stypedef %s size_t;' % (comment, ctype))

    new.extend(['',
                '// Local Variables:',
                '// mode: C++',
                '// c-file-style: "stroustrup"',
                '// End:',
                '',
                ])

    new = '\n'.join(new)
    types_sip = os.path.join(os.pardir, 'sip', options.qwt, 'QwtTypes.sip')
    if os.access(types_sip, os.R_OK):
        old = open(types_sip, 'r').read()
    else:
        old = ''
    if old != new:
        open(types_sip, 'w').write(new)    
    
    return options

# check_compiler()


def check_os(configuration, options):
    """Check operating system specifics.
    """
    print "Found '%s' operating system:" % os.name
    print sys.version

    if os.name == 'nt':
        options.extra_defines.append('WIN32')

    return options

# check_os()


def check_sip(configuration, options):
    """Check if PyQwt can be built with SIP.
    """
    version = configuration.sip_version
    version_str = configuration.sip_version_str
    
    print "Found SIP-%s." % version_str

    if 0x040500 > version:
        raise Die, 'PyQwt requires at least SIP-4.5.x.'

    return options

# check_sip


def check_iqt(configuration, options):
    """Check iqt module specifics.
    """
    # iqt is useless on non-Windows platforms without GNU readline && select.
    options.subdirs.append(options.iqt)
    options.modules.append('iqt')
    options.iqt_sipfile = os.path.join(
        os.pardir, 'sip', options.iqt, 'IQtModule.sip')

    return options

# check_iqt()


def check_qwt(configuration, options):
    """Check qwt module specifics.
    """
    # zap all qwt_version_info*
    for name in glob.glob('qwt_version_info*'):
        try:
            os.remove(name)
        except OSError:
            pass

    open('qwt_version_info.cpp', 'w').write('\n'.join([
        r'#include <stdio.h>',
        r'#include <qwt_global.h>',
        r'',
        r'int main(int, char **)',
        r'{',
        r'    FILE *file;',
        r'',
        r'    if (!(file = fopen("qwt_version_info.py", "w"))) {',
        r'        fprintf(stderr, "Failed to create qwt_version_info.py\n");',
        r'        return 1;',
        r'    }',
        r'',
        r'    fprintf(file, "QWT_VERSION = %#08x\n", QWT_VERSION);',
        r'    fprintf(file, "QWT_VERSION_STR = \"%s\"\n", QWT_VERSION_STR);',
        r'',
        r'    fclose(file);',
        r'',
        r'    return 0;',
        r'}',
        r'',
        r'// Local Variables:',
        r'// mode: C++',
        r'// c-file-style: "stroustrup"',
        r'// End:',
        r'',
        ]))

    extra_include_dirs = []
    if options.qt == 4:
        extra_include_dirs.append(os.path.join(configuration.qt_inc_dir, 'Qt'))
        #FIXME: options.extra_include_dirs.extend(extra_include_dirs)
    if options.qwt_sources:
        extra_include_dirs.append(os.path.join(options.qwt_sources, 'src'))
    if options.extra_include_dirs:
        extra_include_dirs.extend(options.extra_include_dirs)

    exe = compile_qt_program('qwt_version_info.cpp', configuration,
                             extra_include_dirs = extra_include_dirs)
    if not exe:
        raise Die, 'Failed to build the qwt_version_info tool.'

    os.system(exe)

    try:
        from qwt_version_info import QWT_VERSION, QWT_VERSION_STR
    except ImportError:
        raise Die, 'Failed to import qwt_version_info.'

    if QWT_VERSION < 0x050000:
        raise Die, 'Qwt-%s is not supported.' % QWT_VERSION_STR
    elif QWT_VERSION == 0x050000:
        options.timelines.append('-t Qwt_5_0_0')
    else:
        options.timelines.append('-t Qwt_5_0_1')        

    print ('Found Qwt-%s.' % QWT_VERSION_STR)

    options.extra_defines.append('HAS_QWT5')
    options.excluded_features.append('-x HAS_QWT4')
    options.subdirs.append(options.qwt)
    options.modules.append('Qwt5')
    options.qwt_sipfile = os.path.join(
        os.pardir, 'sip', options.qwt, 'QwtModule.sip')

    open('qwt_svg_check.cpp', 'w').write('\n'.join([
        r'#include <qwt_plot_svgitem.h>',
        r'',
        r'int main(int, char **)',
        r'{',
        r'    return 0;',
        r'}',
        r'',
        r'// Local Variables:',
        r'// mode: C++',
        r'// c-file-style: "stroustrup"',
        r'// End:',
        r'',
        ]))

    exe = compile_qt_program('qwt_svg_check.cpp', configuration,
                             extra_include_dirs = extra_include_dirs)
    if not exe:
        options.excluded_features.append('-x HAS_QWT_SVG')

    return options

# check_qwt()
    

def setup_iqt_build(configuration, options, package):
    """Setup the iqt module build.
    """
    if 'iqt' not in options.modules:
        return

    print 'Setup the iqt package build.'
    
    build_dir = options.iqt
    tmp_dir = 'tmp-' + build_dir
    build_file = os.path.join(tmp_dir, '%s.sbf' % options.iqt)

    # zap the temporary directory
    try:
        shutil.rmtree(tmp_dir)
    except:
        pass
    # make a clean temporary directory
    try:
        os.mkdir(tmp_dir)
    except:
        raise Die, 'Failed to create the temporary build directory.'

    # invoke SIP
    cmd = ' '.join(
        [configuration.sip_bin,
         '-b', build_file,
         '-c', tmp_dir,
         options.jobs,
         options.trace,
         ]
        # SIP assumes POSIX style path separators
        + [options.iqt_sipfile.replace('\\', '/')]
        )

    print 'sip invokation:'
    pprint.pprint(cmd)
    if os.path.exists(build_file):
        os.remove(build_file)
    os.system(cmd)
    if not os.path.exists(build_file):
        raise Die, 'SIP failed to generate the C++ code.'

    # copy lazily to the build directory to speed up recompilation
    if not os.path.exists(build_dir):
        try:
            os.mkdir(build_dir)
        except:
            raise Die, 'Failed to create the build directory.'

    lazy_copies = 0
    for pattern in ('*.c', '*.cpp', '*.h', '*.py', '*.sbf'):
        for source in glob.glob(os.path.join(tmp_dir, pattern)):
            target = os.path.join(build_dir, os.path.basename(source))
            if lazy_copy_file(source, target):
                print 'Copy %s -> %s.' % (source, target)
                lazy_copies += 1
    print '%s file(s) lazily copied.' % lazy_copies

    makefile = sipconfig.ModuleMakefile(
        configuration  = configuration,
        build_file = os.path.basename(build_file),
        dir = build_dir,
        install_dir = options.module_install_path,
        qt = 1,
        warnings = 1,
        debug = options.debug
        )

    makefile._target = '_iqt'
    makefile.extra_cflags.extend(options.extra_cflags)
    makefile.extra_cxxflags.extend(options.extra_cxxflags)
    makefile.extra_defines.extend(options.extra_defines)
    makefile.extra_include_dirs.extend(options.extra_include_dirs)
    makefile.extra_lflags.extend(options.extra_lflags)
    makefile.extra_libs.extend(options.extra_libs)
    makefile.extra_lib_dirs.extend(options.extra_lib_dirs)
    makefile.generate()

# setup_iqt_build()


def nsis():
    """Generate the script for the Nullsoft Scriptable Install System.
    """
    try:
        from numpy.version import version as numpy_version
        from PyQt4.Qt import PYQT_VERSION_STR, QT_VERSION_STR
    except:
        return

    open('PyQwt.nsi', 'w').write(open('PyQwt.nsi.in').read() % {
        'PYQT_VERSION': PYQT_VERSION_STR,
        'PYTHON_VERSION': '%s.%s' % sys.version_info[:2],
        'QT_VERSION': QT_VERSION_STR,
        'NUMPY_VERSION': numpy_version,
        })

# nsis()


def setup_qwt5_build(configuration, options, package):
    """Setup the qwt module build
    """
    if 'Qwt5' not in options.modules:
        return
    
    print 'Setup the qwt package build.'

    build_dir = options.qwt
    tmp_dir = 'tmp-%s' % options.qwt
    build_file = os.path.join(tmp_dir, '%s.sbf' % options.qwt)
    extra_sources = []
    extra_headers = []
    extra_moc_headers = []
    if configuration.qt_version < 0x040000:
        extra_py_files = glob.glob(
            os.path.join(os.pardir, 'qt3lib', 'Qwt5', '*.py'))
    else:
        extra_py_files = glob.glob(
            os.path.join(os.pardir, 'qt4lib', 'PyQt4', 'Qwt5', '*.py'))
    
    # do we compile and link the sources of Qwt statically into PyQwt?
    if options.qwt_sources:
        extra_sources += glob.glob(os.path.join(
            options.qwt_sources, 'src', '*.cpp'))
        extra_headers += glob.glob(os.path.join(
            options.qwt_sources, 'src', '*.h'))
        extra_moc_headers = []
        for header in extra_headers:
            text = open(header).read()
            if re.compile(r'^\s*Q_OBJECT', re.M).search(text):
                extra_moc_headers.append(header)

    # add the interface to the numerical Python extensions
    extra_sources += glob.glob(os.path.join(os.pardir, 'support', '*.cpp'))
    extra_headers += glob.glob(os.path.join(os.pardir, 'support', '*.h'))

    # do we compile and link the sources of Qwt into PyQwt?
    if sys.platform == 'win32':
        qwt = 'qwt5'
    else:
        qwt = 'qwt'
    if options.qwt_sources:
        # yes, zap all occurrences of a qwt library
        while options.extra_libs.count(qwt):
            options.extra_libs.remove(qwt)
    elif qwt not in options.extra_libs:
        # no, add the qwt library if needed
        options.extra_libs.append(qwt)

    # zap the temporary directory
    try:
        shutil.rmtree(tmp_dir)
    except:
        pass
    # make a clean temporary directory
    try:
        os.mkdir(tmp_dir)
    except:
        raise Die, 'Failed to create the temporary build directory.'

    # copy the extra files
    copy_files(extra_sources, tmp_dir)
    copy_files(extra_headers, tmp_dir)
    copy_files(extra_moc_headers, tmp_dir)
    copy_files(extra_py_files, tmp_dir)

    try: # Qt4
        pyqt_sip_flags = configuration.pyqt_sip_flags
    except AttributeError: # Qt3
        pyqt_sip_flags = configuration.pyqt_qt_sip_flags
        
    # invoke SIP
    cmd = ' '.join(
        [configuration.sip_bin,
         # SIP assumes POSIX style path separators
         '-I', configuration.pyqt_sip_dir.replace('\\', '/'),
         '-b', build_file,
         '-c', tmp_dir,
         options.jobs,
         options.trace,
         pyqt_sip_flags,
         ]
        + options.sip_include_dirs
        + options.excluded_features
        + options.timelines
        # SIP assumes POSIX style path separators
        + [options.qwt_sipfile.replace('\\', '/')]
        )

    print 'sip invokation:'
    pprint.pprint(cmd)
    if os.path.exists(build_file):
        os.remove(build_file)
    os.system(cmd)
    if not os.path.exists(build_file):
        raise Die, 'SIP failed to generate the C++ code.'

    # FIXME: sip-4.7 does not generate those include files anymore
    for name in [os.path.join(tmp_dir, name) for name in [
        'sipQwtQwtArrayDouble.h',
        'sipQwtQwtArrayInt.h',
        'sipQwtQwtArrayQwtDoubleInterval.h',
        'sipQwtQwtArrayQwtDoublePoint.h',
        ]]:
        if not os.path.exists(name):
            open(name, 'w')

    # fix the SIP build file
    fix_build_file(build_file,
                   [os.path.basename(f) for f in extra_sources],
                   [os.path.basename(f) for f in extra_headers],
                   [os.path.basename(f) for f in extra_moc_headers])
    
    # fix the typedefs (work around a bug in SIP-4.5.x)
    if tmp_dir == 'tmp-qwt5qt4':
        fix_typedefs(glob.glob(os.path.join(tmp_dir, 'sipQwt*.cpp')))

    # copy lazily to the build directory to speed up recompilation
    if not os.path.exists(build_dir):
        try:
            os.mkdir(build_dir)
        except:
            raise Die, 'Failed to create the build directory.'

    lazy_copies = 0
    for pattern in ('*.c', '*.cpp', '*.h', '*.py', '*.sbf'):
        for source in glob.glob(os.path.join(tmp_dir, pattern)):
            target = os.path.join(build_dir, os.path.basename(source))
            if lazy_copy_file(source, target):
                print 'Copy %s -> %s.' % (source, target)
                lazy_copies += 1
    print '%s file(s) lazily copied.' % lazy_copies

    # byte-compile the Python files
    compileall.compile_dir(build_dir, 1, options.module_install_path)

    # files to be installed
    installs = []
    installs.append([[os.path.basename(f) for f in glob.glob(
        os.path.join(build_dir, '*.py*'))], options.module_install_path])

    pattern = os.path.join(os.pardir, 'sip', options.qwt, '*.sip')
    sip_files = [os.path.join(os.pardir, f) for f in glob.glob(pattern)]
    pattern = os.path.join(os.pardir, 'sip', options.qwt, 'common', '*.sip')
    sip_files += [os.path.join(os.pardir, f) for f in glob.glob(pattern)]
    installs.append(
        [sip_files, os.path.join(configuration.pyqt_sip_dir, 'Qwt5')])

    # module makefile
    if options.qt == 3:
        makefile = sipconfig.SIPModuleMakefile(
            configuration = configuration,
            build_file = os.path.basename(build_file),
            dir = build_dir,
            install_dir = options.module_install_path,
            installs = installs,
            qt = 1,
            warnings = 1,
            debug = options.debug,
            )
    elif options.qt == 4:
        qt = ['QtCore', 'QtGui']
        if '-x HAS_QWT_SVG' not in options.excluded_features:
            qt.append('QtSvg')
        makefile = sipconfig.SIPModuleMakefile(
            configuration = configuration,
            build_file = os.path.basename(build_file),
            dir = build_dir,
            install_dir = options.module_install_path,
            installs = installs,
            qt = qt,
            warnings = 1,
            debug = options.debug,
            )

    makefile.extra_cflags.extend(options.extra_cflags)
    makefile.extra_cxxflags.extend(options.extra_cxxflags)
    makefile.extra_defines.extend(options.extra_defines)
    makefile.extra_include_dirs.extend(options.extra_include_dirs)
    makefile.extra_lflags.extend(options.extra_lflags)
    makefile.extra_libs.extend(options.extra_libs)
    makefile.extra_lib_dirs.extend(options.extra_lib_dirs)
    makefile.generate()

    if options.qt == 4:
        nsis()

# setup_qwt5_build()


def setup_parent_build(configuration, options):
    """Generate the parent Makefile
    """
    print "Setup the PyQwt build."
     
    sipconfig.ParentMakefile(configuration = configuration,
                             subdirs = options.subdirs).generate()

# setup_parent_build()


def parse_args():
    """Return the parsed options and args from the command line
    """
    usage = (
        'python configure.py [options]'
        '\n\nEach option takes at most one argument, but some options'
        '\naccumulate arguments when repeated. For example, invoke:'
        '\n\n\tpython configure.py -I %s -I %s'
        '\n\nto search the current *and* parent directories for headers.'
        ) % (os.curdir, os.pardir)

    parser = optparse.OptionParser(usage=usage)

    common_options = optparse.OptionGroup(parser, 'Common options')
    common_options.add_option(
        '-3', '--qt3', action='store_const', const=3, dest='qt',
        help=('build for Qt3 and PyQt [default Qt4]'))
    common_options.add_option(
        '-4', '--qt4', action='store_const', const=4, dest='qt',
        default=4,
        help=('build for Qt4 and PyQt4 [default Qt4]'))
    common_options.add_option(
        '-Q', '--qwt-sources', default='', action='store',
        type='string', metavar='/sources/of/qwt',
        help=('compile and link the Qwt source files in'
              ' /sources/of/qwt statically into PyQwt'))
    common_options.add_option(
        '-I', '--extra-include-dirs', default=[], action='append',
        type='string', metavar='/usr/lib/qt3/include/qwt',
        help=('add an extra directory to search for headers'
              ' (the compiler must be able to find the Qwt headers'
              ' without the -Q option)'))
    common_options.add_option(
        '-L', '--extra-lib-dirs', default=[], action='append',
        type='string', metavar='/usr/lib/qt3/lib',
        help=('add an extra directory to search for libraries'
              ' (the linker must be able to find the Qwt library'
              ' without the -Q option)'))
    common_options.add_option(
        '-j', '--jobs', default=0, action='store',
        type='int', metavar='N',
        help=('concatenate the SIP generated code into N files'
              ' [default 1 per class] (to speed up make by running '
              ' simultaneous jobs on multiprocessor systems)'))
    parser.add_option_group(common_options)

    make_options = optparse.OptionGroup(parser, 'Make options')
    make_options.add_option(
        '--debug', default=False, action='store_true',
        help='enable debugging symbols [default disabled]')
    make_options.add_option(
        '--extra-cflags', default=[], action='append',
        type='string', metavar='EXTRA_CFLAG',
        help='add an extra C compiler flag')
    make_options.add_option(
        '--extra-cxxflags', default=[], action='append',
        type='string', metavar='EXTRA_CXXFLAG',
        help='add an extra C++ compiler flag')
    make_options.add_option(
        '-D', '--extra-defines', default=[], action='append',
        type='string', metavar='HAS_EXTRA_SENSORY_PERCEPTION',
        help='add an extra preprocessor definition')
    make_options.add_option(
        '-l', '--extra-libs', default=[], action='append',
        type='string', metavar='extra_sensory_perception',
        help='add an extra library')
    make_options.add_option(
        '--extra-lflags', default=[], action='append',
        type='string', metavar='EXTRA_LFLAG',
        help='add an extra linker flag')
    parser.add_option_group(make_options)

    sip_options = optparse.OptionGroup(parser, 'SIP options')
    sip_options.add_option(
        '-x', '--excluded-features', default=[], action='append',
        type='string', metavar='EXTRA_SENSORY_PERCEPTION',
        help=('add a feature for SIP to exclude'
              ' (normally one of the features in sip/features.sip)'))
    sip_options.add_option(
        '-t', '--timelines', default=[], action='append',
        type='string', metavar='EXTRA_SENSORY_PERCEPTION',
        help=('add a timeline option for SIP'
              ' (normally one of the timeline options in sip/timelines.sip)'))
    sip_options.add_option(
        '--sip-include-dirs', default=[],
        action='append', type='string', metavar='SIP_INCLUDE_DIR',
        help='add an extra directory for SIP to search')
    sip_options.add_option(
        '--trace', default=False, action='store_true',
        help=('enable trace of the execution of the bindings'
              ' [default disabled]'))
    parser.add_option_group(sip_options)
    
    detection_options = optparse.OptionGroup(parser, 'Detection options')
    detection_options.add_option(
        '--disable-numarray', default=False, action='store_true',
        help='disable detection and use of numarray [default enabled]'
        )
    detection_options.add_option(
        '--disable-numeric', default=False, action='store_true',
        help='disable detection and use of Numeric [default enabled]'
        )
    detection_options.add_option(
        '--disable-numpy', default=False, action='store_true',
        help='disable detection and use of NumPy [default enabled]'
        )
    parser.add_option_group(detection_options)

    install_options = optparse.OptionGroup(parser, 'Install options')
    install_options.add_option(
        '--module-install-path', default='', action='store',
        help= 'specify the install directory for the Python modules'
        )
    parser.add_option_group(install_options)

    options, args =  parser.parse_args()
    
    # tweak some of the options to facilitate later processing
    if options.jobs < 1:
        options.jobs = ''
    else:
        options.jobs = '-j %s' % options.jobs
        
    options.excluded_features = [
        ('-x %s' % f) for f in options.excluded_features
        ]

    # SIP assumes POSIX style path separators
    options.sip_include_dirs = [
        ('-I %s' % f).replace('\\', '/') for f in options.sip_include_dirs
    ]
    
    options.timelines = [
        ('-t %s' % t) for t in options.timelines
        ]

    if options.trace:
        options.trace = '-r'
        options.extra_defines.append('TRACE_PYQWT')
    else:
        options.trace = ''

    options.modules = []
    options.subdirs = []
    
    return options, args

# parse_args()


def main():
    """Generate the build tree and the Makefiles
    """
    options, args = parse_args()
    
    print 'Command line options:'
    pprint.pprint(options.__dict__)
    print

    configuration = get_pyqt_configuration(options)
    
    options = check_sip(configuration, options)
    options = check_os(configuration, options)
    options = check_compiler(configuration, options)
    options = check_numarray(configuration, options, 'PyQwt')
    options = check_numeric(configuration, options, 'PyQwt')
    options = check_numpy(configuration, options, 'PyQwt')
    options = check_iqt(configuration, options)
    options = check_qwt(configuration, options)
    if not options.module_install_path:
        options.module_install_path = os.path.join(
            configuration.pyqt_mod_dir, 'Qwt5')

    print
    print 'Extended command line options:'
    pprint.pprint(options.__dict__)
    print
    print 'The following modules will be built: %s.' % options.modules
    print
    setup_iqt_build(configuration, options, 'PyQwt')
    print
    setup_qwt5_build(configuration, options, 'PyQwt')
    print
    setup_parent_build(configuration, options)
    print
    print 'Great, run make or nmake to build and install PyQwt.'

# main()
    

if __name__ == '__main__':
    try:
        main()
    except Die, info:
        print info
        sys.exit(1)
    except:
        for entry in traceback.extract_tb(sys.exc_info()[-1]):
            if 'optparse.py' in entry[0]:
                sys.exit(0)
        else:
            print (
                'An internal error occured.  Please report all the output\n'
                'from the program, including the following traceback, to\n'
                'pyqwt-users@lists.sourceforge.net'
                )
            traceback.print_exc()
            sys.exit(1)
        
# Local Variables: ***
# mode: python ***
# End: ***
