src = $(wildcard ./*.c)
target = $(patsubst ./%.c, %, $(src))

ALL:$(target)

%:%.c
	gcc $< -o $@


.PHONY:clean
clean:
	-rm -rf *.o $(target)
