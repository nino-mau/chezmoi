# nino-bar

Small Quickshell bar skeleton meant to be edited directly.

Run it:

```bash
qs -c nino-bar
```

The important files are:

- [Modules/Bar/Bar.qml](/home/nino/.config/quickshell/nino-bar/Modules/Bar/Bar.qml): compose the bar sections and add/remove widgets.
- [Modules/Bar/Widgets](/home/nino/.config/quickshell/nino-bar/Modules/Bar/Widgets): standalone widgets you can copy and extend.
- [Commons/Style.qml](/home/nino/.config/quickshell/nino-bar/Commons/Style.qml): shared sizing, colors, and animation values.
- [Commons/BarConfig.qml](/home/nino/.config/quickshell/nino-bar/Commons/BarConfig.qml): shell-level behavior like top/bottom and exclusivity.

This config no longer uses a widget registry or JSON settings layer. The bar is plain QML on purpose so it is easier to learn and grow.

To add a widget:

```qml
Widgets.MyWidget {
    screen: root.screen
    Layout.alignment: Qt.AlignVCenter
}
```

Suggested workflow:

1. Copy one of the existing widgets in `Modules/Bar/Widgets`.
2. Change its properties and visuals.
3. Place it directly in `Bar.qml` where you want it.
