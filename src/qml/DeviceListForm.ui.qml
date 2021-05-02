import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import "./components"

PageWithHeader {
    property var deviceModel
    property bool loading: true

    property alias deviceDelegate: deviceListView.delegate

    pageTitle: qsTr("Connect to device")
    backButton.visible: false
    toolButton.icon.name: loading ? "process-stop" : "view-refresh"


    ListView {
        id: deviceListView
        anchors.fill: parent
        model: deviceModel
    }
}
