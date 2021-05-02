import QtQuick 2.0

Item {
    property var connection
    property alias target: conn.target
    property var direction

    Connections {
        id: conn
        target: target

        function onPressed() {
            connection.sendData("+" + direction)
        }

        function onReleased() {
            connection.sendData("-" + direction)
        }
    }
}
