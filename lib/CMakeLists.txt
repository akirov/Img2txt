cmake_minimum_required(VERSION 3.1)


include_directories (${CMAKE_CURRENT_SOURCE_DIR})

if (USE_OPENCV)
  include_directories (${OpenCV_INCLUDE_DIRS})
endif (USE_OPENCV)


set (LIB_SOURCES Img2txt.cpp Img2txt.h TxtDetect.cpp TxtDetect.h)


add_library (img2txt STATIC ${LIB_SOURCES})


#install (TARGETS img2txt DESTINATION ${INSTALL_DIR})
