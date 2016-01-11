VERSION=scm

CC?=cc
CFLAGS?=-O2 -g

DESTDIR?=$(PWD)/image
BUILD?=$(PWD)/build

prefix?=/usr/local
exec_prefix?=$(prefix)
bindir?=$(exec_prefix)/bin
libdir?=$(exec_prefix)/lib
libexecdir?=$(exec_prefix)/libexec
datarootdir?=$(prefix)/share
datadir?=$(datarootdir)
sysconfdir?=$(prefix)/etc
docdir?=$(datarootdir)/doc/tmpfiled-$(VERSION)
mandir?=$(datarootdir)/man
localstatedir?=$(prefix)/var
runstatedir?=$(localstatedir)/run

all:
	@printf "tmpfiled, a standalone reimplementation of systemd-tmpfiles\n\n"
	@printf "%-20s%-20s\n"	\
		"DESTDIR"		"$(DESTDIR)"		\
		"BUILD"			"$(BUILD)"			\
		"prefix"		"$(prefix)"			\
		"exec_prefix"	"$(exec_prefix)"	\
		"bindir"		"$(bindir)"			\
		"libdir"		"$(libdir)"			\
		"libexecdir"	"$(libexecdir)"		\
		"datarootdir"	"$(datarootdir)"	\
		"datadir"		"$(datadir)"		\
		"sysconfdir"	"$(sysconfdir)"		\
		"docdir"		"$(docdir)"			\
		"mandir"		"$(mandir)"			\
		"localstatedir"	"$(localstatedir)"	\
		"runstatedir"	"$(runstatedir)"	\
		""
	@$(MAKE) --no-print-directory build

build:
	mkdir -p $(BUILD)
	mkdir -p $(BUILD)$(bindir)
	mkdir -p $(BUILD)$(libdir)/tmpfiles.d
	mkdir -p $(BUILD)$(sysconfdir)/tmpfiles.d
	mkdir -p $(BUILD)$(docdir)
	install -m755 tmpfiled $(BUILD)$(bindir)
	find $(BUILD) -type f -exec sed \
		-e "s|@@prefix@@|$(prefix)|g"				\
		-e "s|@@exec_prefix@@|$(exec_prefix)|g"		\
		-e "s|@@libdir@@|$(libdir)|g"				\
		-e "s|@@bindir@@|$(bindir)|g"				\
		-e "s|@@libexecdir@@|$(libexecdir)|g"		\
		-e "s|@@datarootdir@@|$(datarootdir)|g"		\
		-e "s|@@datadir@@|$(datadir)|g"				\
		-e "s|@@sysconfdir@@|$(sysconfdir)|g"		\
		-e "s|@@docdir@@|$(docdir)|g"				\
		-e "s|@@mandir@@|$(mandir)|g"				\
		-e "s|@@localstatedir@@|$(localstatedir)|g"	\
		-e "s|@@runstatedir@@|$(runstatedir)|g"		\
		-e "s|@@COPYRIGHT@@|$(copyright)|g"			\
		-i {} \;

install: $(BUILD)
	mkdir -p $(DESTDIR)
	cp -r $(BUILD)/* $(DESTDIR)

clean:
	rm -rf $(BUILD)

.PHONY:	all build clean

