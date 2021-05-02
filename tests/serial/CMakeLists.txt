add_executable(serialtest main.cpp)
target_link_libraries(serialtest
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Bluetooth)

