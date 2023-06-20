import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: mainAppWindow

    // Set window dimensions and properties
    width: 1280
    height: 720
    minimumWidth: 640
    minimumHeight: 360
    visible: true
    title: "Home Automation"

    // Define color properties
    readonly property color colorGlow: "#1ddd14"
    readonly property color colorWarning: "#d5232f"
    readonly property color colorMain: "#6aff6a"
    readonly property color colorBright: "#ffffff"
    readonly property color colorLightGrey: "#888"
    readonly property color colorDarkGrey: "#333"

    // Set window background color
    color: "black"

    RowLayout {
        anchors.fill: parent
        spacing: 10

        // App control
        ScrollView {
            id: buttons_control
            Layout.fillHeight: true

            Container {
                id: leftTabBar

                currentIndex: 1

                Layout.fillWidth: false
                Layout.fillHeight: true

                ButtonGroup {
                    buttons: columnLayout.children
                }

                contentItem: ColumnLayout {
                    id: columnLayout
                    spacing: 3

                    Repeater {
                        model: leftTabBar.contentModel
                    }
                }

                FeatureButton {
                    id: featurebutton_control
                    text: qsTr("Dashboard")
                    icon.name: "dashboard"
                    Layout.fillHeight: true

                    checked: true

                    onClicked: {
                        contentLoader.source = "dashboard.qml"
                    }
                }

                FeatureButton {
                    text: qsTr("Security")
                    icon.name: "security"
                    Layout.fillHeight: true

                    onClicked: {
                        contentLoader.source = ""
                    }
                }

                FeatureButton {
                    text: qsTr("Settings")
                    icon.name: "settings"
                    Layout.fillHeight: true

                    onClicked: {
                        contentLoader.source = "settings.qml"
                        buttons_rooms.visible = false
                    }
                }
            }
        }

        // Content area
        Loader {
            id: contentLoader
            Layout.fillWidth: true
            Layout.preferredWidth: mainAppWindow.width
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            source: "dashboard.qml"
            onSourceChanged: {
                buttons_rooms.visible = true
            }
        }

        // Right side buttons
        ScrollView {
            id: buttons_rooms
            Layout.fillHeight: true

            Container {
                id: rightTabBar

                currentIndex: 1

                Layout.fillHeight: true

                ButtonGroup {
                    buttons: rightTabBarContentLayout.children
                }

                contentItem: ColumnLayout {
                    id: rightTabBarContentLayout
                    spacing: 3

                    Repeater {
                        model: roomModel // Bind the model to the Repeater
                        delegate: FeatureButton {
                            text: model.roomName
                            icon.name: model.roomIcon
                            Layout.maximumHeight: featurebutton_control.height
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: roomModel
        ListElement {
            roomName: "Living Room"
            roomIcon: "living-room"
        }
        ListElement {
            roomName: "Bedroom 1"
            roomIcon: "bedroom1"
        }
        ListElement {
            roomName: "Bedroom 2"
            roomIcon: "bedroom2"
        }
        ListElement {
            roomName: "Dining Room"
            roomIcon: "dining-room"
        }
        ListElement {
            roomName: "Bathroom"
            roomIcon: "bathroom"
        }
        ListElement {
            roomName: "Garage"
            roomIcon: "garage"
        }
    }
}
