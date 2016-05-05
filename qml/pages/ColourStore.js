.pragma library

/* saving the current colour in memory for the cover page
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

/* colour variables
 * The one character variable is the colour in the range [0,255],
 * two characters ones are in the range [0,1].
 */
var _r = 0;
var _rr = 0.;
var _g = 0;
var _gg = 0.;
var _b = 0;
var _bb = 0.;
var MAX = 255;

// setter functions
function r(newR) {
    if (-1 == newR) return _r;

    _r = newR;
    _rr = _r / MAX;
}

function g(newG) {
    if (-1 == newG) return _g;

    _g = newG;
    _gg = _g / MAX;
}

function b(newB) {
    if (-1 == newB) return _b;

    _b = newB;
    _bb = _b / MAX;
}

function setHexColour(hexString) {
    var r_ = parseInt(hexString.substr(1, 2), 16);
    var g_ = parseInt(hexString.substr(3, 2), 16);
    var b_ = parseInt(hexString.substr(5, 2), 16);

    setColour(r_, g_, b_);
}

function setColour(newR, newG, newB) {
    r(newR); g(newG); b(newB);
}

// getter
function rgb() {
    return [_r, _g, _b];
}

function colour() {
    return Qt.rgba(_rr, _gg, _bb);
}
