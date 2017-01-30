#!/usr/bin/env python

import commands
import re
import sys


def make_re(*msgs):
    return re.compile('(%s)' % '|'.join(msgs))

pyflakes_ignore = make_re('unable to detect undefined names')
pyflakes_warning = make_re(
    'imported but unused',
    'is assigned to but never used',
    'redefinition of unused',
)
pep8_ignore = ['E501', 'E111']
# E501: line too long
# E201/E202: space after/before (
# E302: expected 2 blank lines
# E127: continuation line over-indented
# E251
pep8_warning = make_re('E302|E201|E202|E251|E501')


def run(cmd, ignore_re, warning_re):
    output = commands.getoutput(cmd)
    for line in output.splitlines():
        if ignore_re and ignore_re.search(line):
            continue
        elif ': ' in line and warning_re.search(line):
            # convert ERROR to WARNING
            line = '%s: W000 %s' % tuple(line.split(': ', 1))
        print line

run('pyflakes %s' % sys.argv[1], pyflakes_ignore, pyflakes_warning)
print '## pyflakes above, pep8 below ##'
pep8_ignore = ' '.join('--ignore=%s' % i for i in pep8_ignore)
run('pep8 %s --repeat %s' % (pep8_ignore, sys.argv[1]), None, pep8_warning)
