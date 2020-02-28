CC=gcc
FLAGS=$(shell cat flags.make)

stream: stream.c
	$(CC) $(FLAGS) stream.c -o /tmp/stream
