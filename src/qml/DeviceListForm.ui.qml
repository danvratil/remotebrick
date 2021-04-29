import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Page {
    property var deviceModel
    property bool loading: true

    property alias scanToolButton: scanToolButton
    property alias deviceDelegate: deviceListView.delegate

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                Layout.fillWidth: true

                text: qsTr("Connect to device...")
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }

            ToolButton {
                id: scanToolButton
                icon.name: loading ? "process-stop" : "view-refresh"
            }
        }
    }

    ListView {
        id: deviceListView
        anchors.fill: parent
        model: deviceModel
    }
}
