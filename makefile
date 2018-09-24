
###########################################################################
# Default Variables
###########################################################################

# Good C language warning defaults for GCC
#
# The -Werror= options are already enabled as warnings by -Wall - they are
# treated as errors to underscore their severity.
#
# Also enabled by -Wall (but not documented as such): -Wuninitialized
#
# -O1 (or higher) is important since some warning modes don't get the required
# input without any optimizations. Of course, can be overridden by a following
# optimization option.
# -Og is an alternative.
# -fno-omit-frame-pointer might be necessary for nicer stacktraces with some
#  optimization levels
#
# Not a good default, but also useful:
#   -flto since it enables -Wlto-type-mismatch
#   -Wduplicated-branches because it's too new (GCC >= 7)
#
CFLAGSW_GCC = -O1 -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -fstrict-aliasing

# - with C++, -Wwrite-strings is enabled by default
# - -Wall also includes -Wdelete-non-virtual-dtor - it basically
#   warns about a subset of -Wnon-virtual-dtor - and there doesn't
#   seem to be a valid use case where ignoring it would be ok, thus,
#   it's promoted to a Werror.
#
# Not a good default, but also useful:
#   -Weffc++ because it's actually about 7 separate issues where some are very
#     useful but some produce many false-positives (and miss C++11 support),
#     especially regarding initialization of already initialized members
#     cf. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=16166
#     -> when resolved there are perhaps some improved
#        and more fine grained options
CXXFLAGSW_GCC = -O1 -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wno-unused-local-typedefs \
    -Wfloat-equal \
    -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Wnon-virtual-dtor -Wmissing-declarations \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -Werror=delete-non-virtual-dtor \
    -fstrict-aliasing

# add to CFLAGS/CXXFLAGS/LDFLAGS
SANFLAGS = -fsanitize=address -fsanitize=undefined

# add to CFLAGS/CXXFLAGS/LDFLAGS
# even a low optimization level like -O1 can help to better trigger
# the canary for certain stackoverflows
STACKFLAGS = -O1 -fstack-protector-strong

# add to CFLAGS/CXXFLAGS/LDFLAGS
FORTFLAGS = -D_FORTIFY_SOURCE=2

CFLAGS   += $(CFLAGSW_GCC)
CXXFLAGS += $(CXXFLAGSW_GCC)


LINKCC = $(CC)

###########################################################################
# Default Rules
###########################################################################

# delete all default suffixes, thus disable all default rules
.SUFFIXES:

# - inspired by https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html - the differences:
# - defined as pattern rules and not as suffix rules
# - variables like CPPFLAGS, CFLAGS etc. have doppelgänger like
#   CPPFLAGS2, CFLAGS2 etc. for simplifying adding additional switches to
#   those on the command line (similar to how automake/cmake/meson behave
#   when you set CFLAGS, etc. on the command line)

%.o: %.c
	$(CC) $(CPPFLAGS) $(CPPFLAGS2) $(CFLAGS) $(CFLAGS2) -c $< -o $@

COMPILE.CXX = $(CXX) $(CPPFLAGS) $(CPPFLAGS2) $(CXXFLAGS) $(CXXFLAGS2) -c $< -o $@
%.o: %.cc
	$(COMPILE.CXX)
%.o: %.cxx
	$(COMPILE.CXX)

# METALINK allows to configure a tool for instrumentalization or
# another helper
LINK.O = $(METALINK) $(LINKCC) $(LDFLAGS) $(LDFLAGS2) $^ $(LDLIBS) -o $@

%: %.o
	$(LINK.O)

###########################################################################
# Default Targets
###########################################################################

# don't delete intermediate files (produced by transitive rule invocations)
.SECONDARY:

# make sure that all is the default target ...
.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf $(TEMP)

