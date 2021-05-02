/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

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
