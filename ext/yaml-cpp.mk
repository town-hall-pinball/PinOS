include include.mk

VERSION=0.3.0
NAME=yaml-cpp-$(VERSION)

download: $(DOWNLOAD)/$(NAME).tar.gz

$(DOWNLOAD)/$(NAME).tar.gz:
	( cd $(DOWNLOAD) ; curl -O "http://yaml-cpp.googlecode.com/files/$(NAME).tar.gz" ) 

compile: download $(DIST)/$(NAME).$(ARCH).tar.gz

$(DIST)/$(NAME).$(ARCH).tar.gz:
	tar xf $(DOWNLOAD)/$(NAME).tar.gz -C $(BUILD)
	mv $(BUILD)/yaml-cpp $(BUILD)/$(NAME)
	mkdir -p $(BUILD)/$(NAME)/build
	( cd $(BUILD)/$(NAME)/build ; \
		cmake -DCMAKE_INSTALL_PREFIX=/ .. ; \
		make ; \
		make install DESTDIR=$(BUILDROOT)/$(NAME) )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)

