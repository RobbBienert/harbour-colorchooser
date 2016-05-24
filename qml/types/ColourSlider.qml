/* A Slider optimized for manipulating RGB colour values
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
import "../pages/ColourStore.js" as ColourStore

Slider {
    width: parent.width
    minimumValue: 0
    maximumValue: 255
    stepSize: 1.
    valueText: value.toString()
    property string tag: ''         // given to ColourStore.setAColour
    property var updateWidget       // needs to have a manuelEditing switch
    property var updateColours: []  // widgets that get their color updated

    onSliderValueChanged: {
        if (updateWidget.manualEditing)
            updateWidget.manualEditing = false
        else {
            ColourStore.setAColour(tag, value)

            for (var i = 0; i < updateColours.length; ++i)
                updateColours[i].color = ColourStore.colour()
        }
    }
}
