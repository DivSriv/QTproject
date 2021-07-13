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

        //Label {
            //id: labelZ
            //y: 48
            //height: 50
            //color: "#55aaff"
            //text: qsTr("")
            //anchors.left: parent.left
            //anchors.right: parent.right
            //horizontalAlignment: Text.AlignLeft
            //verticalAlignment: Text.AlignVCenter
            //anchors.rightMargin: 78
            //anchors.leftMargin: 362
            //font.pointSize: 12
        //}
        Label {
            id: labelCom
            y: 48
            height: 50
            color: "#55aaff"
            text: qsTr("Weight : 0.0 Kg")
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 78
            anchors.leftMargin: 362
            font.pointSize: 17
        }        


        Label {
            id: labelDate
            y: 215
            height: 50
            color: "#55aaff"
            text: qsTr("")
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 383
            anchors.leftMargin: 57
            font.pointSize: 12
        }

        CustomTextField{
            id: vno
            x: 48
            y: 40
            width: 239
            height: 65
            font.family: "Tahoma"
            font.pointSize: 15
            placeholderText: "Vehicle Number"
            Layout.fillWidth: true
        }

        CustomTextField {
            id: cno
            x: 48
            y: 119
            width: 239
            height: 69
            font.family: "Tahoma"
            font.pointSize: 15
            Layout.fillWidth: true
            placeholderText: "Customer Name"
        }
        Button {
            id: btnsubmit
            x: 187
            y: 289
            text: qsTr("Submit")
            font.bold: true
            font.pointSize: 12
            onClicked:{
                backend.getTextField(vno.text)
                backend.getTextField(cno.text)
                backend.getTextField(labelDate.text)
                backend.getTextField(labelCom.text)
                backend.op()

            }
        }


    }

     Connections{
        target: backend
        function onPrintTime(t){
            labelDate.text = t
        }
        //function onPrintZ(t){
            //labelZ.text = t
        //}
        function onPrintCom(c){
            labelCom.text = c
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:640}
}
##^##*/
