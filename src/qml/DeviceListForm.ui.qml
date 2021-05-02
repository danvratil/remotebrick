/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import "./components"

PageWithHeader {
    property var deviceModel
    property bool loading: true

    property alias deviceDelegate: deviceListView.delegate
    property alias toaster: toaster

    pageTitle: qsTr("Connect to device")
    backButton.visible: false
    toolButton.icon.source: loading ? "qrc:/icons/process-stop" : "qrc:/icons/view-refresh"

    ListView {
        id: deviceListView
        anchors.fill: parent
        model: deviceModel
    }

    Toaster {
        id: toaster
    }
}
