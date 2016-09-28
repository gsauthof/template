#################################################################
# Prolog
#################################################################

#cmake_minimum_required(VERSION 2.8)
cmake_minimum_required(VERSION 3.0.2)
#cmake_minimum_required(VERSION 3.4.1)

# some cmake tests also need a C compiler
project(XXX_name CXX C)
#project(XXX_name C)

#################################################################
# General Settings
#################################################################

# -Wall not portable between all compilers 
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED on)
#set(CMAKE_CXX_EXTENSIONS off)

# set custom variable:
# set(FOO_SRC a.cc b.cc)

# Diagnostics
message("CMAKE_SYSTEM_PREFIX_PATH: ${CMAKE_SYSTEM_PREFIX_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

#################################################################
# Conditional Settings
#################################################################

# test if shared library interdependencies are missing
# and thus would yield undefined symbol warnings on creating
# a shared library (that depends on other shared libraries)
# on Windows/Mac OS X
#if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
#  set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--no-undefined")
#endif()
#if(CMAKE_SYSTEM_NAME STREQUAL "SunOS")

# test if running on a certain platform
#if(WIN32)
#endif()

# test if CMakeLists.txt was included via add_subdirectory()
#if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
#endif()

# other ids: Clang
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
    AND CMAKE_CXX_COMPILER_VERSION VERSION_LESS "4.9")
  message(FATAL_ERROR "You need at least version 4.9 when compiling with GCC")
endif()

#################################################################
# Additional CMake modules
#################################################################

#include(CheckFunctionExists)

# cf. cmake-modules
#include (${CMAKE_SOURCE_DIR}/cmake/modules/coverage.cmake)
#include (${CMAKE_SOURCE_DIR}/cmake/modules/sanitize.cmake)

# cf. cmake-ragel
#set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/ragel")

#add_subdirectory(libixxx)
#add_subdirectory(libixxxutil)

#################################################################
# Test Features
#################################################################

#check_function_exists(wcsdup HAVE_WCSDUP)

#find_package(PkgConfig)
#pkg_search_module(BSD libbsd)
#if (BSD_LIBRARIES)
#  set(HAVE_CLOSEFROM 1)
#endif()

# by default read from CMAKE_CURRENT_SOURCE_DIR
# and created in CMAKE_BINARY_DIR
# cf. e.g. somake, libxfsx
configure_file(config.h.in config.h)

#################################################################
# Find required packages/libraries
#################################################################

#find_library(XML2_LIB NAMES xml2 HINTS /opt/csw/lib)
#find_path(XML2_INCLUDE_DIR libxml/xmlreader.h PATH_SUFFIXES libxml2
#  HINTS /opt/csw/include)

#find_path(LUA_INCLUDE_DIR lua.h
#  PATHS /usr/include/luajit-2.0 NO_DEFAULT_PATH)

#find_library(CLNTSH_LIB NAMES clntsh
#  PATHS $ENV{ORACLE_HOME} $ENV{ORACLE_HOME}/lib)
#find_path(OCI_INCLUDE_DIR NAMES oci.h
#  HINTS $ENV{ORACLE_HOME}/sdk/include $ENV{ORACLE_HOME}/rdbms/public)

find_package(Boost 1.55
    COMPONENTS
      unit_test_framework
      regex
      filesystem
      system
  REQUIRED)

# Code Generators:

#find_package(RAGEL 6.6 REQUIRED)
#RAGEL_TARGET(XXXfoo
#  foo.rl 
#  ${CMAKE_CURRENT_BINARY_DIR}/foo.cc
#  )

#find_package(FLEX 2.5.37 REQUIRED)
#find_package(BISON 2.6.4 REQUIRED)
#BISON_TARGET(my_parser my_parser.y ${CMAKE_CURRENT_BINARY_DIR}/my_parser.cc)
#FLEX_TARGET(my_lexer my_lexer.l ${CMAKE_CURRENT_BINARY_DIR}/my_lexer.cc
#  COMPILE_FLAGS --header-file=${CMAKE_CURRENT_BINARY_DIR}/my_lexer.h)
#ADD_FLEX_BISON_DEPENDENCY(my_lexer my_parser)

# Qt:

#find_package(Qt5Core REQUIRED)     # -> Qt::Core library
#find_package(Qt5Widgets REQUIRED)  # -> Qt::Widgets library
#find_package(Qt5Test REQUIRED)     # -> you get the idea

# cf. tree-model for Qt related commands

#################################################################
# Define Executables
#################################################################

add_executable(XXX_binary
  main.cc
  blah.cc
  #  ${RAGEL_XXXfoo_OUTPUTS}
  )
set_property(TARGET XXX_binary PROPERTY INCLUDE_DIRECTORIES
  ${Boost_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}
  #${XML2_INCLUDE_DIR}
  )
target_link_libraries(XXX_binary
  ${Boost_FILESYSTEM_LIBRARY}
  ${Boost_SYSTEM_LIBRARY}
  #ixxx_static
  #${XML2_LIB}
  )
# add define:
# target_compile_definitions(XXX_binary PRIVATE -D_XOPEN_SOURCE=700)
# or:
# set_target_properties(XXX_binary PROPERTIES COMPILE_DEFINITIONS -D_XOPEN_SOURCE=700)
# for all targets:
# add_definitions(-D_XOPEN_SOURCE=700)

add_executable(ut
  test/main.cc
  test/blah.cc
  )

target_link_libraries(ut
  # comment when custom init function is used
  ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
  )

# for executing it from a quickfix environment
add_custom_target(check COMMAND ut)

# for custom_command cf. e.g. libxfsx

#################################################################
# Define Libraries
#################################################################

add_library(bar STATIC x.cc y.cc z.cc)

add_library(xfsx SHARED ${LIB_SRC})
# library executable might depend on other shared libaries
# in fact, on some systems those depencies must be made explicit
# (e.g. OSX, Windows)
target_link_libraries(xfsx ixxx ixxxutil)

# it is also possible to create both shared and static library version
add_library(xfsx_static STATIC ${LIB_SRC})
set_target_properties(xfsx_static PROPERTIES OUTPUT_NAME xfsx)

#################################################################
# Testing
#################################################################

# cf. e.g. open-mensa, gnu-avl

#################################################################
# Install
#################################################################

# default install prefix is /usr/local
# change it with e.g. -DCMAKE_INSTALL_PREFIX=/usr
install(TARGETS   ${PROJECT_NAME}  RUNTIME DESTINATION bin)
install(FILES     man/man1/make.1          DESTINATION share/man/man1
        RENAME  ${PROJECT_NAME}.1)
install(DIRECTORY example DESTINATION share/doc/${PROJECT_NAME}
)

#################################################################
# Packaging
#################################################################

# set(CPACK...)

# cf. e.g. somake, gnu-avl

include(CPack)


