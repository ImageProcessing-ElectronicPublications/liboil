CFLAGS += -O3 -Wall -pedantic
LDFLAGS += -s

all:  liboilresample.so.0 oilscale oiltest oilbenchmark
liboilresample.so.0: src/oil_resample.c src/oil_libjpeg.c src/oil_libpng.c
	$(CC) -shared -Wl,-soname,$@ $(CFLAGS) $^ -o $@ $(LDFLAGS) -ljpeg -lpng -lm
oilscale: liboilresample.so.0  src/imgscale.c
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
oiltest: liboilresample.so.0 src/test.c
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
oilbenchmark: liboilresample.so.0 src/benchmark.c
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
oilview: liboilresample.so.0 src/oilview.c
	$(CC) $(CFLAGS) `pkg-config --cflags gtk+-3.0` $^ -o $@ $(LDFLAGS) `pkg-config --libs gtk+-3.0` -lX11
clean:
	rm -rf oiltest oilbenchmark oiltest.dSYM liboilresample.so.0 oilscale oilview
