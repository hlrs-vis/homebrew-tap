require "formula"

class Volpack < Formula
  homepage "http://graphics.stanford.edu/software/volpack/"
  url "http://graphics.stanford.edu/software/volpack/volpack-1.0b3.tar.Z"
  #version "1.0b3"
  sha256 "d7cfd5f6819cccf88363d2270377e547a07f35da6a0dac45845ecc1640e410fa"

  # "Official" build fixes for OS X
  patch do
     url "http://graphics.stanford.edu/software/volpack/volpack-1.0b3-ijt-mods.patch"
     sha256 "4d420ff6fd01abb48bb2f772d9e2f7588a6a71d5a065e0d1c08b0b89efeeed81"
  end

  # Makefile.in assumes that current directory is in PATH
  patch :p0, :DATA

  depends_on "automake" => :build
  depends_on "autoconf" => :build

  def install
    ENV.deparallelize
    system "aclocal"
    system "autoreconf", "-f", "-i"
    # abuse automake to update config.{guess,sub} and ignore resulting errors
    begin
       system "automake", "-a", "-f", "--foreign"
    rescue
    end

    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install", "OFLAGS=-O2 -g"
  end

  test do
    system "test -f #{lib}/libvolpack.a -a -f #{include}/volpack.h"
  end
end

__END__
*** Makefile.in	2014-10-17 16:56:10.000000000 +0200
--- Makefile.in.patch	2014-10-17 18:11:23.000000000 +0200
***************
*** 47,53 ****
  INCLUDE_DIR = 	$(prefix)/include
  
  # top-level directory for manual entries
! MAN_DIR = 	$(prefix)/man
  
  # directory in which to install manual entries for library functions
  MAN3_DIR = 	$(MAN_DIR)/man3
--- 47,53 ----
  INCLUDE_DIR = 	$(prefix)/include
  
  # top-level directory for manual entries
! MAN_DIR = 	@mandir@
  
  # directory in which to install manual entries for library functions
  MAN3_DIR = 	$(MAN_DIR)/man3
***************
*** 175,181 ****
  	cc -o makeopts makeopts.c
  
  vp_opts.c: makeopts Makefile
! 	makeopts vp_opts.c $(CFLAGS)
  
  $(COMP_SRCS): $(COMP_IN)
  	@for i in $(COMP_SRCS) ; \
--- 175,181 ----
  	cc -o makeopts makeopts.c
  
  vp_opts.c: makeopts Makefile
! 	./makeopts vp_opts.c $(CFLAGS)
  
  $(COMP_SRCS): $(COMP_IN)
  	@for i in $(COMP_SRCS) ; \
***************
*** 232,238 ****
  	    do \
  	    if [ ! -d $$i ] ; then \
  		echo "Making directory $$i"; \
! 		mkdir $$i ; \
  		chmod 755 $$i; \
  		else true; \
  		fi; \
--- 232,238 ----
  	    do \
  	    if [ ! -d $$i ] ; then \
  		echo "Making directory $$i"; \
! 		mkdir -p $$i ; \
  		chmod 755 $$i; \
  		else true; \
  		fi; \
