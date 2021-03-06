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
import "Settings.js" as Settings

Dialog {
    id: saveDlg
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
                width: (parent.width - parent.spacing) / parent.columns
                x: parent.spacing
                radius: Theme.paddingMedium
            }

            Column {
                width: (parent.width - parent.spacing) / parent.columns

                Label {
                    text: colourBox.color
                    // FIXME: The left padding is not the same as the TextField name.
                    x: parent.spacing
                }

                TextField {
                    id: name
                    width: parent.width
                    label: qsTr("Colour Name")
                    EnterKey.enabled: text.length > 0
                    EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                    EnterKey.onClicked: saveDlg.accept()
                }
            }
        }
    }

    onAccepted: {
        Settings.save(colourBox.color, name.text)
    }
}
