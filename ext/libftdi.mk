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
	( cd $(BUILDROOT)/$(NAME)/include ; ln -s libftdi/ftdi.h . )
	( cd $(BUILDROOT)/$(NAME)/lib* ; ln -s libftdi.so.1 libftdi1.so )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)

