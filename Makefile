CXX=gcc

SANITY_FLAGS=-Wall -Wextra -Werror -fstack-protector-all -pedantic -Wno-unused -Wfloat-equal -Wshadow -Wpointer-arith -Wformat=2
CXXFLAGS_GENERIC=-std=c99 -O2 $(SANITY_FLAGS)
CXXFLAGS_LINK=-lm -fopenmp
CXXFLAGS_HASWELL = -DTEST_NAME="\"Haswell - 256 bits\"" -DAVX_256_10 -march=core-avx2 $(CXXFLAGS_GENERIC)
CXXFLAGS_SKYLAKE = -DTEST_NAME="\"Skylake - 256 bits\"" -DAVX_256_8  -march=core-avx2 $(CXXFLAGS_GENERIC)
CXXFLAGS_KNL     = -DTEST_NAME="\"KNL - 512 bits\""     -DAVX_512_12 -march=knl       $(CXXFLAGS_GENERIC)
CXXFLAGS_ZEN_PLUS= -DTEST_NAME="\"ZEN+ - 256 bits\""    -DAVX_256_10 -march=znver1    $(CXXFLAGS_GENERIC)

ARCH_DIR=Arch
MAIN=main.c getarg.c

HASWELL=$(ARCH_DIR)/256_10.c
HASWELL_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

SKYLAKE=$(ARCH_DIR)/256_8.c
SKYLAKE_HEADERS=$(ARCH_DIR)/256_8.h $(ARCH_DIR)/Arch.h

ZEN_PLUS=$(ARCH_DIR)/256_10.c
ZEN_PLUS_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

KNL=$(ARCH_DIR)/512_12.c
KNL_HEADERS=$(ARCH_DIR)/512_12.h $(ARCH_DIR)/Arch.h

OUTPUT_HASWELL=haswell_256
OUTPUT_SKYLAKE=skylake_256
OUTPUT_ZEN_PLUS=zen_plus_256
OUTPUT_KNL=knl_512

all: $(OUTPUT_HASWELL) $(OUTPUT_SKYLAKE) $(OUTPUT_KNL) $(OUTPUT_ZEN_PLUS)

$(OUTPUT_HASWELL): Makefile $(MAIN) $(HASWELL) $(HASWELL_HEADERS)
	$(CXX) $(CXXFLAGS_HASWELL) $(MAIN) $(HASWELL) $(CXXFLAGS_LINK) -o $(OUTPUT_HASWELL)

$(OUTPUT_SKYLAKE): Makefile $(MAIN) $(SKYLAKE) $(SKYLAKE_HEADERS)
	$(CXX) $(CXXFLAGS_SKYLAKE) $(MAIN) $(SKYLAKE) $(CXXFLAGS_LINK) -o $(OUTPUT_SKYLAKE)

$(OUTPUT_ZEN_PLUS): Makefile $(MAIN) $(ZEN_PLUS) $(ZEN_PLUS_HEADERS)
	$(CXX) $(CXXFLAGS_ZEN_PLUS) $(MAIN) $(ZEN_PLUS) $(CXXFLAGS_LINK) -o $(OUTPUT_ZEN_PLUS)

$(OUTPUT_KNL): Makefile $(MAIN) $(KNL) $(KNL_HEADERS)
	$(CXX) $(CXXFLAGS_KNL) $(MAIN) $(KNL) $(CXXFLAGS_LINK) -o $(OUTPUT_KNL)

clean:
	@rm $(OUTPUT_HASWELL) $(OUTPUT_KNL) $(OUTPUT_ZEN_PLUS) $(OUTPUT_SKYLAKE)
