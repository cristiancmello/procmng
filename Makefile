
all: build run
	
build:
	gcc -S procmng.c
	gcc -o procmng procmng.c

build_minishell:
	gcc -o minishell minishell.c

build_memsegments:
	gcc -o memsegments mem_segments.c

build_cmdargs:
	gcc -o cmdargs cmdargs.c

build_envlist:
	gcc -o envlist envlist.c

run_minishell: build_minishell
	./minishell

run_memsegments: build_memsegments
	./memsegments

run_cmdargs: build_cmdargs
	./cmdargs arg1 arg2 arg3

run_envlist: build_envlist
	./envlist
	
run: build
	./procmng