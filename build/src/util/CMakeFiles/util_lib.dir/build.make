# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\CMake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\CMake\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\gonza\Desktop\gestion-de-biblioteca

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\gonza\Desktop\gestion-de-biblioteca\build

# Include any dependencies generated for this target.
include src/util/CMakeFiles/util_lib.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/util/CMakeFiles/util_lib.dir/compiler_depend.make

# Include the progress variables for this target.
include src/util/CMakeFiles/util_lib.dir/progress.make

# Include the compile flags for this target's objects.
include src/util/CMakeFiles/util_lib.dir/flags.make

src/util/CMakeFiles/util_lib.dir/Database.cpp.obj: src/util/CMakeFiles/util_lib.dir/flags.make
src/util/CMakeFiles/util_lib.dir/Database.cpp.obj: C:/Users/gonza/Desktop/gestion-de-biblioteca/src/util/Database.cpp
src/util/CMakeFiles/util_lib.dir/Database.cpp.obj: src/util/CMakeFiles/util_lib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\gonza\Desktop\gestion-de-biblioteca\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/util/CMakeFiles/util_lib.dir/Database.cpp.obj"
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/util/CMakeFiles/util_lib.dir/Database.cpp.obj -MF CMakeFiles\util_lib.dir\Database.cpp.obj.d -o CMakeFiles\util_lib.dir\Database.cpp.obj -c C:\Users\gonza\Desktop\gestion-de-biblioteca\src\util\Database.cpp

src/util/CMakeFiles/util_lib.dir/Database.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/util_lib.dir/Database.cpp.i"
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\gonza\Desktop\gestion-de-biblioteca\src\util\Database.cpp > CMakeFiles\util_lib.dir\Database.cpp.i

src/util/CMakeFiles/util_lib.dir/Database.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/util_lib.dir/Database.cpp.s"
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\gonza\Desktop\gestion-de-biblioteca\src\util\Database.cpp -o CMakeFiles\util_lib.dir\Database.cpp.s

# Object files for target util_lib
util_lib_OBJECTS = \
"CMakeFiles/util_lib.dir/Database.cpp.obj"

# External object files for target util_lib
util_lib_EXTERNAL_OBJECTS =

src/util/libutil_lib.a: src/util/CMakeFiles/util_lib.dir/Database.cpp.obj
src/util/libutil_lib.a: src/util/CMakeFiles/util_lib.dir/build.make
src/util/libutil_lib.a: src/util/CMakeFiles/util_lib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=C:\Users\gonza\Desktop\gestion-de-biblioteca\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libutil_lib.a"
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && $(CMAKE_COMMAND) -P CMakeFiles\util_lib.dir\cmake_clean_target.cmake
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\util_lib.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/util/CMakeFiles/util_lib.dir/build: src/util/libutil_lib.a
.PHONY : src/util/CMakeFiles/util_lib.dir/build

src/util/CMakeFiles/util_lib.dir/clean:
	cd /d C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util && $(CMAKE_COMMAND) -P CMakeFiles\util_lib.dir\cmake_clean.cmake
.PHONY : src/util/CMakeFiles/util_lib.dir/clean

src/util/CMakeFiles/util_lib.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\gonza\Desktop\gestion-de-biblioteca C:\Users\gonza\Desktop\gestion-de-biblioteca\src\util C:\Users\gonza\Desktop\gestion-de-biblioteca\build C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util C:\Users\gonza\Desktop\gestion-de-biblioteca\build\src\util\CMakeFiles\util_lib.dir\DependInfo.cmake "--color=$(COLOR)"
.PHONY : src/util/CMakeFiles/util_lib.dir/depend

