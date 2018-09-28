.pragma library

/* saving the current colour in memory for the cover page
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

function hsl2rgb(h, s, l) {
    return Qt.hsla(h/360., s/100., l/100., 1.);
}

/*
 */
function rgb2hsl(r, g, b, base) {
	// normalize RGB from 0-255 to 0-1
	r = r/base;
	g = g/base;
	b = b/base;
	var maxVal = Math.max(Math.max(r, g), b);
	var minVal = Math.min(Math.min(r, g), b);
	var maxDiff = maxVal - minVal;
	
    /* see https://en.wikipedia.org/wiki/HSL_and_HSV for details about
     * how to converte RGB into HSL values.
     */
	var h = 0.;
	if (maxVal != minVal) {
		if (maxVal === r)
			h = (g -b) / maxDiff;
		else if (maxVal === g)
			h = 2 + (b -r) / maxDiff;
		else
			h = 4 + (r - g) / maxDiff;
		h *= 60.;
	}
	
	var s = (0 === maxVal || 1 === minVal) ? s = 0. :
		maxDiff / (1 - Math.abs(maxVal + minVal - 1));
	
	return [h, s, (maxVal + minVal)/2.];
}

function tohsl() {
    return rgb2hsl(_rr, _gg, _bb, 1)
}

function updateHSL() {
    var hsl = tohsl()
    h(hsl[0])
    _ss = hsl[1]
    _s = _ss * 100
    _ll = hsl[2]
    _l = _ll * 100
}

// The following ColourModel stuff is needed for switching between RGB and HSL.

/* (name, s1Name, s1Max, s2Name, s2Max, s3Name, s3Max, hexColour=null)
 */
function ColourModel() {
    if (arguments.length < 7)
        throw "Wrong parameter count!"

    this.name  = arguments[0];
    this.s1Name = arguments[1];
    this.s1Max = arguments[2];
    this.s2Name = arguments[3];
    this.s2Max = arguments[4];
    this.s3Name = arguments[5];
    this.s3Max = arguments[6];

    if (8 === arguments.length)
        this.toHex = arguments[7];
    else
        this.toHex = function(arg) { return arg; }
}

var RGBModel = 0;
var HSLModel = 1;
var model = 0;
var ModelSet = [new ColourModel("RGB", qsTr("Red"), 255, qsTr("Green"), 255, qsTr("Blue"), 255),
                new ColourModel("HSL", qsTr("Hue")+"/°", 360, qsTr("Saturation/%"), 100, qsTr("Lightness/%"), 100, hsl2rgb)];

function currentModelSet() {
    return ModelSet[model];
}

function nextModel() {
    return (model + 1) % ModelSet.length;
}

function setNextModel() {
	model = nextModel();
}

function nextModelSet() {
	return ModelSet[nextModel()];
}

/* RGB colour variables
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
function r() {
    if (0 === arguments.length) return _r;

    _r = arguments[0];
    _rr = _r / MAX;
}

function g() {
    if (0 === arguments.length) return _g;

    _g = arguments[0];
    _gg = _g / MAX;
}

function b() {
    if (0 === arguments.length) return _b;

    _b = arguments[0];
    _bb = _b / MAX;
}

// HSL colour variables
var _h = 0;
var _s = 0;
var _l = 0;
var _hh = 0.;
var _ss = 0.;
var _ll = 0.;

function h() {
    if (0 === arguments.length) return _h;

    _h = arguments[0];
    _hh = _h / 360.;
}

function s() {
    if (0 === arguments.length) return _s;

    _s = arguments[0];
    _ss = _s / 100.;
}

function l() {
    if (0 === arguments.length) return _l;

    _l = arguments[0];
    _ll = _l / 100.;
}

function setHexColour(hexString) {
    hexString = hexString.toString()
    var r_ = parseInt(hexString.substr(1, 2), 16);
    var g_ = parseInt(hexString.substr(3, 2), 16);
    var b_ = parseInt(hexString.substr(5, 2), 16);

    r(r_); g(g_); b(b_);
}

function setAColour(name, value) {
    if (model === RGBModel) {
        switch (name) {
        case 'r':
            r(value); break;
        case 'g':
            g(value); break;
        case 'b':
            b(value); break;
        }
    }
    else if (model === HSLModel) {
        switch (name) {
        case 'r':
            h(value); break;
        case 'g':
            s(value); break;
        case 'b':
            l(value); break;
        }

        setHexColour(Qt.hsla(_hh, _ss, _ll, 1.));
    }
}

function setColour(newR, newG, newB) {
    if (model === RGBModel) {
        r(newR); g(newG); b(newB);
    } else if (model === HSLModel) {
        h(newR); s(newG); l(newB);
    }
}

// getter
function rgb() {
    return [_r, _g, _b];
}

function hsl() {
    return [_h, _s, _l];
}

function currentColours() {
    if (model === RGBModel) {
        return rgb()
    } else if (model === HSLModel) {
        return hsl()
    }
}

function colour() {
    return Qt.rgba(_rr, _gg, _bb, 1.);
}
