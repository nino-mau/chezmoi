import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Modules.Bar.Widgets as Widgets

Rectangle {
    id: root

    required property ShellScreen screen

    color: Style.barBackground

    RowLayout {
        id: leftSection
        anchors.left: parent.left
        anchors.leftMargin: Style.marginM
        anchors.verticalCenter: parent.verticalCenter
        spacing: Style.marginS

        // Add left-aligned widgets here.
    }

    RowLayout {
        id: centerSection
        anchors.centerIn: parent
        spacing: Style.marginS

        Widgets.Workspaces {
            screen: root.screen
            count: 10
            Layout.alignment: Qt.AlignVCenter
        }

        Widgets.Clock {
            format: "HH:mm"
            Layout.alignment: Qt.AlignVCenter
        }
    }

    RowLayout {
        id: rightSection
        anchors.right: parent.right
        anchors.rightMargin: Style.marginM
        anchors.verticalCenter: parent.verticalCenter
        spacing: Style.marginS

        Widgets.Text {
            text: "nino-bar"
            Layout.alignment: Qt.AlignVCenter
        }

        Widgets.Command {
            label: "term"
            command: "ghostty"
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
