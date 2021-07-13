import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0

Item {
    id: item1
    Rectangle {
        id: rectangle
        visible: true
        color: "#2c313c"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        //
        PWbtn {
            x: 202
            y: 94
            text: ""
            clip: false
            display: AbstractButton.TextBesideIcon
            checkable: false
            highlighted: false
            flat: false
            onClicked: {
                //btnHome.isActiveMenu = false
                //btnSettings.isActiveMenu = true
                stackView.push(Qt.resolvedUrl("PWpage.qml"))
            }
        }

        NWbtn {
            x: 372
            y: 94
            width: 79
            height: 65
            clip: false
            onClicked: {
                //btnHome.isActiveMenu = false
                //btnSettings.isActiveMenu = true
                stackView.push(Qt.resolvedUrl("NWpage.qml"))
            }
        }

        }

    }

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:2}D{i:3}
}
##^##*/
