ifeq ($(OS), Windows_NT)
	EXT_EXE			:= .exe
	PREFIX_EXE		:= 
	EXT_LIB_SHARED	:= .dll
	EXT_LIB_STATIC	:= .lib
	WHICH			:= where
	RM				:= rm -f
	PLATFORM 		:= Windows
else
	EXT_EXE 		:=
	EXT_LIB_STATIC	:= .a
	EXT_LIB_SHARED	:= .so
	PREFIX_EXE 		:= ./
	RM				:= rm -f
	WHICH			:= which
	UNAME_S			:= $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		PLATFORM 	:= Linux
	endif
	ifeq ($(UNAME_S), Darwin)
		PLATFORM 	:= Mac
	endif
endif
