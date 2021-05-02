/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

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
