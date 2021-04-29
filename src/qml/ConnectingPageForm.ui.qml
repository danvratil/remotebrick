import QtQuick 2.4
import QtQuick.Controls 2.12

Page {

    property alias label: label

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
    }

    Label {
        id: label
        anchors.top: busyIndicator.bottom
        anchors.horizontalCenter: busyIndicator.horizontalCenter
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

