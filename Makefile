CPP=g++
CPPFLAGS=-g -Wall -DCHECK

CC=gcc
CFLAGS=-std=c99 -O3 -fomit-frame-pointer
LFLAGS=-lm

all: libdclxvi.so

libdclxvi.so:
	gcc -shared -Wl,-soname=libdclxvi.so -o libdclxvi.so -O3 -fomit-frame-pointer -fPIC -DQHASM fp2e_sub2.s scalar_sub_nored.s fp6e.c fp12e.c fp2e_neg.s fp2e_neg2.s mydouble.c fp2e.c linefunction.c fp2e_mul.s fp2e_mulxi.s scalar.c fp2e_short_coeffred.s fp2e_square.s fp2e_sub.s fp2e_double.s twistpoint_fp2.c fp2e_triple.s fp2e_mul_fpe.s fp2e_parallel_coeffmul.s fp2e_triple2.s fp2e_conjugate.s fpe.c curvepoint_fp.c fp2e_double2.s parameters.c mul.c optate.c fp2e_add.s final_expo.c fpe_mul.s consts.s fp2e_add2.s



%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $^

asfunctions.a: fp2e_add2.o fp2e_sub2.o \
	fp2e_double2.o fp2e_triple2.o fp2e_neg2.o \
	fp2e_mul.o fp2e_mul_fpe.o fp2e_short_coeffred.o \
	fp2e_add.o fp2e_sub.o fp2e_parallel_coeffmul.o fp2e_mulxi.o\
	fp2e_double.o fp2e_triple.o fp2e_neg.o fp2e_conjugate.o \
	fpe_mul.o fp2e_square.o \
	consts.o
	rm -f asfunctions.a
	ar cr asfunctions.a $^

.PHONY: clean

clean:
	-rm *.o
	-rm asfunctions.a
	-rm libdclxvi.so
install:
	cp *.h /usr/local/include/dclxvi
	cp *.so /usr/local/lib
