pragma ComponentBehavior: Bound

import QtQuick

ListView {
    id: listView
    property int topIndex: 0
    property string passwordStr: ""
    property string actualPassword: "123456"
    property bool passwordMatch: false

    signal addInput(string chr)
    signal removeInput
    signal unlocked
    signal incorrect

    function checkPassword() {
        if (passwordStr == actualPassword)
            passwordMatch = true
        else
            passwordMatch = false
    }

    function clearInput() {
        passwordStr = ""
        topIndex = 0
        forceLayout()
    }

    width: 150
    height: 12
    orientation: ListView.Horizontal
    spacing: 15

    model: 6

    delegate: PasswordInputFieldDelegate {
        required property int index
        id: pwDelegate

        numOccupied: index < listView.topIndex
    }

    onAddInput: s => {
        if (topIndex < 6) {
            topIndex++
            passwordStr += s
        }
        if (passwordStr.length == 6) {
            checkPassword()
            if (passwordMatch)
            listView.unlocked()
            else
            listView.incorrect()
            clearInput()
        }
    }

    onRemoveInput: {
        topIndex = topIndex > 0 ? topIndex - 1 : 0
        passwordStr = passwordStr.substr(0, passwordStr.length - 1)
    }
}
