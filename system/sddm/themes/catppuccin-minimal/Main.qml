import QtQuick
import QtQuick.Layouts
import SddmComponents

Rectangle {
    id: root

    width: 1920
    height: 1080
    color: "#1e1e2e"

    property string mochaBase: "#1e1e2e"
    property string mochaSurface: "#313244"
    property string mochaOverlay: "#45475a"
    property string mochaText: "#cdd6f4"
    property string mochaSubtext: "#a6adc8"
    property string mochaMauve: "#cba6f7"

    // Default to lastUser, first user in model, or empty
    property string defaultUser: (typeof userModel !== "undefined" && userModel.lastUser && userModel.lastUser.length > 0)
        ? userModel.lastUser
        : "realsk"

    property string errorMessage: ""

    // Background
    Rectangle {
        anchors.fill: parent
        color: root.mochaBase
    }

    // Decorative accent
    Rectangle {
        width: 4
        height: 100
        radius: 2
        color: root.mochaMauve
        anchors.left: parent.left
        anchors.leftMargin: 48
        anchors.verticalCenter: parent.verticalCenter
    }

    // Login panel
    Item {
        id: loginPanel

        width: 360
        height: 520
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent
            spacing: 14

            Item {
                Layout.fillHeight: true
            }

            Text {
                text: "FEDORA / HYPRLAND"
                color: root.mochaMauve
                font.family: "JetBrains Mono"
                font.pixelSize: 12
                font.letterSpacing: 2
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Welcome back."
                color: root.mochaText
                font.family: "JetBrains Mono"
                font.pixelSize: 26
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Sign in to continue"
                color: root.mochaSubtext
                font.family: "JetBrains Mono"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignHCenter
            }

            Item {
                height: 4
            }

            // Session selector
            ComboBox {
                id: sessionBox

                Layout.fillWidth: true
                Layout.preferredHeight: 42

                model: sessionModel
                index: sessionModel.lastIndex

                arrowIcon: ""
                font.family: "JetBrains Mono"
                font.pixelSize: 12

                color: root.mochaSurface
                textColor: root.mochaText
                menuColor: root.mochaSurface
                borderColor: root.mochaOverlay
                focusColor: root.mochaMauve
                hoverColor: root.mochaOverlay

                activeFocusOnTab: true
                KeyNavigation.tab: userBox
                KeyNavigation.down: userBox
            }

            // Username entry
            TextBox {
                id: userBox

                Layout.fillWidth: true
                Layout.preferredHeight: 44

                text: root.defaultUser
                font.family: "JetBrains Mono"
                font.pixelSize: 13

                color: root.mochaSurface
                textColor: root.mochaText
                borderColor: root.mochaOverlay
                focusColor: root.mochaMauve

                activeFocusOnTab: true
                KeyNavigation.backtab: sessionBox
                KeyNavigation.up: sessionBox
                KeyNavigation.tab: passwordBox
                KeyNavigation.down: passwordBox

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    verticalAlignment: Text.AlignVCenter
                    text: "Username"
                    color: root.mochaSubtext
                    font.family: userBox.font.family
                    font.pixelSize: userBox.font.pixelSize
                    visible: userBox.text.length === 0
                }

                Keys.onReturnPressed: passwordBox.forceActiveFocus()
                Keys.onEnterPressed: passwordBox.forceActiveFocus()
                Keys.onEscapePressed: {
                    userBox.text = ""
                    root.errorMessage = ""
                }
            }

            // Password entry
            TextBox {
                id: passwordBox

                Layout.fillWidth: true
                Layout.preferredHeight: 44

                text: ""
                font.family: "JetBrains Mono"
                font.pixelSize: 13

                color: root.mochaSurface
                textColor: root.mochaText
                borderColor: root.mochaOverlay
                focusColor: root.mochaMauve

                echoMode: TextInput.Password

                activeFocusOnTab: true
                KeyNavigation.backtab: userBox
                KeyNavigation.up: userBox
                KeyNavigation.tab: loginButton
                KeyNavigation.down: loginButton

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    verticalAlignment: Text.AlignVCenter
                    text: "Password"
                    color: root.mochaSubtext
                    font.family: passwordBox.font.family
                    font.pixelSize: passwordBox.font.pixelSize
                    visible: passwordBox.text.length === 0
                }

                Keys.onReturnPressed: triggerLogin()
                Keys.onEnterPressed: triggerLogin()
                Keys.onEscapePressed: {
                    passwordBox.text = ""
                    root.errorMessage = ""
                }
            }

            // Login button
            Rectangle {
                id: loginButton

                Layout.fillWidth: true
                Layout.preferredHeight: 44

                radius: 8
                color: (loginMouseArea.containsMouse || loginButton.activeFocus)
                    ? "#b4befe"
                    : root.mochaMauve

                activeFocusOnTab: true
                KeyNavigation.backtab: passwordBox
                KeyNavigation.up: passwordBox

                Text {
                    anchors.centerIn: parent
                    text: "LOGIN"
                    color: root.mochaBase
                    font.family: "JetBrains Mono"
                    font.pixelSize: 12
                    font.bold: true
                    font.letterSpacing: 1
                }

                Keys.onReturnPressed: triggerLogin()
                Keys.onEnterPressed: triggerLogin()

                MouseArea {
                    id: loginMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: triggerLogin()
                }
            }

            Text {
                Layout.fillWidth: true
                visible: root.errorMessage.length > 0
                text: root.errorMessage
                color: "#f38ba8"
                font.family: "JetBrains Mono"
                font.pixelSize: 11
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Text {
                Layout.fillWidth: true
                text: "TAB Switch field  •  ESC Clear"
                color: root.mochaSubtext
                font.family: "JetBrains Mono"
                font.pixelSize: 10
                horizontalAlignment: Text.AlignHCenter
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    function triggerLogin() {
        var username = userBox.text.trim()

        if (username.length === 0) {
            root.errorMessage = "Please enter your username"
            userBox.forceActiveFocus()
            return
        }

        if (passwordBox.text.length === 0) {
            root.errorMessage = "Please enter your password"
            passwordBox.forceActiveFocus()
            return
        }

        root.errorMessage = ""
        sddm.login(username, passwordBox.text, sessionBox.index)
    }

    // Keyboard shortcuts
    Keys.onEscapePressed: {
        passwordBox.text = ""
        root.errorMessage = ""
    }

    // Set initial focus intelligently
    Component.onCompleted: {
        if (userBox.text.length > 0) {
            passwordBox.forceActiveFocus()
        } else {
            userBox.forceActiveFocus()
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.errorMessage = "Login failed. Check your password."
            passwordBox.text = ""
            passwordBox.forceActiveFocus()
        }
    }
}