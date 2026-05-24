import QtQuick
import Quickshell.Io
import qs.Commons

Item {
    id: root

    property string label: "run"
    property string command: ""

    implicitWidth: capsule.implicitWidth
    implicitHeight: Style.barHeight

    Process {
        id: process
    }

    function runCommand() {
        if (command.trim() === "")
            return;

        process.command = ["sh", "-lc", command];
        process.running = true;
    }

    Capsule {
        id: capsule
        anchors.centerIn: parent
        hovered: mouseArea.containsMouse

        Text {
            anchors.centerIn: parent
            text: root.label
            color: Style.text
            font.pixelSize: Style.fontSizeM
            font.weight: Font.Medium
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.runCommand()
    }
}
