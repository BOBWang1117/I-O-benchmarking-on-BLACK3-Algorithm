CC := gcc
CFLAGS := -O3 -Wall
LDFLAGS := -lpthread -lstdc++
BLAKE3_PATH := ./blake3

ASM_TARGETS :=
ifeq ($(OS),Windows_NT)
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_sse2_x86-64_windows_gnu.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_sse41_x86-64_windows_gnu.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_avx2_x86-64_windows_gnu.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_avx512_x86-64_windows_gnu.S
else
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_sse2_x86-64_unix.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_sse41_x86-64_unix.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_avx2_x86-64_unix.S
	ASM_TARGETS += $(BLAKE3_PATH)/blake3_avx512_x86-64_unix.S
endif


BLAKE3_FILES :=
BLAKE3_FILES += $(BLAKE3_PATH)/blake3.c
BLAKE3_FILES += $(BLAKE3_PATH)/blake3_dispatch.c
BLAKE3_FILES += $(BLAKE3_PATH)/blake3_portable.c
BLAKE3_FILES += $(BLAKE3_PATH)/blake3.h
BLAKE3_FILES += $(BLAKE3_PATH)/blake3_impl.h


GEN_HPP_FILES :=
GEN_HPP_FILES += my_command.hpp
GEN_HPP_FILES += hash_interface.hpp
GEN_HPP_FILES += my_hashgen.hpp
GEN_HPP_FILES += my_external_sort.hpp


GEN_CPP_FILES :=
GEN_CPP_FILES += main.cpp
GEN_CPP_FILES += my_command.cpp
GEN_CPP_FILES += hash_interface.cpp
GEN_CPP_FILES += my_hashgen.cpp
GEN_CPP_FILES += my_external_sort.cpp


VERIFY_HPP_FILES := 
VERIFY_HPP_FILES += my_verify_command.hpp
VERIFY_HPP_FILES += my_hash_verify.hpp


VERIFY_CPP_FILES :=
VERIFY_CPP_FILES += hashverify.cpp
VERIFY_CPP_FILES += my_verify_command.cpp
VERIFY_CPP_FILES += my_hash_verify.cpp


all:
	$(CC) $(CFLAGS) -o hashgen $(GEN_CPP_FILES) $(GEN_HPP_FILES) $(BLAKE3_FILES) $(ASM_TARGETS) $(LDFLAGS)
	$(CC) $(CFLAGS) -o hashverify $(VERIFY_CPP_FILES) $(VERIFY_HPP_FILES) $(LDFLAGS)


ifeq ($(OS),Windows_NT)
clean:
	-del -fR *.bin
else
clean:
	-rm -rf *.bin
endif