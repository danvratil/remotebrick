set(remotebrick_SRCS
    main.cpp
    bluetoothconnection.cpp bluetoothconnection.h
    qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(remotebrick ${remotebrick_SRCS})
else()
    if(ANDROID)
        add_library(remotebrick SHARED ${remotebrick_SRCS})
    else()
        add_executable(remotebrick ${remotebrick_SRCS})
    endif()
endif()

target_compile_definitions(remotebrick PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(remotebrick
    PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Bluetooth
)
