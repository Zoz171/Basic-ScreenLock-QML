pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

GridLayout {
    id: root

    property real numSize

    // property string num: ""
    signal numTapped(string c)
    signal backSpaceTapped

    columns: 3
    rows: 4

    rowSpacing: 25
    columnSpacing: 50

    Repeater {
        id: nums
        model: [1, 2, 3, 4, 5, 6, 7, 8, 9]

        delegate: NumLockButtonDelegate {
            id: numDelegate
            required property string modelData

            num: {
                // root.num = modelData
                return modelData
            }
            numSize: root.numSize
            onReleased: root.numTapped(modelData)
        }
    }

    NumLockButtonDelegate {
        num: "0"
        numSize: root.numSize
        Layout.columnSpan: 2
        Layout.alignment: Qt.AlignRight
        onReleased: root.numTapped("0")
    }
    NumLockButtonDelegate {
        num: '⌫'
        numSize: root.numSize - 7
        Layout.alignment: Qt.AlignRight

        onReleased: root.backSpaceTapped()
    }
}
