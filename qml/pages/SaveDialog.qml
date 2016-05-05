/* saving a colour
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
import "../types"
import "ColourStore.js" as ColourStore
import "Settings.js" as Settings

Dialog {
    Column {
        width: parent.width

        DialogHeader {
            id: header
            title: qsTr("Save Colour")
        }

        Grid {
            width: parent.width
            columns: 2
            spacing: Theme.paddingMedium

            ColourBox {
                id: colourBox
                width: parent.width / parent.columns - parent.spacing
                radius: Theme.paddingMedium
            }

            Column {
                width: parent.width / parent.columns - parent.spacing

                Label {
                    text: colourBox.color
                }

                TextField {
                    id: name
                    width: parent.width
                    label: qsTr("Colour Name")
                }
            }
        }
    }

    onAccepted: {
        Settings.save(colourBox.color, name.text)
    }
}
