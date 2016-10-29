#!/bin/bash

# /bin/bash is more portable because:
# - most systems either have /bin/bash or it links
#   to /usr/bin/bash
# - some systems don't have /usr/bin/bash (e.g. some Debian ones)
# - some systems have a crappy non-conforming /bin/sh (e.g. Solaris <= 10)
# - even old bash versions have more useful features than ksh88,
#   {/usr,}/bin/ksh might be ksh88 if it is even available (most systems
#   don't install it by default)

# alternative:

#!/usr/bin/env bash

# exit on erroring commands and undefined variables
set -eu
#set -x


function cleanup
{
  : # do some work
}
# in bash: EXIT also matches INT TERM
# zsh/dash: EXIT doesn't mach INT TERM
# everywhere: EXIT INT TERM yields 2 cleanup calls on SIGINT/TERM
#trap cleanup EXIT INT TERM
trap cleanup EXIT


