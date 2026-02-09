import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    width: parent.width
    height: contentRow.height + 30

    required property string timeText
    required property string contextText
    required property string titleText
    required property bool isUnread

    property bool hasButtons: false

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
    }

    // Separator line
    Rectangle {
        width: parent.width
        height: 1
        color: "#F0F0F0"
        anchors.bottom: parent.bottom
    }

    RowLayout {
        id: contentRow
        width: parent.width - 40
        anchors.centerIn: parent
        spacing: 15


        // Main Content Column
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            // Top Row: Author + Action
            Text {
                text: root.titleText
                color: "#333"
                font.pixelSize: 14
                Layout.fillWidth: true
            }

            // Subtitle: Time + Context
            Text {
                text: root.timeText + " • " + root.contextText
                color: "#888"
                font.pixelSize: 12
            }

        }

        // Unread Blue Dot
        Rectangle {
            visible: root.isUnread
            width: 8
            height: 8
            radius: 4
            color: "#007AFF"
            Layout.alignment: Qt.AlignTop
            Layout.topMargin: 6
        }
    }
}
