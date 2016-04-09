import QtQuick 2.0

/**
 * a SailText implementing hyperlinks
 *
 * Project: various SailfishOS apps
 * Copyright (C) 2016 Robert Bienert
 * Contact: Robert Bienert <robertbienert@gmx.net>
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

SailText {
    textFormat: Text.StyledText
    onLinkActivated: Qt.openUrlExternally(link)
}

