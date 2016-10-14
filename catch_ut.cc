#include <catch/catch.hpp>

#include <string>

using namespace std;

TEST_CASE("module" "unique name", "[tag1][foo][bar]" )
{
  CHECK(1 > 0);
  REQUIRE(23 == 100 - 77);
  CHECK(!false);
  string s;
  CHECK_NOTHROW(string("hello").size());
  CHECK_THROWS_AS(s.at(1), std::logic_error);
}
