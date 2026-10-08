CC      = gcc
CFLAGS  = -Wall -Wextra -O2 -Iinclude
SRC     = $(wildcard src/*.c)
OBJ     = $(patsubst src/%.c,obj/%.o,$(SRC))
EXEC    = bin/projet

.PHONY: all run clean

all: $(EXEC)

$(EXEC): $(OBJ) | bin
	$(CC) $(CFLAGS) -o $@ $^

obj/%.o: src/%.c | obj
	$(CC) $(CFLAGS) -c $< -o $@

bin obj output:
	mkdir -p $@

# Apply every transformation to the sample images; results go to output/
# (the mixture operation reads its mask Lenna_BW.pgm from the working directory)
run: $(EXEC) | output
	cp input/Lenna_BW.pgm output/
	cd output && ../$(EXEC) ../input/Lenna_gray.pgm ../input/Lenna_color.ppm
	rm -f output/Lenna_BW.pgm

clean:
	rm -rf obj bin
