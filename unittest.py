#!/usr/bin/env python3

# https://docs.python.org/3/library/unittest.html
import unittest

#import logging
#logging.basicConfig(level = logging.DEBUG)

class My_First_Test_Group(unittest.TestCase):

  # Standard fixture
  #def setUp(self):
  #  pass
  #def tearDown(self):
  #  pass

  #@classmethod
  #def setUpClass(cls):
  #  pass
  #def tearDownClass(cls):
  #  pass

  # each method named with a test prefix
  # is executed, by default
  def test_simple(self):
    # the usual flower bouquet of assertion macros
    self.assertTrue(2 < 3)
    self.assertFalse(2 > 3)
    self.assertEqual(2, 1+1)
    self.assertIn(3, [1, 2, 3])

  def test_another(self):
    self.assertEqual(3, 4-1)

# execute all the tests in one file
if __name__ == '__main__':
    unittest.main()

# Alternatively, call something like
#
#    python3 -m unittest
#    python3 -m unittest filename
#    python3 -m unittest modulename
#    python3 -m unittest ...
#


# Or 'emulate' the -m unittest via something like:
#
#  unittest.main(module=None, argv=[sys.argv[0], 'discover',
#      '--start-directory',  src_dir + '/test', '--pattern', '*.py',
#      ])

