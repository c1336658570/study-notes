mybin:main.o test.o
	gcc $^ -o $@
%.o:%.c
	gcc -c $<

.PHONY:clean
clean:
	rm -f *.o mybin
