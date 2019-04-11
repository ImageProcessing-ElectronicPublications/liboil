CFLAGS += -O3 -march=native -Wall -pedantic

all:  liboilresample.so.0 oiltest oilscale
liboilresample.so.0: src/oil_resample.c src/oil_libjpeg.c src/oil_libpng.c
	$(CC) -shared -Wl,-soname,$@ $(CFLAGS) $^ -o $@ $(LDFLAGS) -ljpeg -lpng -lm
oiltest: liboilresample.so.0 src/test.c
	$(CC) $(CFLAGS) $^ -o $@ -lm
oilscale: liboilresample.so.0  src/imgscale.c
	$(CC) $(CFLAGS) $^ -o $@
oilview: liboilresample.so.0 src/oilview.c
	$(CC) $(CFLAGS) `pkg-config --cflags gtk+-3.0` $^ -o $@ $(LDFLAGS) `pkg-config --libs gtk+-3.0` -lX11
clean:
	rm -rf oiltest oiltest.dSYM liboilresample.so.0 oilscale oilview
