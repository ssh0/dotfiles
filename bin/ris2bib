#!/usr/bin/env python
# encoding: utf-8

"""
ris2bib.py

Copyright (C) 2011, 2012 Daniel O'Hanlon	

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

"""
Takes .ris files as first argument in the form 'name.ris' and outputs files
in the bibtex format in the form 'name.bib'. Currently assuming Nature article
format for ease of programming.

Uses .ris tag information from: http://en.wikipedia.org/wiki/RIS_(file_format)

Usage is ris2bib.py [FILE] [-v]

D.P O'Hanlon
Sun 13 May 2012 14:10:52 BST

"""

import sys
import os
import re

def main(argv = sys.argv):

	argc = len(argv)

	if (argc == 1):
		print "Usage is ris2bib.py [FILE] [-v]"
	else:
		try:
			ris = open(argv[1],'r+')
		except:
			print "Error: No such file."
			return
		
		if (argc == 3 and argv[2] == '-v'):
			verbose = True
		else:
			verbose = False

		entries = r2b_read(ris, verbose)

		ris.close()

		bib_filename = argv[1][:-4]+'.bib' # strip and replace extension

		r2b_write(entries, bib_filename)

def r2b_read(ris, verbose):

	"""
	Reads in a .ris file and returns a .bib format 'entries' dictionary with the appropriate information.
	"""

	entries = dict()
	entries['authors']=list() # Allows for multiple authors

	for line in ris:
		if re.match("PY",line):
			entries['year'] = line[6:10]
		elif re.match("AU",line):
			entries['authors'].append(line[6:-1]) # minus one to remove newline
		elif re.match("VL",line):
			entries['volume'] = line[6:-1]
		elif re.match("TI",line):
			entries['title'] = line[6:-1]
		elif re.match("JA",line):
			entries['journal'] = line[6:-1]
		elif re.match("IS",line):
			entries['number'] = line[6:-1]
		elif re.match("SP",line):
			entries['startpage'] = line[6:-1]
		elif re.match("EP",line):
			entries['endpage'] = line[6:-1]
		elif re.match("UR",line):
			entries['url'] = line[6:-1]
		elif verbose:
			print 'Unparsed line: ' + line[:-1]
	return entries
		
def r2b_write(entries,bib_filename):

	"""
	Writes the .bib formatted dictionary to file using .bib file syntax.
	"""

	bib = open(bib_filename,'w+') # strip and replace extension

	bib.write('@ARTICLE{' + entries['authors'][0][:entries['authors'][0].index(',')] + \
		str(entries['year']) + ",") # get surname of first author slicing to ','
	bib.write('\n\tauthor=\t\"'+entries['authors'][0])
	for entry in entries['authors'][1:]:
		bib.write(" and " + entry)
	bib.write("\",")
	bib.write('\n\tyear=\t\"'+ entries['year'] + "\",")
	bib.write("\n\ttitle=\t\"" + entries['title'] + "\",")
	bib.write("\n\tjournal=\t\"" + entries['journal'] + "\",")
	bib.write("\n\tvolume=\t\"" + entries['volume'] + "\",")
	bib.write("\n\tnumber=\t\"" + entries['number'] + "\",")
	bib.write("\n\tpages=\t\"" + entries['startpage'] + "--" + \
		entries['endpage'] + "\",")
	bib.write("\n\turl=\t\t\"" + entries['url'] + "\",")
	bib.write("\n}\n")

	bib.close()			

if __name__ == '__main__':
	main()	
