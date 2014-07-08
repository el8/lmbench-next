# Makefile for lmbench doc subdir.

SHELL=/bin/sh
SCRIPTS = ../scripts/
INSTALL_PATH=/usr/local
MANDIR=$(INSTALL_PATH)/man

MAN =	bargraph.1 graph.1 						\
	lmbench.3 reporting.3 results.3 timing.3 			\
	lmbench.8 mhz.8 cache.8 line.8 tlb.8 lmdd.8			\
	lat_proc.8 lat_mmap.8 lat_ctx.8 lat_syscall.8 lat_pipe.8 	\
	lat_http.8 lat_tcp.8 lat_udp.8 lat_rpc.8 lat_connect.8 lat_fs.8	\
	lat_ops.8 lat_pagefault.8 lat_mem_rd.8 lat_select.8		\
	lat_fifo.8 lat_fcntl.8 lat_sig.8 lat_unix.8 lat_unix_connect.8	\
	bw_file_rd.8 bw_mem.8 bw_mmap_rd.8				\
	bw_pipe.8 bw_tcp.8 bw_unix.8 					\
	par_ops.8 par_mem.8

ALL = $(MAN)

install:
	for f in $(addprefix man/,$(MAN)); do				\
		for s in 1 2 3 4 5 6 7 8 9; do				\
			if [ ! -d ${MANDIR}/man$${s} ]; then		\
				mkdir -p ${MANDIR}/man$${s};		\
			fi;						\
			base=`basename $${f} .$${s}`;			\
			if [ "$${base}.$${s}" = "$$f" ]; then		\
				cp $$f ${MANDIR}/man$${s}/;		\
			fi;						\
		done;							\
	done

clean:
	@/bin/rm -f *.PS

.PHONY: install clean
