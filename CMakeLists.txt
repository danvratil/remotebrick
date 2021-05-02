cmake_minimum_required(VERSION 3.14)

project(remotebrick LANGUAGES CXX VERSION 1.0.0)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Bluetooth REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Bluetooth REQUIRED)
if (ANDROID)
    find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Svg REQUIRED)
endif()

add_subdirectory(src)
add_subdirectory(tests)
