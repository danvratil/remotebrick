/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import QtBluetooth 5.12

ApplicationWindow {
    id: window

    width: 800
    height: 600

    visible: true
    title: qsTr("Remote Brick")

    Material.theme: Material.System

    StackView {
        id: stackView
        initialItem: "DeviceList.qml"
        anchors.fill: parent
    }
}
