import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Theme
import qs.Notifications
import Quickshell.Services.Notifications

ShellRoot {
    NotificationServer {
        id: server
        bodySupported: true
        onNotification: n => {
            n.tracked = true;
        }
    }

    PanelWindow {
        width: 400
        height: 300

        color: "transparent"

        anchors.top: true
        anchors.right: true

        Rectangle {
            id: panel
            radius: 12

            anchors.fill: parent
            anchors.rightMargin: 7
            anchors.topMargin: 7

            color: Theme.bg

            Column {
                id: header
                width: parent.width

                Item {
                    width: parent.width
                    height: 60

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        DefaultText {
                            text: "Notifications"
                            font.bold: true
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    DefaultText {
                        text: "Mark all as read"
                        color: Theme.textMuted
                        font.pixelSize: 13
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Theme.textMuted
                }
            }

            ListView {
                anchors.top: header.bottom
                anchors.bottom: parent.bottom
                width: parent.width
                clip: true

                model: server.trackedNotifications

                NotificationModel {
                    timeText: model.expireTimeout
                    contextText: modelData.body
                    titleText: modelData.summary
                    isUnread: false
                }
            }
        }
    }
}
