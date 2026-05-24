import QtQuick
import Quickshell
import qs.Modules.Bar

Variants {
    model: Quickshell.screens

    delegate: Scope {
        required property ShellScreen modelData

        BarWindow {
            screen: modelData
        }
    }
}
