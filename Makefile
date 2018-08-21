CXX=gcc

CXXFLAGS_GENERIC=-O2 -fopenmp -lm
CXXFLAGS_HASWELL=-DAVX_256 -DN_THREADS=8 -march=core-avx2 $(CXXFLAGS_GENERIC)
CXXFLAGS_KNL=-DAVX_512 -DN_THREADS=256 -march=knl $(CXXFLAGS_GENERIC)

MAIN=main.c getarg.c

HASWELL=Haswell.c
HASWELL_HEADERS=Haswell.h

KNL=Knl.c
KNL_HEADERS=Knl.h

OUTPUT_HASWELL=haswell_256
OUTPUT_KNL=knl_512

all: $(OUTPUT_HASWELL) $(OUTPUT_KNL)

$(OUTPUT_HASWELL): Makefile $(MAIN) $(HASWELL) $(HASWELL_HEADERS)
	$(CXX) $(MAIN) $(HASWELL) $(CXXFLAGS_HASWELL) -o $(OUTPUT_HASWELL)

$(OUTPUT_KNL): Makefile $(MAIN) $(KNL) $(KNL_HEADERS)
	$(CXX) $(MAIN) $(KNL) $(CXXFLAGS_KNL) -o $(OUTPUT_KNL)

clean:
	@rm $(OUTPUT_HASWELL) $(OUTPUT_KNL)
