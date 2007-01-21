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
QWT := ../qwt-svn

JOBS := 1
UNAME := $(shell uname)

REVISION := 39

ifeq ($(UNAME),Linux)
JOBS := $(shell getconf _NPROCESSORS_ONLN)
endif

ifeq ($(UNAME),Darwin)
JOBS := $(shell sysctl -n hw.ncpu)
endif

.PHONY: dist qwt-svn

all: 3 4

trace: 3t 4t

3:
	cd configure \
	&& python configure.py -3 -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

4:
	cd configure \
	&& python configure.py -4 -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

3t:
	cd configure \
	&& python configure.py --trace -3 -Q $(QWT) \
	&& $(MAKE)

4t:
	cd configure \
	&& python configure.py --trace -4 -Q $(QWT) \
	&& $(MAKE)

# Installation
install-3: 3
	make -C configure install

install-4: 4
	make -C configure install

install: install-3 install-4

install-3t: 3t
	make -C configure install

install-4t: 4t
	make -C configure install

install-trace: install-3t install-4t

# SVN
qwt-svn:
	(cd tmp/qwt-svn; svn up -r $(REVISION))
	rm -rf qwt-old; mv qwt-svn qwt-old
	rm -rf qwt-svn; cp -pr tmp/qwt-svn qwt-svn
	python untabify.py -t 4 qwt-cvs .cpp .h .pro
	patch -p0 --fuzz=10 -b -z .pyqwt <pyqwt.patch
	(cd qwt-svn/doc; doxygen -u Doxyfile; doxygen Doxyfile)
	(cd qwt-svn; rm -rf admin doc/images doc/latex doc/man)
	find qwt-svn -name .svn \
		-o -name .cvsignore \
		-o -name '*.map' \
		-o -name '*.md5' | xargs rm -rf

# build a distribution tarball
dist: all distclean all
	(cd Doc; rm doc; make)
	sed "s|@VERSION@|$$(date '+%Y%m%d')|g" <PyQwt5.spec.in >PyQwt5.spec
	python setup.py sdist --formats=gztar

clean:
	find . -name '*~' | xargs rm -f

distclean: clean
	find . -name '*.pyc' | xargs rm -f
	rm -rf configure/*qt{3,4}

# EOF
