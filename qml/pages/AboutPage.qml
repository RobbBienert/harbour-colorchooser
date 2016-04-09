/* AboutPage
 *
 * Copyright © 2016 Robert Bienert <robertbienert@gmx.net>
 * project harbour-hexclock
 *
 * See the TextWithLink component below for the license.
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
            height: header.height + about.implicitHeight + copyright.implicitHeight + link.implicitHeight + license.implicitHeight + 5 * spacing
            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium

            PageHeader {
                id: header
                title: qsTr("About Colour Chooser")
            }

            SailText {
                id: about
                text: qsTr("choose a RGB colour from sliders for red, green and blue")
            }
            SailText {
                id: copyright
                text: "Version 0.1-2\nCopyright © 2016 Robert Bienert"
            }
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