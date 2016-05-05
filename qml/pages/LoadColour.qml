/* loading a colour
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

Page {
    id: page

    SilicaListView {
        id: listView
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Load Colour")
        }

        property var colours: Settings.get()

        model: colours.length

        delegate: ListItem {
            id: delegate
            menu: contextMenu
            ListView.onRemove: animateRemoval(delegate)

            function remove() {
                var currentColour = listView.colours[index];
                remorseAction(qsTr('Deleting'), function() {
                    Settings.remove(currentColour.theId);
                    listView.model.remove(index);
                });
            }

            Grid {
                columns: 3
                spacing: Theme.paddingMedium

                ColourBox {
                    id: box
                    width: Theme.iconSizeMedium
                    radius: Theme.paddingMedium
                    color: listView.colours[index].colour
                }

                Label {
                    text: listView.colours[index].name
                    //anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    text: listView.colours[index].colour
                    //anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: {
                var currentColour = listView.colours[index];
                ColourStore.setHexColour(currentColour.colour);
                pageStack.previousPage().reloadColours();
                pageStack.pop();
            }
            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: qsTr('Remove')
                        onClicked: remove()
                    }
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
