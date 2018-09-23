// with Catch2 cloned into a subdirectory compile with:
// CPPFLAGS += -ICatch2/single_include

// use default main:
#define CATCH_CONFIG_MAIN

// System-wide location for Catch _and_ Catch2 on Fedora:
// #include <catch/catch.hpp>
// With Catch2 cloned into a subdirectory:
#include <catch2/catch.hpp>

/*
// use custom main:
#define CATCH_CONFIG_RUNNER
#include <catch/catch.hpp>

// use custom main:
// (e.g. for manipulating arguments, extra setup etc.)
int main(int argc, char **argv)
{
  int result = Catch::Session().run(argc, argv);
  return result;
}
*/
