import QtQuick 2.4
import QtQuick.Controls 2.12
import cz.dvratil.remotebrick 1.0
import "./components"
import "./Commands.js" as Commands

DevicePageForm {
    property var deviceName
    property alias deviceAddress: connection.deviceAddress

    pageTitle: qsTr("Connected to %1").arg(deviceName)

    BluetoothConnection {
        id: connection

        onConnectedChanged: function() {
            if (connected) {
                stackView.pop(StackView.PushTransition)
            }
        }
    }

    Connections {
        target: backButton

        function onClicked() {
            connection.disconnectFromService();
            stackView.pop();
        }
    }

    StackView.onActivated: {
        if (!connection.connected) {
            // Immediately display ConnectingPage on top of this page. We will pop it when connected
            stackView.push("qrc:/qml/ConnectingPage.qml", {
                           "pageTitle": qsTr("Connecting..."),
                           "connectingText": qsTr("Connecting to " + deviceName)
                           }, StackView.Immediate)
        }
    }

    ActionBinding {
        connection: connection
        target: controls.forwardButton
        direction: Commands.Direction.Forward
    }

    ActionBinding {
        connection: connection
        target: controls.reverseButton
        direction: Commands.Direction.Backward
    }

    ActionBinding {
        connection: connection
        target: controls.leftButton
        direction: Commands.Direction.Left
    }

    ActionBinding {
        connection: connection
        target: controls.rightButton
        direction: Commands.Direction.Right
    }
}
