import themes from './themes.json' with { type: 'json' };
import { writeFileSync } from 'fs';

type Palette = {
  bg0: string;
  bg1: string;
  bg2: string;
  bg3: string;
  bg4: string;
  fg: string;
  fg2: string;
  red: string;
  orange: string;
  yellow: string;
  green: string;
  aqua: string;
  blue: string;
  purple: string;
  pink: string;
  lavender: string;
  grey0: string;
  grey1: string;
  grey2: string;
  primary: string;
};

const stripHash = (hex: string) => hex.replace('#', '');

function generateHyprConf(name: string, palette: Palette): string {
  const p = palette;
  return `$bg0 = rgb(${stripHash(p.bg0)})
$bg1 = rgb(${stripHash(p.bg1)})
$bg2 = rgb(${stripHash(p.bg2)})
$bg3 = rgb(${stripHash(p.bg3)})
$bg4 = rgb(${stripHash(p.bg4)})

$fg = rgb(${stripHash(p.fg)})
$fg2 = rgb(${stripHash(p.fg2)})

$red = rgb(${stripHash(p.red)})
$orange = rgb(${stripHash(p.orange)})
$yellow = rgb(${stripHash(p.yellow)})
$green = rgb(${stripHash(p.green)})
$aqua = rgb(${stripHash(p.aqua)})
$blue = rgb(${stripHash(p.blue)})
$purple = rgb(${stripHash(p.purple)})
$pink = rgb(${stripHash(p.pink)})
$lavender = rgb(${stripHash(p.lavender)})

$grey0 = rgb(${stripHash(p.grey0)})
$grey1 = rgb(${stripHash(p.grey1)})
$grey2 = rgb(${stripHash(p.grey2)})

$primary = rgb(${stripHash(p.primary)})
`;
}

