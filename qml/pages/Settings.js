.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

/*
 *
 * http://doc.qt.io/qt-5/qtquick-localstorage-localstorage-hello-qml.html
 */

var _db = Sql.LocalStorage.openDatabaseSync("Colours", "1.0", "Stored Colours");

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
