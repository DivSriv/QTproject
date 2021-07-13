import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0
Item {
    CustomTextField{
        id: textField
        placeholderText: "Vehicle Number"
        Layout.fillWidth: true
        Keys.onEnterPressed: {
            backend.welcomeText(textField.text)
        }
        Keys.onReturnPressed: {
            backend.welcomeText(textField.text)
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
