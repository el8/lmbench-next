# I finally know why Larry Wall's Makefile says "Grrrr".
SHELL = /bin/sh

CC = gcc
LD = gcc
MAKE = make
AR = ar
ARCREATE = cr
RANLIB = ranlib

INSTALL_PATH = /usr/local
OS = $(shell ../scripts/os)
O = ../bin/$(OS)
CONFIG = ../bin/$(OS)/`../scripts/config`
CFLAGS = -O2 -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_socklen_t -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1
LDFLAGS = -Wl,-s 
LDLIBS = $(O)/lmbench.a -lm

INCS =	bench.h lib_mem.h lib_tcp.h lib_udp.h stats.h timing.h		\
	lib_debug.h lib_unix.h names.h

OBJS =  bw_file_rd.o bw_mem.o bw_mmap_rd.o bw_pipe.o bw_tcp.o bw_udp.o	\
	bw_unix.o							\
	lat_connect.o lat_ctx.o	lat_fcntl.o lat_fifo.o lat_fs.o 	\
	lat_mem_rd.o lat_mmap.o lat_ops.o lat_pagefault.o lat_pipe.o 	\
	lat_proc.o lat_select.o lat_sig.o lat_syscall.o			\
	lat_tcp.o lat_udp.o lat_unix.o lat_unix_connect.o lat_sem.o	\
	line.o lmdd.o par_mem.o par_ops.o loop_o.o memsize.o		\
	disk.o enough.o hello.o mhz.o					\
	msleep.o timing_o.o tlb.o stream.o

LIBOBJS = lib_timing lib_mem lib_tcp lib_udp lib_unix lib_stats		\
	lib_debug lib_sched lib_getopt

EXES =	bw_file_rd bw_mem bw_mmap_rd bw_pipe bw_tcp bw_udp bw_unix	\
	lat_connect lat_ctx lat_fcntl lat_fifo lat_fs			\
	lat_mem_rd lat_mmap lat_ops lat_pagefault lat_pipe		\
	lat_proc lat_select lat_sig lat_syscall				\
	lat_tcp lat_udp lat_unix lat_unix_connect lat_sem		\
	line lmdd par_mem par_ops loop_o memsize			\
	disk enough hello mhz						\
	msleep timing_o tlb stream

OPT_OBJS = lat_dram_page.o lat_pmake.o lat_rand.o lat_usleep.o		\
	lat_cmd.o cache.o clock.o

OPT_EXES = lat_dram_page lat_pmake lat_rand lat_usleep lat_cmd cache

#lmbench:
#	@env CFLAGS="$(CFLAGS)" MAKE="$(MAKE)" MAKEFLAGS="$(MAKEFLAGS)" CC="$(CC)" OS="$(OS)" ../scripts/build all
#	@-env CFLAGS="$(CFLAGS)" MAKE="$(MAKE)" MAKEFLAGS="k$(MAKEFLAGS)" CC="$(CC)" OS="$(OS)" ../scripts/build opt

all: $O/lmbench.a $(OBJS) $(EXES) $O/lmbench $O/version
opt: $(OPT_OBJS) $(OPT_EXES)

$O/lmbench: ../scripts/lmbench
	@cp ../scripts/lmbench $O/lmbench
	@chmod +x $O/lmbench

$O/version:
	@../scripts/version > $O/version
	@../scripts/compiler >> $O/version
	@echo "CFLAGS: $(CFLAGS)" >> $O/version

$O/lmbench.a: $(addsuffix .o,$(LIBOBJS))
	@mkdir -p $O
	$(CROSS_COMPILE)$(AR) $(ARCREATE) $O/lmbench.a $(addsuffix .o,$(LIBOBJS))
	-$(CROSS_COMPILE)$(RANLIB) $O/lmbench.a

lib_%.o: lib_%.c $(INCS)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c $O/lmbench.a $(INCS)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -c $< -o $@

%: %.o
	$(CROSS_COMPILE)$(LD) $(LDFLAGS) $^ $(LDLIBS) -o $O/$@

install:
	if [ ! -d $(INSTALL_PATH) ]; then mkdir -p $(INSTALL_PATH); fi
	if [ ! -d $(INSTALL_PATH)/bin ]; then mkdir $(INSTALL_PATH)/bin; fi
	cp -f $O/lmbench $O/version $(INSTALL_PATH)/bin
	cp -f $(addprefix $O/,$(EXES)) $(INSTALL_PATH)/bin
	-cp -f $(addprefix $O/,$(OPT_EXES)) $(INSTALL_PATH)/bin

tags:
	@ctags *.h *.c

clean:
	@/bin/rm -f *.[oa]

.PHONY: lmbench version tags install all opt clean
