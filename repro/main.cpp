#include <boost/charconv/from_chars.hpp>

using namespace boost::charconv;

int main() {
  const char *buffer = "21";
  double v = 0.0;
  from_chars(buffer, buffer + 2, v);
}