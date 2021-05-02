/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12

Rectangle {
    id: rect
    property alias text: label.text

    color: "black" //Qt.rgba(0, 0, 0, 0.6)
    radius: 30

    opacity: 0.0

    states: [
        State {
            name:  "visible"
            PropertyChanges { target: rect; opacity: 1.0 }
        },
        State {
            name: "invisible"
            PropertyChanges { target: rect; opacity: 0.0 }
        }
    ]

    transitions: Transition {
        from: "invisible"
        to: "visible"
        reversible: true
        PropertyAnimation { property: "opacity"; duration: 200; easing.type: Easing.InOutQuad }
    }

    state: "invisible"

    width: label.width + 40
    height: label.height + 20

    anchors.horizontalCenter: parent.horizontalCenter
    y: parent.height - height - 50
    z: 1000

    Label {
        id: label
        color: "white"
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: hide()
    }

    Timer {
        id: showTimer
        interval: 5000
        repeat: false

        onTriggered: hide();
    }

    function show(text) {
        if (showTimer.running) {
            return;
        }

        rect.text = text
        rect.state = "visible"
        showTimer.start()
    }

    function hide() {
        rect.state = "invisible"
    }
}
