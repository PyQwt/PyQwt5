#!/usr/bin/env python

import os
import random
import re
import sys

def hide(html):
    """Hide a chunk of HTML text for dumb robots"""

    list = []
    for c in html:
        if random.randrange(2):
            list.append('&#%s;' % ord(c))
        else:
            list.append('&#%s;' % hex(ord(c))[1:])
    return ''.join(list)

def filter(html):
    """Filter all dumb robot readable mail anchors from a HTML text"""

    def replace(m):
        if m.group(1):
            return ('<a %shref="%s">%s</a>' %
                    (m.group(1), hide(m.group(2)), hide(m.group(3))))
        else:
            return ('<a href="%s">%s</a>' %
                    (hide(m.group(2)), hide(m.group(3))))

    # compatible with latex2html mail anchors
    mailRe = re.compile(
        r'<a (class="ulink" )?href="(mailto:.+)"(?:\n *)?>(.+)</a>', re.M)

    return re.sub(mailRe, replace, html)

# filter()

if __name__ == '__main__':
    for name in sys.argv[1:]:
        html = open(name, 'r').read()
        text = filter(html)
        if text != html:
            os.remove(name)
            file = open(name, 'w')
            file.write(text)
            file.close()

# Local Variables: ***
# mode: python ***
# End: ***
