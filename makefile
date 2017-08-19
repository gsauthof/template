
###########################################################################
# Default Variables
###########################################################################

# good C language warning defaults for GCC
#
# The -Werror= options are already enabled as warnings - they are
# treated as errors to underscore their severity
#
# also useful:
#   -flto since it enables -Wlto-type-mismatch
#
CFLAGSW_GCC = -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess \
    -fstrict-aliasing

# - with C++, -Wwrite-strings is enabled by default
# - -Wall also includes -Wdelete-non-virtual-dtor which warns only actual
#   problematic uses - in contrast to  -Wnon-virtual-dtor
CXXFLAGSW_GCC = -Wall -Wextra \
    -Wno-unused-local-typedefs \
    -Wno-parentheses -Wno-missing-braces \
    -Wfloat-equal \
    -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Wnon-virtual-dtor \
    -Werror=multichar -Werror=sizeof-pointer-memaccess \
    -Wmissing-declarations \
    -fstrict-aliasing

# add to CFLAGS/CXXFLAGS/LDFLAGS
SANFLAGS = -fsanitize=address -fsanitize=undefined

# add to CFLAGS/CXXFLAGS/LDFLAGS
STACKFLAGS = -fstack-protector-strong

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

