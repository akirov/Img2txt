cmake_minimum_required(VERSION 3.1)

project(Img2txt)


set (USE_OPENCV FALSE)


# Set OpenCV installation location, if needed
if (USE_OPENCV)
  if (MINGW)
    #set(OpenCV_DIR "D:/OpenCV/mingw/install")
    #set(OpenCV_DIR "D:/OpenCV/2.4.13.6/mingw530_32/install")
    set(OpenCV_DIR "D:/OpenCV/3.4.5/mingw530_32/install")
  elseif (MSVC)
    #set(OpenCV_DIR "D:/OpenCV/2.4.13.6/vs2015/install")
    set(OpenCV_DIR "D:/OpenCV/3.4.5/vs2015/install")
  endif (MINGW)

  find_package(OpenCV REQUIRED)
endif (USE_OPENCV)


# Set Qt location if needed
if (MINGW)
  set(Qt5Core_DIR "D:/Qt/5.9.6/mingw53_32")
  #set(Qt5Core_DIR "D:/Qt/Qt5.5.1/5.5/mingw492_32")
elseif (MSVC)
  set(Qt5Core_DIR "D:/Qt/5.9.6/msvc2015_64")
elseif (LINUX)
  # 'CMAKE_PREFIX_PATH=/opt/Qt/5.9.8/gcc_64/lib/cmake cmake .'
endif (MINGW)

find_package (Qt5Core QUIET)
if (Qt5Core_FOUND)
  message(STATUS "Using Qt5")
  find_package(Qt5 COMPONENTS Core Widgets Gui Quick REQUIRED)
else (Qt5Core_FOUND)
  message(FATAL_ERROR "Qt5 not found!")
endif (Qt5Core_FOUND)


# Enable or disable logging. Log file is in bin directory.
set (ENABLE_LOG TRUE)


# Use C++ standard (98, 11, 14)
set (CMAKE_CXX_STANDARD 11)
set (CXX_EXTENSIONS OFF)


# Default build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif(NOT CMAKE_BUILD_TYPE)


if (ENABLE_LOG)
  add_definitions(-DENABLE_LOG)
endif (ENABLE_LOG)


set(INSTALL_DIR ${CMAKE_SOURCE_DIR}/bin)
set(LIB_DIR     ${CMAKE_SOURCE_DIR}/lib)
set(GUI_DIR     ${CMAKE_SOURCE_DIR}/gui)


add_subdirectory(lib)
add_subdirectory(gui)
