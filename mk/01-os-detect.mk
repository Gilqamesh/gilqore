ifeq ($(OS), Windows_NT)
	EXT_EXE					:= .exe
	PREFIX_EXE				:= 
	EXT_LIB_SHARED			:= .dll
	EXT_LIB_STATIC			:= .lib
	WHICH					:= where
	RM						:= rm -f
	PLATFORM 				:= WINDOWS
else
	EXT_EXE 				:=
	EXT_LIB_STATIC			:= .a
	EXT_LIB_SHARED			:= .so
	PREFIX_EXE 				:= ./
	RM						:= rm -f
	WHICH					:= which
	UNAME_S					:= $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		PLATFORM 			:= LINUX
	endif
	ifeq ($(UNAME_S), Darwin)
		PLATFORM 			:= MAC
	endif
endif
