cmake_minimum_required( VERSION 2.6.3 )

if( DEFINED CMAKE_CROSSCOMPILING )
  # subsequent toolchain loading is not really needed
  return()
endif()

if( CMAKE_TOOLCHAIN_FILE )
  # touch toolchain variable to suppress "unused variable" warning
endif()

set( CMAKE_SYSTEM_NAME Generic )
set( CMAKE_SYSTEM_VERSION 1 )

# search for Vita SDK path 1) where this toolchain file is, 2) in environment var, 3) manually defined
if( NOT DEFINED ENV{PS3DEV} )
  get_filename_component(__devkitpro_path ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
  if( EXISTS "${__devkitpro_path}" )
    set( PS3DEV "${__devkitpro_path}" )
    set( ENV{PS3DEV} "${__devkitpro_path}" )
  endif()
else()
  set( PS3DEV "$ENV{PS3DEV}" )
endif()
set( DEVKITPRO "${PS3DEV}" CACHE PATH "Path to PS3DEV root" )

if( NOT EXISTS "${PS3DEV}" )
  message( FATAL_ERROR "Cannot find PS3DEV at ${PS3DEV}" )
endif()

set( TOOL_OS_SUFFIX "" )
if( CMAKE_HOST_WIN32 )
 set( TOOL_OS_SUFFIX ".exe" )
endif()

set(CMAKE_SYSTEM_PROCESSOR "powerpc64")
set(CMAKE_C_COMPILER   "${PS3DEV}/ppu/bin/ppu-gcc${TOOL_OS_SUFFIX}"     CACHE PATH "C compiler")
set(CMAKE_CXX_COMPILER "${PS3DEV}/ppu/bin/ppu-c++${TOOL_OS_SUFFIX}"     CACHE PATH "C++ compiler")
set(CMAKE_ASM_COMPILER "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-as${TOOL_OS_SUFFIX}"      CACHE PATH "C++ compiler")
set(CMAKE_STRIP        "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-strip${TOOL_OS_SUFFIX}"   CACHE PATH "strip")
set(CMAKE_AR           "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ar${TOOL_OS_SUFFIX}"      CACHE PATH "archive")
set(CMAKE_LINKER       "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ld${TOOL_OS_SUFFIX}"      CACHE PATH "linker")
set(CMAKE_NM           "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-nm${TOOL_OS_SUFFIX}"      CACHE PATH "nm")
set(CMAKE_OBJCOPY      "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-objcopy${TOOL_OS_SUFFIX}" CACHE PATH "objcopy")
set(CMAKE_OBJDUMP      "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-objdump${TOOL_OS_SUFFIX}" CACHE PATH "objdump")
set(CMAKE_RANLIB       "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ranlib${TOOL_OS_SUFFIX}"  CACHE PATH "ranlib")




# cache flags
set( CMAKE_CXX_FLAGS           ""                        CACHE STRING "c++ flags" )
set( CMAKE_C_FLAGS             ""                        CACHE STRING "c flags" )
set( CMAKE_CXX_FLAGS_RELEASE   "-O3 -DNDEBUG"            CACHE STRING "c++ Release flags" )
set( CMAKE_C_FLAGS_RELEASE     "-O3 -DNDEBUG"            CACHE STRING "c Release flags" )
set( CMAKE_CXX_FLAGS_DEBUG     "-O0 -g -DDEBUG -D_DEBUG" CACHE STRING "c++ Debug flags" )
set( CMAKE_C_FLAGS_DEBUG       "-O0 -g -DDEBUG -D_DEBUG" CACHE STRING "c Debug flags" )
set( CMAKE_SHARED_LINKER_FLAGS ""                        CACHE STRING "shared linker flags" )
set( CMAKE_MODULE_LINKER_FLAGS ""                        CACHE STRING "module linker flags" )
#set( CMAKE_EXE_LINKER_FLAGS    "-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib -mhard-float -fmodulo-sched -ffunction-sections -fdata-sections"      CACHE STRING "executable linker flags" )

# we require the relocation table
set(CMAKE_C_FLAGS "-D__PS3__ -mcpu=cell -mhard-float -fmodulo-sched -ffunction-sections -fdata-sections -I${PS3DEV}/ppu/include -I${PS3DEV}/portlibs/ppu/include -I${PS3DEV}/ppu/include/simdmath")
#set(CMAKE_C_FLAGS "-D__PS3__  -I${PS3DEV}/ppu/include -I${PS3DEV}/portlibs/ppu/include -I${PS3DEV}/ppu/include/simdmath")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

# set these global flags for cmake client scripts to change behavior
set( PS3 True )
set( BUILD_PS3 True )

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH ${PS3DEV}/ppu ${PS3DEV}/portlibs/ppu )

# only search for libraries and includes in toolchain
#SET( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
