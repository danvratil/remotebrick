import QtQuick 2.4

ConnectingPageForm {
    Connections {
        target: backButton
        function onClicked() {
            // pop all the way up to the device list
            stackView.pop(null)
        }
    }
}
