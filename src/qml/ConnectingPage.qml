import QtQuick 2.4

ConnectingPageForm {

    property var device

    label.text: qsTr("Connecting to %1").arg(device)
}
