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

    /* We need this function for loading a colour when we go back on the
     * PageStack. In this case the ColourStore is not re-read.
     */
    function reloadColours() {
        var currModSet = ColourStore.CurrentModelSet()
        ColourStore.updateHSL()
        var currColours = ColourStore.currentColours()

		red.maximumValue = currModSet.s1Max
		green.maximumValue = currModSet.s2Max
		blue.maximumValue = currModSet.s3Max

		switch (ColourStore.model) {
        case ColourStore.HSLModel:
			red.value = currColours[0].toFixed(0)
			green.value = currColours[1].toFixed(0)
			blue.value = currColours[2].toFixed(0)
            break;
        case ColourStore.RGBModel:
            red.value = currColours[0]
            green.value = currColours[1]
            blue.value = currColours[2]
            break;
        }

        return currModSet
    }

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
            MenuItem {
                text: qsTr("Fullscreen")
                onClicked: pageStack.push(Qt.resolvedUrl("FullScreen.qml"))
            }

            MenuItem {
                text: qsTr("Load/Edit Colour")
                onClicked: pageStack.push(Qt.resolvedUrl("LoadColour.qml"))
            }

            MenuItem {
                text: qsTr("Save Colour")
                onClicked: pageStack.push(Qt.resolvedUrl("SaveDialog.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            /* This property is necessary as some kind of "lock" while
             * editing the colour. The TextField colourName has not to
             * interfer with the ColourSliders, otherwise a infinity
             * loop would exist.
             * So colourName sets it, the slider reset it.
             */
            property bool manualEditing: false

            width: page.width
            PageHeader {
                title: qsTr("Colour Chooser")
            }

            ColourSlider {
                id: red
                label: qsTr('Red')
                tag: 'r'
                updateWidget: column
                updateColours: [colour]
            }
            ColourSlider {
                id: green
                label: qsTr('Green')
                tag: 'g'
                updateWidget: column
                updateColours: [colour]
            }
            ColourSlider {
                id: blue
                label: qsTr('Blue')
                tag: 'b'
                updateWidget: column
                updateColours: [colour]
            }

            /* This is a large colour box – but it is really different
             * from the ColourBox type.
             */
            Rectangle {
                id: colour
                x: Theme.paddingLarge
                y: Theme.paddingMedium
                width: column.width - 2*x
                height: 200
                radius: Theme.paddingMedium
                color: {
                    if (column.manualEditing)
                        return colourName.text
                    else {
                        ColourStore.setColour(red.value, green.value, blue.value)
                        return ColourStore.colour()
                    }
                }
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
                validator: RegExpValidator {
                    // only hexadecimal digits allowed
                    regExp: /^\#[0-9a-f]{,6}$/
                }
                inputMethodHints: Qt.ImhNoPredictiveText

                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: enterColour()

                function enterColour() {
                    var r, g, b

                    if (text.length === 7) {
                        ColourStore.setHexColour(colourName.text)
                        ColourStore.updateHSL()
                        var rgb = ColourStore.rgb()
                        r = rgb[0]; g = rgb[1]; b = rgb[2];
                    }
                    else if (text.length === 4) {
                        ColourStore.r(parseInt(text[1], 16))
                        ColourStore.g(parseInt(text[2], 16))
                        ColourStore.b(parseInt(text[3], 16))
                        ColourStore.updateHSL()
                    }
                    colour.color = text

					//page.updateColours()
                }

                onTextChanged: {
                    if (column.manualEditing && (text.length === 7 || text.length === 4))
                        enterColour();

                }
                onClicked: {
                    column.manualEditing = true
                }
            }
        }

        PushUpMenu {
            MenuItem {
                id: menuColourModel
                text: qsTr(ColourStore.NextModelSet().name) + qsTr(" Colour Model")
                onClicked: {
                    ColourStore.SetNextModel()
                    page.switchColourModel()
                }
            }
        }
    }

    function switchColourModel() {
        menuColourModel.text = qsTr(ColourStore.NextModelSet().name) + qsTr(" Colour Model")

        var currModSet = reloadColours()

        red.label = qsTr(currModSet.s1Name);
        green.label = qsTr(currModSet.s2Name);
        blue.label = qsTr(currModSet.s3Name);
    }

	Component.onCompleted: page.reloadColours()
}
