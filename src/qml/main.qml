import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window

    visible: true
    title: qsTr("Remote Brick")

    Material.theme: Material.System

    StackView {
        id: stackView
        initialItem: "DeviceList.qml"
        anchors.fill: parent
    }
}
