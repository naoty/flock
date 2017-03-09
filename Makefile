default: build

build:
	swift build
	mkdir -p bin
	cp .build/debug/flock bin/
	tar czvf flock.tar.gz bin

clean:
	swift build --clean
	rm -rf bin
	rm -rf Packages
	rm flock.tar.gz

