.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")
# ##############################################################################
# # GENERAL
# ##############################################################################
VERSION="0.1.5"
.PHONY: help
help: makefile
	@echo
	@echo " Available actions in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## init: Install missing dependencies.
init:
	cargo install cargo-ndk
	@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi
## :

## all: Compile iOS, Android & Linux binaries
all: init unit-test jniLibs xcframework zip copy-build
 
linux:
	@echo "[Creating linux binary ...] $@"
	docker stop bwcbuilder01 ; docker rm bwcbuilder01; \
	docker build --platform linux/x86_64 --build-arg USER_ID=$(shell id -u) --build-arg VERSION=$(VERSION) -t bwcbuilder . && \
	docker run --platform linux/x86_64 --name bwcbuilder01 -v $(shell pwd):/boltz-dart bwcbuilder ; docker stop bwcbuilder01 ; docker rm bwcbuilder01
	@echo "[Done ✅]"

jniLibs:
	@echo "[Creating android jniLibs ...] $@"
	sh android.sh $(VERSION)
	@echo "[Done ✅]"

xcframework:
	@echo "[Creating xcframework ...] $@"
	sh darwin.sh $(VERSION)
	@echo "[Done ✅]"

zip:
	@echo "[COMPRESSING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh compress.sh $(VERSION)
	@echo "[Done ✅]"
	
unit-test:
	@echo "[Creating unit-test binaries ...] $@"
	sh unit-test.sh $(VERSION)
	@echo "[Done ✅]"

copy-build:
	@echo "[COPYING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh copy.sh $(VERSION)
	@echo "[Done ✅]"
