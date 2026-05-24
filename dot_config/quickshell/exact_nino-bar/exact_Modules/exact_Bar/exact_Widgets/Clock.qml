import QtQuick
import qs.Commons

Item {
    id: root

    property string format: "HH:mm"
    property date now: new Date()

    implicitWidth: capsule.implicitWidth
    implicitHeight: Style.barHeight

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.now = new Date()
    }

    Capsule {
        id: capsule
        anchors.centerIn: parent

        Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(root.now, root.format)
            color: Style.text
            font.pixelSize: Style.fontSizeL
            font.weight: Font.Medium
        }
    }
}
