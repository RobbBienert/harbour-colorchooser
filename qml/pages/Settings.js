.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

/* loading and saving settings using the LocalStorage
 *
 * Copyright (C) 2016 Robert Bienert
 * project harbour-colorchooser
 *
 * Idea and demo code as described in:
 * http://doc.qt.io/qt-5/qtquick-localstorage-localstorage-hello-qml.html
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

var _db = Sql.LocalStorage.openDatabaseSync("Colours", "1.0", "Stored Colours");

// init
_db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS colours (id INTEGER PRIMARY KEY AUTOINCREMENT, colour VARCHAR(7), name TINYTEXT)');
});


function save(colour, name) {
    _db.transaction(function(tx) {
        tx.executeSql('INSERT INTO colours (colour, name) VALUES (?,?)',
                      [colour, name]);
    });
}


function get() {
    var resa = Array();

    _db.transaction(function(tx) {
        var res = tx.executeSql('SELECT id, colour, name FROM colours');
        var rows = res.rows;

        for (var i = 0; i < rows.length; ++i) {
            resa.push({theId: rows.item(i).id, colour: rows.item(i).colour, name: rows.item(i).name});
        }
    });

    return resa;
}


function remove(itemId) {
    _db.transaction(function(tx) {
        tx.executeSql('DELETE FROM colours WHERE id=?', [itemId]);
    });
}