function generateHyprpanelTheme(palette: Palette): Record<string, string> {
  const p = palette;
  return {
    'theme.bar.menus.background': p.bg1,
    'theme.bar.background': p.bg1,
    'theme.bar.menus.text': p.fg,
    'theme.bar.menus.border.color': p.bg2,
    'theme.bar.buttons.background': p.bg0,
    'theme.bar.buttons.text': p.fg,
    'theme.bar.buttons.icon': p.grey2,
    'theme.bar.buttons.hover': p.bg3,
    'theme.bar.buttons.icon_background': p.bg0,
    'theme.bar.buttons.borderColor': p.primary,
    'theme.bar.buttons.media.background': p.bg0,
    'theme.bar.buttons.media.icon': p.fg,
    'theme.bar.buttons.media.text': p.fg,
    'theme.bar.buttons.media.hover': p.bg3,
    'theme.bar.buttons.media.border': p.primary,
    'theme.bar.menus.menu.media.background.color': p.bg1,
    'theme.bar.menus.menu.media.card.color': p.bg0,
    'theme.bar.menus.menu.media.border.color': p.bg2,
    'theme.bar.menus.menu.media.song': p.primary,
    'theme.bar.menus.menu.media.artist': p.grey2,
    'theme.bar.menus.menu.media.album': p.fg,
    'theme.bar.menus.menu.media.timestamp': p.grey2,
    'theme.bar.menus.menu.media.slider.primary': p.pink,
    'theme.bar.menus.menu.media.slider.background': p.bg0,
    'theme.bar.menus.menu.media.slider.backgroundhover': p.bg3,
    'theme.bar.menus.menu.media.slider.puck': p.grey0,
    'theme.bar.menus.menu.media.buttons.text': p.bg0,
    'theme.bar.menus.menu.media.buttons.background': p.primary,
    'theme.bar.menus.menu.media.buttons.enabled': p.aqua,
    'theme.bar.menus.menu.media.buttons.inactive': p.grey0,
    'theme.bar.menus.menu.volume.text': p.fg,
    'theme.bar.menus.menu.volume.card.color': p.bg0,
    'theme.bar.menus.menu.volume.label.color': p.primary,
    'theme.bar.menus.menu.volume.border.color': p.bg2,
    'theme.bar.menus.menu.volume.background.color': p.bg1,
    'theme.bar.menus.menu.volume.audio_slider.primary': p.primary,
    'theme.bar.menus.menu.volume.audio_slider.background': p.bg0,
    'theme.bar.menus.menu.volume.audio_slider.backgroundhover': p.bg3,
    'theme.bar.menus.menu.volume.audio_slider.puck': p.grey0,
    'theme.bar.menus.menu.volume.input_slider.primary': p.pink,
    'theme.bar.menus.menu.volume.input_slider.background': p.bg0,
    'theme.bar.menus.menu.volume.input_slider.backgroundhover': p.bg3,
    'theme.bar.menus.menu.volume.input_slider.puck': p.grey0,
    'theme.bar.menus.menu.volume.icons.active': p.primary,
    'theme.bar.menus.menu.volume.icons.passive': p.grey2,
    'theme.bar.menus.menu.volume.iconbutton.active': p.primary,
    'theme.bar.menus.menu.volume.iconbutton.passive': p.grey2,
    'theme.bar.menus.menu.volume.listitems.active': p.primary,
    'theme.bar.menus.menu.volume.listitems.passive': p.fg,
    'theme.bar.buttons.volume.background': p.bg0,
    'theme.bar.buttons.volume.icon': p.primary,
    'theme.bar.buttons.volume.text': p.primary,
    'theme.bar.buttons.volume.hover': p.bg3,
    'theme.bar.buttons.volume.border': p.primary,
    'theme.bar.menus.menu.notifications.background': p.bg1,
    'theme.bar.menus.menu.notifications.card': p.bg0,
    'theme.bar.menus.menu.notifications.border': p.bg2,
    'theme.bar.menus.menu.notifications.label': p.fg,
    'theme.bar.menus.menu.notifications.no_notifications_label': p.grey2,
    'theme.bar.menus.menu.notifications.clear': p.red,
    'theme.bar.menus.menu.notifications.switch.enabled': p.primary,
    'theme.bar.menus.menu.notifications.switch.disabled': p.bg0,
    'theme.bar.menus.menu.notifications.switch.puck': p.bg3,
    'theme.bar.menus.menu.notifications.switch_divider': p.bg2,
    'theme.bar.menus.menu.notifications.pager.button': p.primary,
    'theme.bar.menus.menu.notifications.pager.label': p.grey2,
    'theme.bar.menus.menu.notifications.pager.background': p.bg0,
    'theme.bar.menus.menu.notifications.scrollbar.color': p.primary,
    'theme.bar.buttons.notifications.background': p.bg0,
    'theme.bar.buttons.notifications.icon': p.fg2,
    'theme.bar.buttons.notifications.total': p.red,
    'theme.bar.buttons.notifications.hover': p.bg3,
    'theme.bar.buttons.notifications.border': p.primary,
    'theme.bar.menus.menu.battery.background.color': p.bg0,
    'theme.bar.menus.menu.battery.card.color': p.bg0,
    'theme.bar.menus.menu.battery.border.color': p.bg2,
    'theme.bar.menus.menu.battery.text': p.fg,
    'theme.bar.menus.menu.battery.label.color': p.yellow,
    'theme.bar.menus.menu.battery.icons.active': p.yellow,
    'theme.bar.menus.menu.battery.icons.passive': p.grey2,
    'theme.bar.menus.menu.battery.listitems.active': p.yellow,
    'theme.bar.menus.menu.battery.listitems.passive': p.fg,
    'theme.bar.menus.menu.battery.slider.primary': p.yellow,
    'theme.bar.menus.menu.battery.slider.background': p.bg0,
    'theme.bar.menus.menu.battery.slider.backgroundhover': p.bg3,
    'theme.bar.menus.menu.battery.slider.puck': p.grey0,
    'theme.bar.buttons.battery.background': p.bg0,
    'theme.bar.buttons.battery.icon': p.yellow,
    'theme.bar.buttons.battery.text': p.yellow,
    'theme.bar.buttons.battery.hover': p.bg3,
    'theme.bar.buttons.battery.border': p.yellow,
    'theme.bar.menus.menu.bluetooth.background.color': p.bg1,
    'theme.bar.menus.menu.bluetooth.card.color': p.bg0,
    'theme.bar.menus.menu.bluetooth.border.color': p.bg2,
    'theme.bar.menus.menu.bluetooth.text': p.fg,
    'theme.bar.menus.menu.bluetooth.label.color': p.aqua,
    'theme.bar.menus.menu.bluetooth.status': p.grey0,
    'theme.bar.menus.menu.bluetooth.icons.active': p.aqua,
    'theme.bar.menus.menu.bluetooth.icons.passive': p.grey2,
    'theme.bar.menus.menu.bluetooth.iconbutton.active': p.aqua,
    'theme.bar.menus.menu.bluetooth.iconbutton.passive': p.grey2,
    'theme.bar.menus.menu.bluetooth.listitems.active': p.aqua,
    'theme.bar.menus.menu.bluetooth.listitems.passive': p.fg,
    'theme.bar.menus.menu.bluetooth.switch.enabled': p.aqua,
    'theme.bar.menus.menu.bluetooth.switch.disabled': p.bg0,
    'theme.bar.menus.menu.bluetooth.switch.puck': p.bg3,
    'theme.bar.menus.menu.bluetooth.switch_divider': p.bg2,
    'theme.bar.menus.menu.bluetooth.scroller.color': p.aqua,
    'theme.bar.buttons.bluetooth.background': p.bg0,
    'theme.bar.buttons.bluetooth.icon': p.aqua,
    'theme.bar.buttons.bluetooth.text': p.aqua,
    'theme.bar.buttons.bluetooth.hover': p.bg3,
    'theme.bar.buttons.bluetooth.border': p.aqua,
    'theme.bar.menus.menu.network.background.color': p.bg1,
    'theme.bar.menus.menu.network.card.color': p.bg0,
    'theme.bar.menus.menu.network.border.color': p.bg2,
    'theme.bar.menus.menu.network.text': p.fg,
    'theme.bar.menus.menu.network.label.color': p.purple,
    'theme.bar.menus.menu.network.status.color': p.grey0,
    'theme.bar.menus.menu.network.icons.active': p.purple,
    'theme.bar.menus.menu.network.icons.passive': p.grey2,
    'theme.bar.menus.menu.network.iconbuttons.active': p.purple,
    'theme.bar.menus.menu.network.iconbuttons.passive': p.grey2,
    'theme.bar.menus.menu.network.listitems.active': p.purple,
    'theme.bar.menus.menu.network.listitems.passive': p.fg,
    'theme.bar.menus.menu.network.scroller.color': p.purple,
    'theme.bar.menus.menu.network.switch.enabled': p.purple,
    'theme.bar.menus.menu.network.switch.disabled': p.bg0,
    'theme.bar.menus.menu.network.switch.puck': p.bg3,
    'theme.bar.buttons.network.background': p.bg0,
    'theme.bar.buttons.network.icon': p.purple,
    'theme.bar.buttons.network.text': p.purple,
    'theme.bar.buttons.network.hover': p.bg3,
    'theme.bar.buttons.network.border': p.purple,
    'theme.bar.menus.menu.clock.background.color': p.bg1,
    'theme.bar.menus.menu.clock.card.color': p.bg0,
    'theme.bar.menus.menu.clock.border.color': p.bg2,
    'theme.bar.menus.menu.clock.text': p.fg,
    'theme.bar.menus.menu.clock.time.time': p.pink,
    'theme.bar.menus.menu.clock.time.timeperiod': p.aqua,
    'theme.bar.menus.menu.clock.calendar.yearmonth': p.aqua,
    'theme.bar.menus.menu.clock.calendar.weekdays': p.pink,
    'theme.bar.menus.menu.clock.calendar.days': p.fg,
    'theme.bar.menus.menu.clock.calendar.currentday': p.pink,
    'theme.bar.menus.menu.clock.calendar.contextdays': p.grey2,
    'theme.bar.menus.menu.clock.calendar.paginator': p.pink,
    'theme.bar.menus.menu.clock.weather.icon': p.pink,
    'theme.bar.menus.menu.clock.weather.temperature': p.fg,
    'theme.bar.menus.menu.clock.weather.status': p.aqua,
    'theme.bar.menus.menu.clock.weather.stats': p.pink,
    'theme.bar.menus.menu.clock.weather.hourly.time': p.pink,
    'theme.bar.menus.menu.clock.weather.hourly.icon': p.pink,
    'theme.bar.menus.menu.clock.weather.hourly.temperature': p.pink,
    'theme.bar.menus.menu.clock.weather.thermometer.extremelycold': p.blue,
    'theme.bar.menus.menu.clock.weather.thermometer.cold': p.blue,
    'theme.bar.menus.menu.clock.weather.thermometer.moderate': p.primary,
    'theme.bar.menus.menu.clock.weather.thermometer.hot': p.orange,
    'theme.bar.menus.menu.clock.weather.thermometer.extremelyhot': p.red,
    'theme.bar.buttons.clock.background': p.bg0,
    'theme.bar.buttons.clock.icon': p.primary,
    'theme.bar.buttons.clock.text': p.primary,
    'theme.bar.buttons.clock.hover': p.bg3,
    'theme.bar.buttons.clock.border': p.pink,
    'theme.bar.menus.menu.dashboard.background.color': p.bg1,
    'theme.bar.menus.menu.dashboard.card.color': p.bg0,
    'theme.bar.menus.menu.dashboard.border.color': p.bg2,
    'theme.bar.menus.menu.dashboard.profile.name': p.pink,
    'theme.bar.menus.menu.dashboard.powermenu.shutdown': p.red,
    'theme.bar.menus.menu.dashboard.powermenu.restart': p.orange,
    'theme.bar.menus.menu.dashboard.powermenu.logout': p.green,
    'theme.bar.menus.menu.dashboard.powermenu.sleep': p.aqua,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.background': p.bg1,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.card': p.bg0,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.border': p.bg2,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.label': p.pink,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.body': p.fg,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm': p.green,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.deny': p.red,
    'theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.wifi.background': p.purple,
    'theme.bar.menus.menu.dashboard.controls.wifi.text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.bluetooth.background': p.aqua,
    'theme.bar.menus.menu.dashboard.controls.bluetooth.text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.notifications.background': p.yellow,
    'theme.bar.menus.menu.dashboard.controls.notifications.text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.volume.background': p.pink,
    'theme.bar.menus.menu.dashboard.controls.volume.text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.input.background': p.pink,
    'theme.bar.menus.menu.dashboard.controls.input.text': p.bg0,
    'theme.bar.menus.menu.dashboard.controls.disabled': p.bg3,
    'theme.bar.menus.menu.dashboard.shortcuts.background': p.primary,
    'theme.bar.menus.menu.dashboard.shortcuts.text': p.bg0,
    'theme.bar.menus.menu.dashboard.shortcuts.recording': p.red,
    'theme.bar.menus.menu.dashboard.directories.left.top.color': p.pink,
    'theme.bar.menus.menu.dashboard.directories.left.middle.color': p.yellow,
    'theme.bar.menus.menu.dashboard.directories.left.bottom.color': p.red,
    'theme.bar.menus.menu.dashboard.directories.right.top.color': p.aqua,
    'theme.bar.menus.menu.dashboard.directories.right.middle.color': p.purple,
    'theme.bar.menus.menu.dashboard.directories.right.bottom.color': p.primary,
    'theme.bar.menus.menu.dashboard.monitors.bar_background': p.bg3,
    'theme.bar.menus.menu.dashboard.monitors.cpu.icon': p.red,
    'theme.bar.menus.menu.dashboard.monitors.cpu.bar': p.red,
    'theme.bar.menus.menu.dashboard.monitors.cpu.label': p.red,
    'theme.bar.menus.menu.dashboard.monitors.ram.icon': p.yellow,
    'theme.bar.menus.menu.dashboard.monitors.ram.bar': p.yellow,
    'theme.bar.menus.menu.dashboard.monitors.ram.label': p.yellow,
    'theme.bar.menus.menu.dashboard.monitors.gpu.icon': p.green,
    'theme.bar.menus.menu.dashboard.monitors.gpu.bar': p.green,
    'theme.bar.menus.menu.dashboard.monitors.gpu.label': p.green,
    'theme.bar.menus.menu.dashboard.monitors.disk.icon': p.purple,
    'theme.bar.menus.menu.dashboard.monitors.disk.bar': p.purple,
    'theme.bar.menus.menu.dashboard.monitors.disk.label': p.purple,
    'theme.bar.buttons.dashboard.background': p.bg0,
    'theme.bar.buttons.dashboard.icon': p.fg2,
    'theme.bar.buttons.dashboard.hover': p.bg3,
    'theme.bar.buttons.dashboard.border': p.primary,
    'theme.bar.buttons.workspaces.background': p.bg0,
    'theme.bar.buttons.workspaces.active': p.primary,
    'theme.bar.buttons.workspaces.occupied': p.bg2,
    'theme.bar.buttons.workspaces.available': p.bg2,
    'theme.bar.buttons.workspaces.hover': p.primary,
    'theme.bar.buttons.workspaces.border': p.pink,
    'theme.bar.buttons.workspaces.numbered_active_underline_color': p.pink,
    'theme.bar.buttons.workspaces.numbered_active_highlighted_text_color': p.bg0,
    'theme.bar.buttons.windowtitle.background': p.bg0,
    'theme.bar.buttons.windowtitle.icon': p.yellow,
    'theme.bar.buttons.windowtitle.text': p.yellow,
    'theme.bar.buttons.windowtitle.hover': p.bg3,
    'theme.bar.buttons.windowtitle.border': p.pink,
    'theme.bar.buttons.systray.background': p.bg0,
    'theme.bar.buttons.systray.hover': p.bg3,
    'theme.bar.buttons.systray.border': p.primary,
    'theme.bar.buttons.systray.customIcon': p.fg2,
    'theme.bar.menus.menu.systray.dropdownmenu.background': p.bg1,
    'theme.bar.menus.menu.systray.dropdownmenu.text': p.fg,
    'theme.bar.menus.menu.systray.dropdownmenu.divider': p.bg2,
    'theme.bar.menus.menu.power.background.color': p.bg1,
    'theme.bar.menus.menu.power.border.color': p.bg2,
    'theme.bar.menus.menu.power.buttons.shutdown.background': p.bg0,
    'theme.bar.menus.menu.power.buttons.shutdown.text': p.red,
    'theme.bar.menus.menu.power.buttons.shutdown.icon_background': p.red,
    'theme.bar.menus.menu.power.buttons.shutdown.icon': p.bg0,
    'theme.bar.menus.menu.power.buttons.restart.background': p.bg0,
    'theme.bar.menus.menu.power.buttons.restart.text': p.orange,
    'theme.bar.menus.menu.power.buttons.restart.icon_background': p.orange,
    'theme.bar.menus.menu.power.buttons.restart.icon': p.bg0,
    'theme.bar.menus.menu.power.buttons.logout.background': p.bg0,
    'theme.bar.menus.menu.power.buttons.logout.text': p.green,
    'theme.bar.menus.menu.power.buttons.logout.icon_background': p.green,
    'theme.bar.menus.menu.power.buttons.logout.icon': p.bg0,
    'theme.bar.menus.menu.power.buttons.sleep.background': p.bg0,
    'theme.bar.menus.menu.power.buttons.sleep.text': p.aqua,
    'theme.bar.menus.menu.power.buttons.sleep.icon_background': p.aqua,
    'theme.bar.menus.menu.power.buttons.sleep.icon': p.bg0,
    'theme.osd.bar_container': p.bg1,
    'theme.osd.icon_container': p.primary,
    'theme.osd.icon': p.bg0,
    'theme.osd.label': p.primary,
    'theme.osd.bar_color': p.primary,
    'theme.osd.bar_empty_color': p.bg2,
    'theme.osd.bar_overflow_color': p.red,
    'theme.notification.background': p.bg0,
    'theme.notification.border': p.bg2,
    'theme.notification.label': p.primary,
    'theme.notification.text': p.fg,
    'theme.notification.time': p.grey2,
    'theme.notification.actions.background': p.primary,
    'theme.notification.actions.text': p.bg0,
    'theme.notification.close_button.background': p.red,
    'theme.notification.close_button.label': p.bg0,
    'theme.notification.labelicon': p.primary,
    'theme.bar.menus.tooltip.background': p.bg1,
    'theme.bar.menus.tooltip.text': p.fg,
    'theme.bar.menus.popover.background': p.bg1,
    'theme.bar.menus.popover.text': p.fg,
    'theme.bar.menus.popover.border': p.bg0,
    'theme.bar.menus.dropdownmenu.background': p.bg1,
    'theme.bar.menus.dropdownmenu.text': p.fg,
    'theme.bar.menus.dropdownmenu.divider': p.bg2,
    'theme.bar.menus.cards': p.bg0,
    'theme.bar.menus.label': p.primary,
    'theme.bar.menus.feinttext': p.grey2,
    'theme.bar.menus.dimtext': p.grey2,
    'theme.bar.menus.listitems.active': p.primary,
    'theme.bar.menus.listitems.passive': p.fg,
    'theme.bar.menus.icons.active': p.primary,
    'theme.bar.menus.icons.passive': p.grey2,
    'theme.bar.menus.iconbuttons.active': p.primary,
    'theme.bar.menus.iconbuttons.passive': p.grey2,
    'theme.bar.menus.buttons.default': p.primary,
    'theme.bar.menus.buttons.active': p.pink,
    'theme.bar.menus.buttons.disabled': p.grey2,
    'theme.bar.menus.buttons.text': p.bg0,
    'theme.bar.menus.switch.enabled': p.primary,
    'theme.bar.menus.switch.disabled': p.bg0,
    'theme.bar.menus.switch.puck': p.bg3,
    'theme.bar.menus.slider.primary': p.primary,
    'theme.bar.menus.slider.background': p.bg0,
    'theme.bar.menus.slider.backgroundhover': p.bg3,
    'theme.bar.menus.slider.puck': p.grey0,
    'theme.bar.menus.progressbar.foreground': p.primary,
    'theme.bar.menus.progressbar.background': p.bg0,
    'theme.bar.menus.check_radio_button.active': p.primary,
    'theme.bar.menus.check_radio_button.background': p.bg1,
    'theme.bar.border.color': p.primary,
    'theme.bar.buttons.modules.cpu.icon': p.red,
    'theme.bar.buttons.modules.cpu.text': p.red,
    'theme.bar.buttons.modules.cpu.background': p.bg0,
    'theme.bar.buttons.modules.cpu.icon_background': p.bg0,
    'theme.bar.buttons.modules.cpu.border': p.red,
    'theme.bar.buttons.modules.ram.icon': p.yellow,
    'theme.bar.buttons.modules.ram.text': p.yellow,
    'theme.bar.buttons.modules.ram.background': p.bg0,
    'theme.bar.buttons.modules.ram.icon_background': p.bg0,
    'theme.bar.buttons.modules.ram.border': p.yellow,
    'theme.bar.buttons.modules.storage.icon': p.purple,
    'theme.bar.buttons.modules.storage.text': p.purple,
    'theme.bar.buttons.modules.storage.background': p.bg0,
    'theme.bar.buttons.modules.storage.icon_background': p.bg0,
    'theme.bar.buttons.modules.storage.border': p.purple,
    'theme.bar.buttons.modules.netstat.icon': p.green,
    'theme.bar.buttons.modules.netstat.text': p.green,
    'theme.bar.buttons.modules.netstat.background': p.bg0,
    'theme.bar.buttons.modules.netstat.icon_background': p.bg0,
    'theme.bar.buttons.modules.netstat.border': p.green,
    'theme.bar.buttons.modules.kbLayout.icon': p.aqua,
    'theme.bar.buttons.modules.kbLayout.text': p.aqua,
    'theme.bar.buttons.modules.kbLayout.background': p.bg0,
    'theme.bar.buttons.modules.kbLayout.icon_background': p.bg0,
    'theme.bar.buttons.modules.kbLayout.border': p.aqua,
    'theme.bar.buttons.modules.updates.icon': p.purple,
    'theme.bar.buttons.modules.updates.text': p.purple,
    'theme.bar.buttons.modules.updates.background': p.bg0,
    'theme.bar.buttons.modules.updates.icon_background': p.bg0,
    'theme.bar.buttons.modules.updates.border': p.purple,
    'theme.bar.buttons.modules.weather.icon': p.primary,
    'theme.bar.buttons.modules.weather.text': p.primary,
    'theme.bar.buttons.modules.weather.background': p.bg0,
    'theme.bar.buttons.modules.weather.icon_background': p.bg0,
    'theme.bar.buttons.modules.weather.border': p.primary,
    'theme.bar.buttons.modules.power.icon': p.red,
    'theme.bar.buttons.modules.power.background': p.bg0,
    'theme.bar.buttons.modules.power.icon_background': p.red,
    'theme.bar.buttons.modules.power.border': p.red,
    'theme.bar.buttons.modules.submap.icon': p.aqua,
    'theme.bar.buttons.modules.submap.text': p.aqua,
    'theme.bar.buttons.modules.submap.background': p.bg0,
    'theme.bar.buttons.modules.submap.icon_background': p.bg0,
    'theme.bar.buttons.modules.submap.border': p.aqua,
    'theme.bar.buttons.modules.hyprsunset.icon': p.orange,
    'theme.bar.buttons.modules.hyprsunset.text': p.orange,
    'theme.bar.buttons.modules.hyprsunset.background': p.bg0,
    'theme.bar.buttons.modules.hyprsunset.icon_background': p.bg0,
    'theme.bar.buttons.modules.hyprsunset.border': p.pink,
    'theme.bar.buttons.modules.hypridle.icon': p.pink,
    'theme.bar.buttons.modules.hypridle.text': p.pink,
    'theme.bar.buttons.modules.hypridle.background': p.bg0,
    'theme.bar.buttons.modules.hypridle.icon_background': p.pink,
    'theme.bar.buttons.modules.hypridle.border': p.pink,
    'theme.bar.buttons.modules.cava.icon': p.aqua,
    'theme.bar.buttons.modules.cava.text': p.aqua,
    'theme.bar.buttons.modules.cava.background': p.bg0,
    'theme.bar.buttons.modules.cava.icon_background': p.bg0,
    'theme.bar.buttons.modules.cava.border': p.aqua,
    'theme.bar.buttons.modules.worldclock.icon': p.pink,
    'theme.bar.buttons.modules.worldclock.text': p.pink,
    'theme.bar.buttons.modules.worldclock.background': p.bg0,
    'theme.bar.buttons.modules.worldclock.icon_background': p.pink,
    'theme.bar.buttons.modules.worldclock.border': p.pink,
    'theme.bar.buttons.modules.microphone.icon': p.green,
    'theme.bar.buttons.modules.microphone.text': p.green,
    'theme.bar.buttons.modules.microphone.background': p.bg0,
    'theme.bar.buttons.modules.microphone.icon_background': p.bg0,
    'theme.bar.buttons.modules.microphone.border': p.green,
  };
}

function generateMakoConf(palette: Palette): string {
  const p = palette;
  return `# Colors (Format: #RRGGBBAA)
background-color=${p.bg0}99
text-color=${p.fg}
border-color=${p.primary}
progress-color=over ${p.bg2}
`;
}

function main() {
  const themesDir = import.meta.dir;
  
  for (const [name, palette] of Object.entries(themes)) {
    const hyprConf = generateHyprConf(name, palette as Palette);
    writeFileSync(`${themesDir}/hypr/${name}.conf`, hyprConf);
    console.log(`Generated hypr/${name}.conf`);

    const hyprpanelTheme = generateHyprpanelTheme(palette as Palette);
    writeFileSync(`${themesDir}/hyprpanel/${name}.json`, JSON.stringify(hyprpanelTheme, null, 2));
    console.log(`Generated hyprpanel/${name}.json`);

    const makoConf = generateMakoConf(palette as Palette);
    writeFileSync(`${themesDir}/mako/${name}.conf`, makoConf);
    console.log(`Generated mako/${name}.conf`);
  }
  
  console.log('\nAll themes generated successfully!');
}

main();
