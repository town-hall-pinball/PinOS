include include.mk

NAME=libpinproc

download: $(DOWNLOAD)/$(NAME)

$(DOWNLOAD)/$(NAME):
	( cd $(DOWNLOAD) ; git clone --depth 1 https://github.com/preble/libpinproc.git )

compile: download $(DIST)/$(NAME).$(ARCH).tar.gz

$(DIST)/$(NAME).$(ARCH).tar.gz:
	cp -r $(DOWNLOAD)/$(NAME) $(BUILD)/$(NAME)
	mkdir -p $(BUILD)/$(NAME)/bin
	( cd $(BUILD)/$(NAME)/bin ; \
		cmake -DCMAKE_INSTALL_PREFIX=/ -DCMAKE_CXX_FLAGS="-fPIC" -DBUILD_SHARED_LIBS="ON" .. ; \
		make ; \
		make install DESTDIR=$(BUILDROOT)/$(NAME) )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)

