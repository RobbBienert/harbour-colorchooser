/* The Application Window
 *
 * Copyright (C) 2016 Robert Bienert
 * project harbour-colorchooser
 *
 * Code partially based on work of Thomas Perl <thomas.perl@jollamobile.com>,
 * Jolla Ltd., licensed under the BSD license.
 * Code partially based on the worldclock app by a-dekker
 * https://github.com/a-dekker/worldclock/
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
import "pages"
import "cover"

ApplicationWindow
{
    id: app
    initialPage: Component { MainPage { } }
    cover: CoverPage {}
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All
}
