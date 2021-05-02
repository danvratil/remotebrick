import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

GridLayout {
    property alias forwardButton: forwardButton
    property alias reverseButton: reverseButton
    property alias leftButton: leftButton
    property alias rightButton: rightButton

    columns: 3
    rows: 3

    Button {
        id: forwardButton
        Layout.row: 0
        Layout.column: 1
        Layout.fillHeight: true
        Layout.fillWidth: true
        icon.source: "qrc:/icons/arrow-up"
    }

    Button {
        id: leftButton
        Layout.row: 1
        Layout.column: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
        icon.source: "qrc:/icons/arrow-left"
    }

    Button {
        id: rightButton
        Layout.row: 1
        Layout.column: 2
        Layout.fillHeight: true
        Layout.fillWidth: true
        icon.source: "qrc:/icons/arrow-right"
    }

    Button {
        id: reverseButton
        Layout.row: 2
        Layout.column: 1
        Layout.fillHeight: true
        Layout.fillWidth: true
        icon.source: "qrc:/icons/arrow-down"
    }

}
