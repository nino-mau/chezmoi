import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons

Item {
    id: root

    required property ShellScreen screen
    property int count: 10

    readonly property int activeWorkspaceId: {
        var monitor = Hyprland.monitorFor(screen);
        if (monitor && monitor.activeWorkspace)
            return monitor.activeWorkspace.id;
        return Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : -1;
    }

    implicitWidth: capsule.implicitWidth
    implicitHeight: Style.barHeight

    function workspaceExists(workspaceId) {
        var list = Hyprland.workspaces.values;
        for (var i = 0; i < list.length; i++) {
            if (list[i].id === workspaceId)
                return true;
        }
        return false;
    }

    Capsule {
        id: capsule
        anchors.centerIn: parent
        horizontalPadding: Style.marginS

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: Style.marginXS

            Repeater {
                model: root.count

                delegate: MouseArea {
                    id: workspaceButton

                    required property int index

                    readonly property int workspaceId: index + 1
                    readonly property bool active: root.activeWorkspaceId === workspaceId
                    readonly property bool occupied: root.workspaceExists(workspaceId)
                    property real pillWidth: active ? 42 : 20
                    property real pulse: 0

                    implicitWidth: pillWidth
                    implicitHeight: 20
                    Layout.preferredWidth: pillWidth
                    Layout.preferredHeight: 20
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Hyprland.dispatch("workspace " + workspaceId)
                    onActiveChanged: {
                        if (active)
                            activationPulse.restart();
                    }

                    Behavior on pillWidth {
                        NumberAnimation {
                            duration: Style.animationNormal
                            easing.type: Easing.OutBack
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: Style.radiusM
                        color: workspaceButton.active ? Style.accent : (workspaceButton.containsMouse ? Style.capsuleHover : "transparent")

                        Behavior on color {
                            ColorAnimation {
                                duration: Style.animationFast
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width + workspaceButton.pulse * 18
                            height: parent.height + workspaceButton.pulse * 18
                            radius: width / 2
                            color: "transparent"
                            border.color: Style.accent
                            border.width: Math.max(1, Math.round(3 * (1 - workspaceButton.pulse)))
                            opacity: (1 - workspaceButton.pulse) * 0.55
                            visible: workspaceButton.pulse > 0
                        }

                        Text {
                            anchors.centerIn: parent
                            text: workspaceButton.workspaceId
                            color: workspaceButton.active ? Style.activeText : (workspaceButton.occupied ? Style.text : Style.mutedText)
                            font.pixelSize: Style.fontSizeS
                            font.weight: workspaceButton.active || workspaceButton.occupied ? Font.Bold : Font.Medium

                            Behavior on color {
                                ColorAnimation {
                                    duration: Style.animationFast
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }

                    SequentialAnimation {
                        id: activationPulse
                        running: false

                        NumberAnimation {
                            target: workspaceButton
                            property: "pulse"
                            from: 0.0
                            to: 1.0
                            duration: Style.animationNormal
                            easing.type: Easing.OutCubic
                        }

                        PropertyAction {
                            target: workspaceButton
                            property: "pulse"
                            value: 0.0
                        }
                    }
                }
            }
        }
    }
}
