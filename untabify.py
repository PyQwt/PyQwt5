#!/usr/bin/env python

import optparse
import os
import sys

def parse_invokation():
    """Return the parsed options and arguments from the command line
    """

    usage = (
        '%prog [-h] [-t N] directory (one or more file name extensions)'
        )

    parser = optparse.OptionParser(usage=usage)
    parser.add_option(
        '-t', '--tabs', default=8, action='store',
        type='int', metavar='N',
        help='Have tabs N characters apart [default 8]'
        )

    options, arguments = parser.parse_args()

    if len(arguments) < 2:
        parser.print_help()
        sys.exit(1)

    return options, arguments

# parse_invokation()


def process(filename, tabsize):
    """Stolen from Python-X.Y.Z/Tools/scripts/untabify
    """
    try:
        f = open(filename)
        text = f.read()
        f.close()
    except IOError, msg:
        print "%r: I/O error: %s" % (filename, msg)
        return
    newtext = text.expandtabs(tabsize)
    if newtext == text:
        return
    f = open(filename, "w")
    f.write(newtext)
    f.close()
    print filename

# process()
    
def main():
    options, arguments = parse_invokation()
    top = os.path.abspath(arguments[0])
    extensions = arguments[1:]
    for root, directories, files in os.walk(top):
        for file in files:
            _, extension = os.path.splitext(file)
            if extension in extensions:
                process(os.path.join(root, file), options.tabs)

# main

if __name__ == "__main__":
    main()

# Local Variables: ***
# mode: python ***
# End: ***
