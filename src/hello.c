#include "bench.h"

int
main()
{
	return write(1, "Hello world\n", 12);
}
