/* display the current colour fullscreen
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
import "ColourStore.js" as ColourStore

Page {
    id: page

    Column {
        width: parent.width
        height: parent.height

        PageHeader {
            id: header
            title: qsTr("Fullscreen")
        }

        Rectangle {
            id: box
            width: parent.width
            height: parent.height - header.height
            color: ColourStore.colour()

            Rectangle {
                property int padding: 2 * Theme.paddingMedium
                anchors.centerIn: parent
                width: colourName.contentWidth + padding
                height: colourName.height + padding
                color: Theme.highlightBackgroundColor
                Label {
                    id: colourName
                    anchors.centerIn: parent
                    width: parent.width
                    horizontalAlignment: Text.Center
                    text: ColourStore.colour()
                }
            }
        }
    }
}
