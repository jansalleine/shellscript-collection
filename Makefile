MAKEFLAGS += --silent

BINDIR?=/usr/local/bin/
CP:=cp -f -v
RM:=rm -f -v
SCRIPTS:=$(shell find . -name "*.sh")

define SCRIPT_install
	$(CP) $(1) $(BINDIR)$(notdir $(basename $(1)));
endef

define SCRIPT_uninstall
	$(RM) $(BINDIR)$(notdir $(basename $(1)));
endef

.PHONY: install uninstall

all:
	echo "install:   sudo make install"
	echo "uninstall: sudo make uninstall"
	echo "default path /usr/local/bin/ in BINDIR variable"

install:
	$(foreach script,$(SCRIPTS),$(call SCRIPT_install,$(script)))

uninstall:
	$(foreach script,$(SCRIPTS),$(call SCRIPT_uninstall,$(script)))
