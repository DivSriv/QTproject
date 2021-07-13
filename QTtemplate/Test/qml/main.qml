import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"
import QtQuick.Dialogs 1.3

Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#b84343"
    title: qsTr("Test")

    // Remove title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    // Propeties
    property int windowStatus: 0
    property int windowMargin: 10

    // Text Edit Properties
    //property alias actualPage: stackView.currentItem

    // Internal functions
    QtObject{
        id: internal

        function resetResizeBorders(){
            // Resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                btnMaximizeRestore.btnIconSource = "../images/svg_images/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            // Resize visibility
            internal.resetResizeBorders()
            btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
        }
    }




    Rectangle {
        id: bg
        color: "#323030"
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                }

            Rectangle {
                id: titleBar
                height: 35
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 105
                anchors.leftMargin: 70
                anchors.topMargin: 0

                DragHandler {
                    onActiveChanged: if(active){
                                         mainWindow.startSystemMove()
                                         internal.ifMaximizedWindowRestore()
                                     }
                }

                Label {
                    id: label
                    color: "#c3cbdd"
                    text: qsTr("Test")
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 10
                }
            }

            Row {
                id: rowBtns
                x: 872
                width: 105
                height: 35
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0

                TopBarButton{
                    id: btnMinimize
                    btnColorDefault: "#55ff00"
                    onClicked: {
                        mainWindow.showMinimized()
                        internal.restoreMargins()
                    }
                }

                TopBarButton {
                    id: btnMaximizeRestore
                    wheelEnabled: false
                    highlighted: false
                    btnColorDefault: "#ffa305"
                    btnIconSource: "../images/svg_images/maximize_icon.svg"
                    onClicked: internal.maximizeRestore()
                }

                TopBarButton {
                    id: btnClose
                    btnColorDefault: "#ff0000"
                    btnColorClicked: "#f08282"
                    btnIconSource: "../images/svg_images/close_icon.svg"
                    onClicked: mainWindow.close()
                }
              }

        Rectangle {
            id: content
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0

            Rectangle {
                id: leftMenu
                width: 70
                color: "#1c1d20"
                radius: 2
                border.width: 2
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                clip: true
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0

                PropertyAnimation{
                    id: animationMenu
                    target: leftMenu
                    property: "width"
                    to: if(leftMenu.width == 70) return 250; else return 70
                    duration: 500
                    easing.type: Easing.InOutQuint
                }

                Column {
                    id: columnMenus
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 90
                    anchors.topMargin: 0

                    LeftMenuBtn {
                        id: btnHome
                        width: leftMenu.width
                        text: qsTr("Home")
                        isActiveMenu: true
                        onClicked: {
                            btnHome.isActiveMenu = true
                            btnSettings.isActiveMenu = false
                            stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                        }
                    }


                    LeftMenuBtn {
                        id: btnManager
                        width: leftMenu.width
                        text: qsTr("Manager Password")
                        btnIconSource: "../images/svg_images/key.svg"
                        isActiveMenu: true
                    }
                    LeftMenuBtn {
                        id: btnServiceEngineer
                        width: leftMenu.width
                        text: qsTr("Service Engineer Password")
                        btnIconSource: "../images/svg_images/car.svg"
                        isActiveMenu: true
                    }
                }

                LeftMenuBtn {
                    id: btnSettings
                    width: leftMenu.width
                    text: qsTr("Settings")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    btnIconSource: "../images/svg_images/settings_icon.svg"
                    onClicked: {
                        btnHome.isActiveMenu = false
                        btnSettings.isActiveMenu = true
                        stackView.push(Qt.resolvedUrl("pages/settingsPage.qml"))
                    }
                }
            }

            Rectangle {
                id: contentPages
                color: "#00000000"
                anchors.left: leftMenu.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                clip: true
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 25
                anchors.topMargin: 0

                StackView {
                    id: stackView
                    anchors.fill: parent
                    initialItem: Qt.resolvedUrl("pages/homePage.qml")
                }
            }

            Rectangle {
                id: rectangle
                color: "#282c34"
                anchors.left: leftMenu.right
                anchors.right: parent.right
                anchors.top: contentPages.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0

                MouseArea {
                    id: resizeWindow
                    x: 884
                    y: 0
                    width: 25
                    height: 25
                    opacity: 0.5
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    cursorShape: Qt.SizeFDiagCursor

                    DragHandler{
                        target: null
                        onActiveChanged: if (active){
                                             mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                         }
                    }

                    Image {
                        id: resizeImage
                        width: 16
                        height: 16
                        anchors.fill: parent
                        source: "../images/svg_images/resize_icon.svg"
                        anchors.leftMargin: 5
                        anchors.topMargin: 5
                        sourceSize.height: 16
                        sourceSize.width: 16
                        fillMode: Image.PreserveAspectFit
                        antialiasing: false
                    }
                }
             }
          }
      }
   }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
