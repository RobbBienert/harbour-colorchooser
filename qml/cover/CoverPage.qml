/* The Application Cover Page
 *
 * Copyright (C) 2016 Robert Bienert
 * project harbour-colorchooser
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License <http://www.gnu.org/licenses/gpl-3.0>
 * for more details.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/ColourStore.js" as ColourStore
import "../types"

CoverBackground {
    id: cover

    Column {
		anchors.centerIn: parent
        spacing: Theme.paddingMedium

        Label {
            id: label
            text: qsTr("Colour Chosen:")
        }

        ColourBox {
            id: box
        }

        Label {
            id: colourName
            width: parent.width
            text: box.color
            horizontalAlignment: Text.Center
        }
        Label {
			text: " "
        }

        CoverActionList {
            id: coverAction

            /* CoverAction handling taken from the worldclock app by a-dekker
             * https://github.com/a-dekker/worldclock/
             */
            CoverAction {
                iconSource: "image://theme/icon-s-new"
                onTriggered: {
                    pageStack.push(Qt.resolvedUrl("../pages/SaveDialog.qml"))
                    pageStack.completeAnimation()
                    app.activate()
                }
            }

            CoverAction {
                iconSource: "image://theme/icon-s-setting"
                onTriggered: {
                    pageStack.push(Qt.resolvedUrl("../pages/LoadColour.qml"))
                    pageStack.completeAnimation()
                    app.activate()
                }
            }
            CoverAction {
                iconSource: "image://theme/icon-s-device-upload"
                onTriggered: {
                    pageStack.push(Qt.resolvedUrl("../pages/FullScreen.qml"))
                    pageStack.completeAnimation()
                    app.activate()
                }
            }
        }
    }

    onStatusChanged: {
        /* This handler is called e.g. if the CoverPage becomes active,
         * i.e. when we switch to the application cover or change the
         * app and then return to this app.
         */
        if (cover.status === Cover.Active) {
            box.color = ColourStore.colour()
        }
    }
}
