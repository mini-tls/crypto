# Makefile for building the crypto library
# Use:
# make release		- makes everything
# make test			- runs tests
# make benchmark	- runs benchmarks
# make clean		- removes all build files

# If you want to use the debug mode of your IDE do the following:
# Add the main.c file you want to execute
# Append the compiler flag -DRELEASE for release (for others look for the correct compiler flags!)

# compiler options:
CCX = clang # clang compiler
# common compiler flags:
LFLAGS =
RFLAGS =
# compiler flags for release
RELEASE_LFLAGS = -0fast -DRELEASE # flags for release: optimised build, no verbosity...
RELEASE_RFLAGS = # flags for release: optimised build, no verbosity...
# compiler flags for testing:
TEST_LFLAGS = -v -O1 -DTEST # flags for release: no optimised build for debugging purposes, max verbosity...
TEST_RFLAGS = # flags for release: optimised build, no verbosity...
# compiler flags for benchmark:
BENCHMARK_LFLAGS = -Ofast -DBENCHMARK # flags for release: optimised build, no verbosity...
BENCHMARK_RFLAGS = # flags for release: optimised build, no verbosity...

# project options:
ARTIFACT_DIR = build
OUTPUT_DIR = $(ARTIFACT_DIR)/bin
# source files
SRC_DIR = src/
INCLUDE_DIR = include/
EXEC = $(OUTPUT_DIR)/out
# test files
TEST_DIR = test/
TEST_INCLUDE_DIR = $(TEST_DIR)/include/
TEST_EXEC = $(OUTPUT_DIR)/test_out
# benchmark files
BENCHMARK_DIR = benchmark/
BENCHMARK_INCLUDE_DIR = $(BENCHMARK_DIR)/include/
BENCHMARK_EXEC = $(OUTPUT_DIR)/benchmark_out

# defining functions:
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(EXEC): $(SRC_DIR)/*.c
	$(CCX) $(RELEASE_LFLAGS) $(RELEASE_RFLAGS) -I$(INCLUDE_DIR) -o $@ $^ $(LFLAGS)
	./$(EXEC)


$(TEST_EXEC): $(TEST_DIR)/*.c
	$(CCX) $(TEST_LFLAGS) $(TEST_RFLAGS) -I$(INCLUDE_DIR) -I$(TEST_INCLUDE_DIR) -o $@ $^ $(LFLAGS)
	./$(TEST_EXEC)

$(BENCHMARK_EXEC): $(BENCHMARK_DIR)/*.c
	$(CCX) $(BENCHMARK_LFLAGS) $(BENCHMARK_RFLAGS) -I$(INCLUDE_DIR) -I$(BENCHMARK_INCLUDE_DIR) -o $@ $^ $(LFLAGS)
	./$(BENCHMARK_EXEC)

release: $(OUTPUT_DIR) $(EXEC)

test: $(OUTPUT_DIR) $(TEST_EXEC)

benchmark: $(OUTPUT_DIR) $(BENCHMARK_EXEC)

clean:
	rm -rf $(ARTIFACT_DIR)