include include.mk

NAME=pypinproc

download: $(DOWNLOAD)/$(NAME)

$(DOWNLOAD)/$(NAME):
	( cd $(DOWNLOAD) ; git clone --depth 1 https://github.com/preble/pypinproc.git )

compile: download $(DIST)/$(NAME).$(ARCH).tar.gz

$(DIST)/$(NAME).$(ARCH).tar.gz:
	cp -r $(DOWNLOAD)/$(NAME) $(BUILD)/$(NAME)
	( cd $(BUILD)/$(NAME) ; \
		python setup.py build ; \
		python setup.py install --prefix=$(BUILDROOT)/$(NAME) )
	( cd $(BUILDROOT)/$(NAME)/lib/python*; mv site-packages dist-packages )
	tar czf $(DIST)/$(NAME).$(ARCH).tar.gz -C $(BUILDROOT) $(NAME)

