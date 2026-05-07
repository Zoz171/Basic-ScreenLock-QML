pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 360
    height: 640
    visible: true
    title: qsTr("ScreenLock-OnePlusNord2")


    /* A better approach here to use `Loader` Type,
       But for demonstration purposes, only visiblity of lock screen is controlled */
    function lock() {
        lockBg.visible = true
        lockUI.visible = true
    }

    function unlock() {
        lockBg.visible = false
        lockUI.visible = false
    }

    MouseArea {
        anchors.fill: parent
        onDoubleClicked: window.lock()
    }

    background: Image {
        source: Qt.resolvedUrl("qrc:/assets/bridge-bg.jpg")
    }

    Rectangle {
        id: lockBg
        anchors.fill: parent
        color: "black"
        opacity: 0.76
    }

    Text {
        id: incorrectLabel
        text: "Incorrect"
        visible: false
        color: "white"
        font.pixelSize: 16
        x: window.width / 2 - width / 2
        y: 200
    }

    ColumnLayout {
        id: lockUI

        anchors.fill: parent

        Item {
            Layout.fillHeight: true
        }

        Text {
            text: "Swipe up to use fingerprint unlock"
            color: "white"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.bottomMargin: 50
        }

        PasswordInputField {
            id: pwInput
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 100

            onAddInput: s => {
                console.log(passwordStr)
            }

            onUnlocked: {
                window.unlock()
                incorrectLabel.visible = false
            }

            onIncorrect: incorrectLabel.visible = true
        }

        NumLockPad {
            numSize: 25

            // Layout.preferredHeight: 200
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 28
            onBackSpaceTapped: {
                pwInput.removeInput()
                console.log("BackSpace Tapped!!")
            }
            onNumTapped: s => {
                // console.log(s)
                pwInput.addInput(s)
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 28
            text: "Emergency SOS"
            font.pixelSize: 14
            color: "white"
        }
    }
}
