import QtQuick
import qs.Theme
import Quickshell
import Quickshell.Services.Notifications
import qs.Notifications

ShellRoot {
    NotificationServer {
        id: server
        bodySupported: true
        onNotification: n => {
            n.tracked = true;
        }
    }

    PanelWindow {
        color: "transparent"

        height: 800
        width: 400

        anchors {
            top: true
            right: true
        }

        Rectangle {
            color: Theme.bg
             
            Column {
                id: content
                spacing: 2

                rightPadding: 15
                topPadding: 15

                children: [
                    Repeater {
                        id: rep
                        model: server.trackedNotifications

                        delegate: Rectangle {
                            color: "white"
                            Text {
                                
                            text: modelData.summary
                            }
                        }
                    }
                ]
            }
        }
    }
}
