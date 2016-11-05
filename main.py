#!/usr/bin/env python3

import argparse
import configparser
import logging
import os
import sys

#import collections # e.g. namedtuple
#import csv
#import json
#import re
#import requests
#import types # e.g. SimpleNamespace

#import wikitextparser as wtp
#import phonenumbers as p
#import pycountry as pyc
#import zeep # SOAP

# Command Line Argument Parsing

def mk_arg_parser():
  p = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='Do some stuff',
        epilog='...')
  p.add_argument('items', metavar='N', type=int, nargs='+',
      help='some positional argument')
  # conditional default, if option not present then None
  p.add_argument('--debug', nargs='?', metavar='FILE',
      const='debug.log', help='log debug messages into file')
  p.add_argument('--sum', dest='accumulate', action='store_const',
      const=sum, default=max,
      help='sum the integers (default: find the max)')
  p.add_argument('--turnon', action='store_true',
      help='get bool flag')
  p.add_argument('--turnoff', action='store_false', default=True,
      help='disable bool flag')
  p.add_argument('--output', '-o', metavar='DIR', required=True,
      help='output directory')
  # if not specified filters == None and filters != []
  p.add_argument('-x', action='append', dest='filters', help='exclude filters')
  p.add_argument('--config', action='append', default=[],
      metavar='FILENAME', help='user specific config file')
  p.add_argument('--global-conf', default='/usr/share/frank/frank.conf',
      metavar='FILENAME', help='global config file')
  p.add_argument('--sys-conf', default='/etc/frank.conf',
      metavar='FILENAME', help='machine specific config file')
  return p

def parse_args(*a):
  arg_parser = mk_arg_parser()
  args = arg_parser.parse_args(*a)
  # sanity check/cleanup arguments
  return args

# Config File Parsing

def read_config(filenames):
  c = configparser.ConfigParser()
  c.read(filenames)
  return c

# Logging

log_format      = '%(asctime)s - %(levelname)-8s - %(message)s'
log_date_format = '%Y-%m-%d %H:%M:%S'

## Simple Setup

# Note that the basicConfig() call is a NOP in Jupyter
# because Jupyter calls it before
#logging.basicConfig(format=log_format, datefmt=log_date_format, level=logging.WARNING)
#log = logging.getLogger(__name__)

## Colored Logging and Optional File Sink

try:
  import colorlog
  have_colorlog = True
except ImportError:
  have_colorlog = False

def mk_formatter():
  f = logging.Formatter(log_format, log_date_format)
  return f

def mk_logger():
  log = logging.getLogger() # root logger
  log.setLevel(logging.DEBUG)
  #log.setLevel(logging.INFO)

  if have_colorlog:
    cformat   = '%(log_color)s' + log_format
    cf = colorlog.ColoredFormatter(cformat, log_date_format,
        log_colors = { 'DEBUG': 'reset', 'INFO': 'reset',
            'WARNING' : 'bold_yellow' , 'ERROR': 'bold_red',
            'CRITICAL': 'bold_red'})

  else:
    cf = logging.Formatter(log_format, log_date_format)

  ch = logging.StreamHandler()
  ch.setLevel(logging.WARNING)
  if os.isatty(2):
    ch.setFormatter(cf)
  else:
    ch.setFormatter(f)
  log.addHandler(ch)

  return logging.getLogger(__name__)

log = mk_logger()

def setup_file_logging(filename):
  log = logging.getLogger()
  fh = logging.FileHandler(filename)
  fh.setLevel(logging.DEBUG)
  f = logging.Formatter(log_format + ' - [%(name)s]', log_date_format)
  fh.setFormatter(f)
  log.addHandler(fh)

# Main entry

def run(args, conf):
  log.debug('Hello Debug')
  log.info('Hello Info')
  log.warn('Hello Warn')
  log.error('Hello Error')
  log.critical('Hello Critical')
  return 0

def main(*a):
  args = parse_args(*a)
  conf = read_config([args.global_conf, args.sys_conf]
    + [os.path.expanduser(x) for x in args.config] )
  if conf.has_section('global'):
    log.debug(conf['global'].get('motd', 'Hello World'))
  return run(args, conf)

def imain(argv, conf):
  args = parse_args(argv)
  return run(args, conf)

if __name__ == '__main__':
  if 'IPython' in sys.modules:
    # do something different when running inside a Jupyter notebook
    pass
  else:
    sys.exit(main())

# definitions for interactive use:
