MKHOWTO := $(HOME)/CVS/PyQwt/BUILD/Python-2.5.2/Doc/tools/mkhowto

SOURCES := \
	pyqwt/configure.help \
	pyqwt/copyright.tex \
	pyqwt/pyqwt.tex


doc: $(SOURCES)
	if [ ! -e html/pyqwt ]; then mkdir -p html/pyqwt; fi
	(cd html/pyqwt; rm -f *.css *.dat *.html *.idx *.old *.pl *.gif)
	cp -p html/icons/*.png html/pyqwt
	python $(MKHOWTO) -D --html --dir html/pyqwt \
	    --image-type png --favicon pyfav.png \
	    --up-link http://pyqwt.sourceforge.net --up-title "Pyqwt Home" \
	    pyqwt/pyqwt.tex
	(cd html/pyqwt; rm -f *.dat *.idx *.old *.pl *.gif)
	python nospam.py html/pyqwt/*.html
	rm -f pyqwt.l2h*
	date -u "+%Y-%m-%d %T" > doc

htdoc: doc $(SOURCES)
	if [ ! -e html/htdoc ]; then mkdir -p html/htdoc; fi
	(cd html/htdoc; rm -f *.css *.dat *.html *.idx *.old *.pl *.gif)
	cp -pr html/pyqwt/* html/htdoc
	python sourceforge.py html/htdoc/*.html
	date -u "+%Y-%m-%d %T" > htdoc

pyqwt/configure.help: ../configure/configure.py
	python ../configure/configure.py --help > pyqwt/configure.help

# EOF
