import QtQuick
import QtQuick.Controls
import qs.Notifications

Rectangle {
    id: notificationRoot

    required property var modelData
    
    property color accentColor: "#3498db" // Blue
    
    width: 320
    height: 80
    radius: 8
    color: "#ffffff"
    
    // Drop Shadow effect using a border (simplest way without extra imports)
    border.color: "#eeeeee"
    border.width: 1

    // Layout
    Row {
        anchors.fill: parent
        spacing: 12
        anchors.margins: 12

        // Status Accent Bar
        Rectangle {
            width: 4
            height: parent.height
            radius: 2
            color: notificationRoot.accentColor
        }

        Column {
            width: parent.width - 40
            spacing: 4
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: notificationRoot.notif.summary
                font.pixelSize: 14
                font.bold: true
                color: "black"
            }

            Text {
                text: notificationRoot.notification.message
                font.pixelSize: 12
                color: "#7f8c8d"
                wrapMode: Text.WordWrap
                width: parent.width
            }
        }
    }

    // Auto-dismiss logic
}
