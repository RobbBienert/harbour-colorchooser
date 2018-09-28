/* AboutPage
 *
 * Copyright (C) 2016 - 2018 Robert Bienert
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

Page {
    id: aboutPage

    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: col.height + Theme.paddingLarge

        Column {
            id: col
            spacing: Theme.paddingLarge
            width: parent.width
            height: totalHeight()
            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium

            function totalHeight() {
                var h = 0;
                var l = col.children.length;

                for (var i = 0; i < l; ++i)
                     h += col.children[i].height;

                return h + l * col.spacing;
            }

            PageHeader {
                id: header
                title: qsTr("About Colour Chooser")
            }

            SailText {
                id: about
                text: qsTr("choose a RGB colour from sliders for red, green and blue\n– optionally: use HSL values (hue, saturation and lightness)")
            }
            SailText {
                id: copyright
				text: "Version 1.2\nCopyright © 2016 - 2018 Robert Bienert"
            }
            /* The standard link colour is (dark) blue, which is nearly
             * unreadable in most themes. A better link colour seems to
             * be Theme.highlightColor, but we need to set this colour
             * explicitly.
             */
            TextWithLink {
                id: link
                text: '<a href="https://github.com/RobbBienert/harbour-colorchooser"><font color="' + Theme.highlightColor + '">Git Repository &amp; Wiki</font></a>'
            }

            TextWithLink {
                id: license
                text: qsTr("This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br>This program is distributed in the hope that it will be useful, but <strong>without any warranty</strong>; without even the implied warranty of <strong>merchantability</strong> or <strong>fitness for a particular purpose</strong>.") +  ' <a href="http://www.gnu.org/licenses/gpl-3.0"><font color="' + Theme.highlightColor + '">' + qsTr("See the GNU General Public License for more details.</font></a>")
            }
        }
        ScrollDecorator {}
    }
}
