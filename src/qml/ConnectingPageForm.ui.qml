/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.4
import QtQuick.Controls 2.12
import "./components"

PageWithHeader {
    property alias connectingText: label.text

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
    }

    Label {
        id: label
        anchors {
            horizontalCenter: busyIndicator.horizontalCenter
            top: busyIndicator.bottom
        }
    }
}
