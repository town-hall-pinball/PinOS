include include.mk

VERSION=0.1.12
NAME=libusb-$(VERSION)

download: $(DOWNLOAD)/$(NAME).tar.gz

$(DOWNLOAD)/$(NAME).tar.gz:
	( cd $(DOWNLOAD) ; curl -L -O "http://softlayer-dal.dl.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/$(VERSION)/$(NAME).tar.gz" )

compile: download $(DIST)/$(NAME).$(ARCH).tar.gz

$(DIST)/$(NAME).$(ARCH).tar.gz:
	tar xf $(DOWNLOAD)/$(NAME).tar.gz -C $(BUILD)
	( cd $(BUILD)/$(NAME) ; \
		./configure --prefix=/ ; \
		make ; \
		make install DESTDIR=$(BUILDROOT)/$(NAME) )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)

