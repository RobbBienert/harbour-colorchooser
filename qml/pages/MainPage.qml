/* Main Application Page
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


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About …")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            property bool manualEditing: false

            width: page.width
            PageHeader {
                title: qsTr("Colour Chooser")
            }

            ColourSlider {
                id: red
                label: qsTr('Red')

                onSliderValueChanged: {
                    if (column.manualEditing)
                        column.manualEditing = false
                    else {
                        ColourStore.r(value)
                        colour.color = ColourStore.colour()
                    }
                }
            }
            ColourSlider {
                id: green
                label: qsTr('Green')

                onSliderValueChanged: {
                    if (column.manualEditing)
                        column.manualEditing = false
                    else {
                        ColourStore.g(value)
                        colour.color = ColourStore.colour()
                    }
                }
            }
            ColourSlider {
                id: blue
                label: qsTr('Blue')

                onSliderValueChanged: {
                    if (column.manualEditing)
                        column.manualEditing = false
                    else {
                        ColourStore.b(value)
                        colour.color = ColourStore.colour()
                    }
                }
            }

            Rectangle {
                id: colour
                x: Theme.paddingLarge
                y: Theme.paddingMedium
                width: column.width - 2*x
                height: 200
                radius: Theme.paddingMedium
                color: column.manualEditing ? colourName.text : Qt.rgba(red.value/255, green.value/255, blue.value/255, 1)
                border.color: 'white'
                border.width: 2

                onColorChanged: {
                    if (! column.manualEditing)
                        colourName.text = color
                }
            }
            TextField {
                id: colourName
                width: parent.width - 2 * parent.spacing
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.Center
                validator: RegExpValidator { regExp: /^\#[0-9a-f]{,6}$/ }
                inputMethodHints: Qt.ImhNoPredictiveText

                onTextChanged: {
                    if (! (column.manualEditing && (text.length === 4 || text.length === 7)))
                        return;

                    var r, g, b

                    if (text.length === 7) {
                        r = parseInt(colourName.text.substr(1, 2), 16)
                        g = parseInt(colourName.text.substr(3, 2), 16)
                        b = parseInt(colourName.text.substr(5, 2), 16)
                    }
                    else if (text.length === 4) {
                        r = parseInt(text[1], 16)
                        g = parseInt(text[2], 16)
                        b = parseInt(text[3], 16)
                    }
                    ColourStore.setColour(r, g, b)
                    colour.color = text
                    red.value = r
                    green.value = g
                    blue.value = b
                }
                onClicked: {
                    column.manualEditing = true
                }
            }
        }
    }
}
