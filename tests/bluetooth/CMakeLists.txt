add_executable(bluetoothtest main.cpp)
target_link_libraries(bluetoothtest
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Bluetooth
)
