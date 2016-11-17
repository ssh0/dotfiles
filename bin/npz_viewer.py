#!/usr/bin/env python
# -*- coding:utf-8 -*-
#=#=#=
# npz_viewer.py - Simple extracter for compressed (format: `.npz`) file.
#
# Usage:
#
#     npz_viewer.py some_data.npz
#
#=#=
# written by Shotaro Fujimoto
# 2016-11-17

import argparse
import os.path
import numpy as np
from pprint import pprint


def extract(f):
    if os.path.splitext(f)[-1] != '.npz':
        raise TypeError("Input file must be '.npz' file")

    data = np.load(f)
    pprint({k: data[k] for k in data})
    data.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Simple extracter for compressed (`.npz`: numpy) file.')
    parser.add_argument('infile', metavar='foo.npz',
                        type=str, nargs=1,
                        help='file name to extract its contents')
    args = parser.parse_args()
    extract(args.infile[0])
