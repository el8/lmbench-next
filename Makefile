# Makefile for top level of lmbench
SHELL=/bin/sh
MAKE=make

build: 
	cd src && $(MAKE)

clobber clean: 
	for i in doc src results; do (cd $$i && $(MAKE) clean);	done
	/bin/rm -rf bin/*

info: 
	for i in doc src results scripts; do \
		echo ===== $$i =====; \
		(cd $$i && info); \
	done

help:
	@echo 'lmbench		builds the benchmark suite for the current os/arch [default]'
	@echo 'clean		cleans out sources and run configuration'
