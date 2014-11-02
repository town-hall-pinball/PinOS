ARCH=$(shell arch)
BASEDIR=$(PWD)

DOWNLOAD=$(BASEDIR)/download
BUILD=$(BASEDIR)/build
BUILDROOT=$(BASEDIR)/build/buildroot
DIST=$(BASEDIR)/dist

all: init buildclean compile

init:
	mkdir -p $(DOWNLOAD)
	mkdir -p $(BUILD)
	mkdir -p $(BUILDROOT)
	mkdir -p $(DIST)

buildclean:
	rm -rf $(BUILD)/$(NAME)
	rm -rf $(BUILDROOT)/$(NAME)
	rm -rf $(DIST)/$(NAME)*

clean: buildclean




