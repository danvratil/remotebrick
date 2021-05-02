import QtQuick 2.4
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "./components"

PageWithHeader {

    property alias controls: controls
    property alias toaster: toaster

    ControlsView {
        id: controls
        anchors {
            fill: parent
            margins: 50
        }
    }

    Toaster {
        id: toaster
    }
}
