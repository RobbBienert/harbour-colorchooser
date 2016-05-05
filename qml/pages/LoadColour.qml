/* loading and editing a colour
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

// To think about:
// Instead of a Page we also could use a Dialog. Cancel would neither
// load a colour nor delete an item. By clicking Accept all deletes
// would be applied and the selected colour be set.

Page {
    id: page

    SilicaListView {
        id: listView
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Load/Edit Colour")
        }

        /* XXX I haven't found out how to use "a real" data model, so
         * here it works like this: We store everything from the
         * database in a property. The "actual" model is just the array
         * length – and then there is QML magic doing the rest.
         */
        property var colours: Settings.get()

        model: colours.length

        // This idea is taken from the QML and Sailfish.Silica documentation:
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
                x: Theme.paddingMedium

                ColourBox {
                    id: box
                    width: Theme.iconSizeMedium
                    radius: Theme.paddingMedium
                    color: listView.colours[index].colour
                }

                Label {
                    text: listView.colours[index].name
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    text: listView.colours[index].colour
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            /* This handler is only called when we click the item –
             * not when tapping.
             */
            onClicked: {
                var currentColour = listView.colours[index];
                ColourStore.setHexColour(currentColour.colour);
                pageStack.previousPage().reloadColours();
                pageStack.pop();
            }
            // The ContextMenu pops up when we tap an item.
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
