# GNUmakefile for PyQwt
#
# There are at least two options to log the output of make:
#
# (1) Invoke make and tie stderr to stdout and redirect stdout to log.txt:
#       make all 2&>1 >log.txt
#     However, you do not see what is going on.
#
# (2) Use script to capture all screen output of make to log.txt:
#       script -c 'make all' log.txt
#     The script command appeared in 3.0BSD and is part of util-linux.

# To compile and link the Qwt sources statically into Pyqwt.
QWT := ../qwt-5.2

JOBS := 1
UNAME := $(shell uname)

REVISION := 596

ifeq ($(UNAME),Linux)
JOBS := $(shell getconf _NPROCESSORS_ONLN)
endif

ifeq ($(UNAME),Darwin)
JOBS := $(shell sysctl -n hw.ncpu)
endif

.PHONY: dist qwt-5.0 qwt-5.1 qwt-5.2

all: 3 4

debug: 3d 4d

trace: 3t 4t

3:
	cd configure \
	&& python configure.py -3 -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

4:
	cd configure \
	&& python configure.py -4 -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)


3d:
	cd configure \
	&& python configure.py -3 --debug -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

4d:
	cd configure \
	&& python configure.py -4 --debug -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

3t:
	cd configure \
	&& python configure.py --debug --trace -3 -Q $(QWT) \
	&& $(MAKE)

4t:
	cd configure \
	&& python configure.py --debug --trace -4 -Q $(QWT) \
	&& $(MAKE)

# Installation
install-3: 3
	make -C configure install

install-4: 4
	make -C configure install

install: install-3 install-4

install-3d: 3d
	make -C configure install

install-4d: 4d
	make -C configure install

install-debug: install-3d install-4d

install-3t: 3t
	make -C configure install

install-4t: 4t
	make -C configure install

install-trace: install-3t install-4t

# SVN
qwt-5.0:
	(cd tmp/qwt-5.0; svn up -r $(REVISION))
	rm -rf old-5.0; mv qwt-5.0 old-5.0
	rm -rf qwt-5.0; cp -pr tmp/qwt-5.0 qwt-5.0
	python untabify.py -t 4 qwt-5.0 .cpp .h .pro
	patch -p0 --fuzz=10 -b -z .pyqwt <pyqwt-5.0.patch
	(cd qwt-5.0/doc; cp ../COPYING .; cp ../INSTALL .)
	(cd qwt-5.0/doc; doxygen -u Doxyfile; doxygen Doxyfile)
	(cd qwt-5.0; rm -rf admin doc/images doc/latex doc/man)
	find qwt-5.0 -name .svn \
		-o -name '*.map' \
		-o -name '*.md5' | xargs rm -rf

qwt-5.1:
	(cd tmp/qwt-5.1; svn up -r $(REVISION))
	rm -rf old-5.1; mv qwt-5.1 old-5.1
	rm -rf qwt-5.1; cp -pr tmp/qwt-5.1 qwt-5.1
	python untabify.py -t 4 qwt-5.1 .cpp .h .pro
	patch -p0 --fuzz=10 -b -z .pyqwt <pyqwt-5.1.patch
	(cd qwt-5.1/doc; cp ../COPYING .; cp ../INSTALL .)
	(cd qwt-5.1/doc; doxygen -u Doxyfile; doxygen Doxyfile)
	(cd qwt-5.1; rm -rf admin doc/images doc/latex doc/man)
	find qwt-5.1 -name .svn \
		-o -name '*.map' \
		-o -name '*.md5' | xargs rm -rf

qwt-5.2:
	(cd tmp/qwt-5.2; svn up -r $(REVISION))
	rm -rf old-5.2; mv qwt-5.2 old-5.2
	rm -rf qwt-5.2; cp -pr tmp/qwt-5.2 qwt-5.2
	python untabify.py -t 4 qwt-5.2 .cpp .h .pro
	patch -p0 --fuzz=10 -b -z .pyqwt <pyqwt-5.2.patch
	(cd qwt-5.2/doc; cp ../COPYING .; cp ../INSTALL .)
	(cd qwt-5.2/doc; doxygen -u Doxyfile; doxygen Doxyfile)
	(cd qwt-5.2; rm -rf admin doc/images doc/latex doc/man)
	find qwt-5.2 -name .svn \
		-o -name '*.map' \
		-o -name '*.md5' | xargs rm -rf

# build a distribution tarball
dist: distclean install
	(cd sphinx; make clean; make; make latex)
	(cd sphinx/build/latex; make all-pdf)
	python setup.py sdist --formats=gztar

clean:
	find . -name '*~' | xargs rm -f

distclean: clean
	find . -name '.#*' -o -name '*.pyc' | xargs rm -f
	rm -rf configure/*qt{3,4} configure/qwt_* configure/*.cpp

# EOF
