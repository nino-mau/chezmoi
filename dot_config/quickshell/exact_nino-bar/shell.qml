import QtQuick
import Quickshell
import qs.Modules.Bar

ShellRoot {
    BarScreens {}

    Connections {
        target: Quickshell
        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
        }
    }
}
