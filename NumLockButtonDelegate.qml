import QtQuick

Rectangle {
    id: root
    required property string num
    property real numSize
    signal pressed
    signal released

    width: 50
    height: 50
    radius: width / 2

    color: "transparent"
    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onPressed: {
            tapDetectorOverlay.width = root.width
            tapDetectorOverlay.height = root.height
            tapDetectorOverlay.radius = root.radius
            tapDetectorOverlay.visible = true
            root.pressed()
        }
        onReleased: {
            tapDetectorOverlay.width = 0
            tapDetectorOverlay.height = 0
            tapDetectorOverlay.radius = 0
            tapDetectorOverlay.visible = false
            root.released()
            console.log("Num was clicked!")
        }
    }

    Text {
        id: numText
        anchors.centerIn: parent
        color: "white"
        text: root.num
        font.pixelSize: root.numSize
    }

    Rectangle {
        id: tapDetectorOverlay
        anchors.centerIn: parent
        color: "white"
        opacity: 0.34
        visible: false

        Behavior on width {
            NumberAnimation {
                duration: 10
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: 10
            }
        }

        Behavior on radius {
            NumberAnimation {
                duration: 25
            }
        }
    }
}
