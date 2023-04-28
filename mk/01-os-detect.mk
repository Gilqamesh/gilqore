ifeq ($(OS), Windows_NT)
	EXT_EXE					:= .exe
	PREFIX_EXE				:= 
	EXT_LIB_SHARED			:= .dll
	EXT_LIB_STATIC			:= .lib
	WHICH					:= where
	PLATFORM 				:= WINDOWS
else
	EXT_EXE 				:=
	EXT_LIB_STATIC			:= .a
	EXT_LIB_SHARED			:= .so
	PREFIX_EXE 				:= ./
	WHICH					:= which
	UNAME_S					:= $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		PLATFORM 			:= LINUX
	endif
	ifeq ($(UNAME_S), Darwin)
		PLATFORM 			:= MAC
	endif
endif

ifeq ($(findstring bash,$(SHELL)),bash)
	RM						:= rm -f
else ifeq ($(findstring zsh,$(SHELL)),zsh)
	RM						:= rm -f
else ifeq ($(findstring cmd.exe,$(SHELL)),cmd.exe)
	RM						:= del /f
else
# Unknown shell
	RM						:= rm -f
endif
