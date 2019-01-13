cmake_minimum_required(VERSION 3.1)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

FILE(GLOB_RECURSE HeaderFiles "*.h")
#add_custom_target(headers SOURCES ${HeaderFiles})

include_directories (${LIB_DIR})

add_executable(${PROJECT_NAME} "main.cpp" "Backend.cpp" "ImageContainer.cpp" ${HeaderFiles} "qml.qrc")
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE img2txt)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core Qt5::Quick)


if (USE_OPENCV)
  target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
endif (USE_OPENCV)


install (TARGETS ${PROJECT_NAME} DESTINATION ${INSTALL_DIR})
