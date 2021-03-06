#
# Copyright (c) 2014 townhallpinball.org
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

include include.mk

VERSION=0.16
NAME=libftdi-$(VERSION)

download: $(DOWNLOAD)/$(NAME).tar.gz

$(DOWNLOAD)/$(NAME).tar.gz:
	( cd $(DOWNLOAD) ; curl -O http://www.intra2net.com/en/developer/libftdi/download/$(NAME).tar.gz )

compile: download $(DIST)/$(NAME).$(ARCH).tar.gz

$(DIST)/$(NAME).$(ARCH).tar.gz:
	tar xf $(DOWNLOAD)/$(NAME).tar.gz -C $(BUILD)
	mkdir -p $(BUILD)/$(NAME)/build
	( cd $(BUILD)/$(NAME)/build ; \
		cmake -DCMAKE_INSTALL_PREFIX=/ .. ; \
		make ; \
		make install DESTDIR=$(BUILDROOT)/$(NAME) )
	( cd $(BUILDROOT)/$(NAME)/include ; ln -s libftdi libftdi1 )
#( cd $(BUILDROOT)/$(NAME)/include ; ln -s libftdi/ftdi.h . )
	( cd $(BUILDROOT)/$(NAME)/lib* ; ln -s libftdi.so.1 libftdi1.so )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)
