CC = gcc
CFLAGS = -O4 -Wall -mavx2 -I $(TIMER_DIR)
TIMER_DIR = /home/class_projects/cycle-counter
TIMER = $(TIMER_DIR)/clock.o $(TIMER_DIR)/fcycmm.o

all: mm 

mm: mm.c mm.h
	$(CC) $(CFLAGS) -o mm mm.c $(TIMER)

clean:
	rm -f *.o mm *~



