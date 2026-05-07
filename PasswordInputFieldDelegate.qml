import QtQuick

Rectangle {
    id: root
    property bool numOccupied: false

    // anchors.fill: parent
    width: 12
    height: 12
    radius: width / 2
    color: numOccupied ? "white" : "transparent"
    border.color: "white"
}
