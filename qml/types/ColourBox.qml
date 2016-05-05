import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/ColourStore.js" as ColourStore

Rectangle {
    id: box
    x: Theme.paddingMedium
    width: parent.width - 2*x
    height: width
    radius: x
    border.color: 'white'
    border.width: 2
    color: ColourStore.colour()
}
