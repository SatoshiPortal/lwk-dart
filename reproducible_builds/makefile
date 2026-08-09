.DEFAULT_GOAL := help

.PHONY: help darwin linux android

help:
	@echo "Available reproducible build checks:"
	@echo "  make -f reproducible_builds/makefile darwin"
	@echo "  make -f reproducible_builds/makefile linux"
	@echo "  make -f reproducible_builds/makefile android"

darwin:
	./reproducible_builds/reproduce-darwin.sh

linux:
	./reproducible_builds/reproduce-linux-docker.sh

android:
	./reproducible_builds/reproduce-android-docker.sh
