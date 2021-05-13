/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    property alias forwardButton: forwardButton
    property alias reverseButton: reverseButton
    property alias leftButton: leftButton
    property alias rightButton: rightButton

    id: controls

    ColumnLayout {
        Layout.alignment: Qt.AlignLeft
        Layout.fillHeight: true

        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: controls.height / 4
            Layout.preferredWidth: controls.width / 5
            id: forwardButton
            icon.source: "qrc:/icons/arrow-up"
        }


        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: controls.height / 4
            Layout.preferredWidth: controls.width / 5
            id: reverseButton
            icon.source: "qrc:/icons/arrow-down"
        }

    }

    ColumnLayout {
        Layout.alignment: Qt.AlignRight
        Layout.fillHeight: true

        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: controls.height / 4
            Layout.preferredWidth: controls.width / 5
            id: leftButton
            icon.source: "qrc:/icons/arrow-left"
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: controls.height / 4
            Layout.preferredWidth: controls.width / 5
            id: rightButton
            icon.source: "qrc:/icons/arrow-right"
        }
    }
}
