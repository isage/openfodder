cmake_minimum_required(VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

include("$ENV{DOLCESDK}/share/dolce.toolchain.cmake" REQUIRED)
include("$ENV{DOLCESDK}/share/dolce.cmake" REQUIRED)
set(DOLCE_APP_NAME "OpenFodder")
set(DOLCE_TITLEID  "FDDR00001")
set(DOLCE_VERSION  "01.00")
set(DOLCE_MKSFOEX_FLAGS "${DOLCE_MKSFOEX_FLAGS} -d PARENTAL_LEVEL=1")
set(DOLCE_ELF_CREATE_FLAGS "${DOLCE_ELF_CREATE_FLAGS} -h 4194304")


project(openfodder CXX)

set (openfodder_VERSION_MAJOR 1)
set (openfodder_VERSION_MINOR 6)
set (openfodder_VERSION_RELEASE 1)

include(CheckCXXCompilerFlag)
include(GNUInstallDirs)


find_package(SDL2 REQUIRED)
find_package(SDL2_mixer REQUIRED)
find_package(PNG REQUIRED)

include_directories(${SDL2_INCLUDE_DIR})
include_directories(${SDL_MIXER_INCLUDE_DIR})
include_directories(${PNG_PNG_INCLUDE_DIR})
include_directories("${openfodder_SOURCE_DIR}/Source")

file(GLOB_RECURSE APP_SOURCES "Source/[a-zA-Z]*.cpp")

include_directories(${openfodder_SOURCE_DIR})

set(SOURCES
    ${APP_SOURCES}
)

IF(CMAKE_BUILD_TYPE MATCHES Debug)
    message("debug mode")
    add_definitions(-DDEBUG)
ENDIF()

add_definitions("-Wall")

add_executable(openfodder ${SOURCES})
    add_definitions("-std=c++14")
    add_definitions("-D__VITA__")
    target_link_libraries(openfodder ${SDL_MIXER_LIBRARY} ${SDL2_LIBRARY} ${PNG_LIBRARY}
      pib
      SceDisplay_stub
      SceCtrl_stub
      SceAppMgr_stub
      SceAudio_stub
      SceSysmodule_stub
      SceSharedFb_stub
      SceDisplay_stub
      SceDisplayUser_stub
      SceCtrl_stub
      SceAppMgr_stub
      SceAppMgrUser_stub
      SceAudio_stub
      SceIofilemgr_stub
      SceSysmodule_stub
      SceGxm_stub
      SceGxmInternalForVsh_stub
      SceCommonDialog_stub
      SceTouch_stub
      SceHid_stub
      SceMotion_stub
      m
      z
      FLAC
      vorbisfile
      vorbis
      ogg
      mikmod
      mpg123
    )

  dolce_create_self(${PROJECT_NAME}.self openfodder UNSAFE)
  dolce_create_vpk(${PROJECT_NAME}.vpk ${DOLCE_TITLEID} ${PROJECT_NAME}.self
    VERSION ${DOLCE_VERSION}
    NAME ${DOLCE_APP_NAME}
    FILE sce_sys sce_sys
  )
  add_custom_command(OUTPUT ${CMAKE_SOURCE_DIR}/release/openfodder-${openfodder_VERSION_MAJOR}.${openfodder_VERSION_MINOR}.${openfodder_VERSION_RELEASE}.vpk
    COMMAND cp openfodder.vpk ${CMAKE_SOURCE_DIR}/release/openfodder-${openfodder_VERSION_MAJOR}.${openfodder_VERSION_MINOR}.${openfodder_VERSION_RELEASE}.vpk
    DEPENDS openfodder.vpk
    COMMENT "Moving vpk to release"
  )
  add_custom_target(openfodderbinvpk_ ALL DEPENDS ${CMAKE_SOURCE_DIR}/release/openfodder-${openfodder_VERSION_MAJOR}.${openfodder_VERSION_MINOR}.${openfodder_VERSION_RELEASE}.vpk)


