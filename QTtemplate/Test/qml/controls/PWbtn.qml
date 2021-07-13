import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    ToolTip{
        opacity: 0.7


        visible: hovered
        font.family : "Rajdhani Bold"
        text : qsTr("Public Weighing")
        font.pixelSize: 15
        font.weight: Font.Normal
        font.bold: true
        font.italic: false
    }
    id: btnPW
    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/balance.svg"
    property color btnColorDefault: "#c0ffbd"
    property color btnColorMouseOver: "#ffb380"
    property color btnColorClicked: "#00a1f1"
    width: 80
    height: 65

    // display: AbstractButton.IconOnly
  //  hoverEnabled: true


    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnPW.down){
                                       btnPW.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnPW.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }




    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        //color: "#230303"
        color: internal.dynamicColor

        Rectangle {
            id: rectangle
            color: "#00000000"
            radius: 17
            border.color: "#e44a4a"
            border.width: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: -6
            anchors.leftMargin: -6
            anchors.bottomMargin: -5
            anchors.topMargin: -5
            layer.enabled: false
        }

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.rightMargin: 19
            anchors.leftMargin: 19
            anchors.bottomMargin: 14
            anchors.topMargin: 15
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            fillMode: Image.PreserveAspectFit
            visible: false
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ColorOverlay{
            width: 70
            height: 60
            anchors.fill: iconBtn
            source: iconBtn
            anchors.leftMargin: -22
            anchors.topMargin: -17
            anchors.rightMargin: -23
            anchors.bottomMargin: -18

            antialiasing: false
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}D{i:4}D{i:5}
}
##^##*/
