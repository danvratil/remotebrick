import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12

Page {
    property alias pageTitle: titleLabel.text
    property alias backButton: backButton
    property alias toolButton: toolButton

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: backButton
                icon.source: "qrc:/icons/arrow-left"
            }
            Label {
                id: titleLabel

                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            ToolButton {
                id: toolButton
            }
        }
    }
}
