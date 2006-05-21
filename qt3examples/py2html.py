#!/usr/bin/env python

# This is a trimmed down version of Marc-Andre Lemburg's py2html.py.
# The original code can be found at http://starship.python.net/~lemburg/.
#
# Borrow (or steal?) PyFontify.py from reportlab.lib.

import PyFontify
import sys
  
pattern="""<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<html>
<head>
<title>%(source)s</title>
</head>
<body bgcolor=white>
<pre>
%(target)s
</pre>
</body>
</html>
"""

formats = { 'comment': "<font color=blue>%s</font>",
            'identifier': "<font color=red>%s</font>",
            'keyword': "<b>%s</b>",
            'string': "<font color=green>%s</font>" }

def escape_html(text):
        t = (('&','&amp;'), ('<','&lt;'), ('>','&gt;'))
        for x,y in t:
            text = y.join(text.split(x))
        return text

def py2html(source):
    f = open(source)
    text = f.read()
    f.close()
    tags = PyFontify.fontify(text)
    done = 0
    chunks = []
    for tag, start, end, sublist in tags:
        chunks.append(escape_html(text[done:start]))
        chunks.append(formats[tag] % escape_html(text[start:end]))
        done = end
    chunks.append(escape_html(text[done:]))
        
    dict = { 'source' : source, 'target' : ''.join(chunks) }
    f = open(source + '.html', 'w')
    f.write(pattern % dict)
    f.close()

if __name__ == '__main__':

    if len(sys.argv) == 1:
        print "Usage: ./py2html.py files"
        print "\tfiles is a list of Python source files."
        sys.exit(1)

    for file in sys.argv[1:]:
        py2html(file)
