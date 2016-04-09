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

CoverBackground {
    id: cover

    Column {
        anchors.centerIn: parent
        spacing: Theme.paddingLarge

        Label {
            id: label
            text: qsTr("Colour Chosen:")
        }

        Rectangle {
            id: box
            x: Theme.paddingMedium
            width: parent.width - 2*x
            height: width
            radius: x
            border.color: 'white'
            border.width: 2
            color: ColourStore.colour()
        }

        Label {
            id: colourName
            width: parent.width
            text: box.color
            horizontalAlignment: Text.Center
        }
    }

    onStatusChanged: {
        if (cover.status === Cover.Active) {
            box.color = ColourStore.colour()
        }
    }
}


