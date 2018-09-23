#include <catch/catch.hpp>

#include <string>

using namespace std;

TEST_CASE("module " "unique name", "[tag1][foo][bar]" )
{
  CHECK(1 > 0);
  REQUIRE(23 == 100 - 77);
  CHECK(!false);
  string s;
  CHECK_NOTHROW(string("hello").size());
  CHECK_THROWS_AS(s.at(1), std::logic_error);
}

static void test_file(const char *filename)
{
    CHECK(string(filename).empty() == false);
}
static const array<const char*, 2> filenames = { "foo", "bar" };
// run with -s to get some details on the sub-cases
// run with -c to filter a certain case
TEST_CASE("module " "parametrized test", "[tag1]" )
{
  size_t i = 0;
  for (auto filename : filenames) {
      SECTION(string("compare-") + to_string(i)) {
          test_file(filename);
      }
      ++i;
  }
}
