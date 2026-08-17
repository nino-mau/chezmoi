/**
 * opencode Notify Plugin
 *
 * Sends a native terminal notification when opencode is done and waiting for input.
 * Equivalent of the pi coding agent's notify.ts extension.
 *
 * Supports multiple terminal protocols:
 * - OSC 777: Ghostty, iTerm2, WezTerm, rxvt-unicode
 * - OSC 99: Kitty
 * - Windows toast: Windows Terminal (WSL)
 * - tmux passthrough when running inside tmux
 */

import { execFile } from "node:child_process";
import type { Plugin } from "@opencode-ai/plugin";

function windowsToastScript(title: string, body: string): string {
	const type = "Windows.UI.Notifications";
	const mgr = `[${type}.ToastNotificationManager, ${type}, ContentType = WindowsRuntime]`;
	const template = `[${type}.ToastTemplateType]::ToastText01`;
	const toast = `[${type}.ToastNotification]::new($xml)`;
	return [
		`${mgr} > $null`,
		`$xml = [${type}.ToastNotificationManager]::GetTemplateContent(${template})`,
		`$xml.GetElementsByTagName('text')[0].AppendChild($xml.CreateTextNode('${body}')) > $null`,
		`[${type}.ToastNotificationManager]::CreateToastNotifier('${title}').Show(${toast})`,
	].join("; ");
}

function writeTerminalSequence(sequence: string): void {
	if (process.env.TMUX) {
		// tmux only forwards arbitrary terminal escape sequences through a DCS passthrough.
		// Escape characters inside the payload must be doubled for tmux to pass them through.
		process.stdout.write(`\x1bPtmux;${sequence.replaceAll("\x1b", "\x1b\x1b")}\x1b\\`);
		return;
	}

	process.stdout.write(sequence);
}

function notifyOSC777(title: string, body: string): void {
	writeTerminalSequence(`\x1b]777;notify;${title};${body}\x07`);
}

function notifyOSC99(title: string, body: string): void {
	// Kitty OSC 99: i=notification id, d=0 means not done yet, p=body for second part
	writeTerminalSequence(`\x1b]99;i=1:d=0;${title}\x1b\\`);
	writeTerminalSequence(`\x1b]99;i=1:p=body;${body}\x1b\\`);
}

function notifyWindows(title: string, body: string): void {
	execFile("powershell.exe", ["-NoProfile", "-Command", windowsToastScript(title, body)]);
}

function notify(title: string, body: string): void {
	if (process.env.WT_SESSION) {
		notifyWindows(title, body);
	} else if (process.env.KITTY_WINDOW_ID) {
		notifyOSC99(title, body);
	} else {
		notifyOSC777(title, body);
	}
}

function notifyAndBell(body: string): void {
	notify("opencode", body);

	if (process.env.TMUX) {
		process.stdout.write("\x07");
	}
}

export const NotifyPlugin: Plugin = async ({ client }) => {
	// Only fire terminal escape sequences when actually attached to a terminal
	// (mirrors pi's `ctx.hasUI` check, which skips headless/API sessions).
	if (!process.stdout.isTTY) return {};

	// Cache each session's parentID so sub-agent/child sessions (e.g. spawned
	// by the Task tool) don't trigger their own notifications.
	const parentSession = new Map<string, string | undefined>();

	async function isTopLevelSession(sessionID: string): Promise<boolean> {
		if (!parentSession.has(sessionID)) {
			try {
				const res = await client.session.get({ path: { id: sessionID } });
				parentSession.set(sessionID, res.data?.parentID);
			} catch {
				parentSession.set(sessionID, undefined);
			}
		}
		return !parentSession.get(sessionID);
	}

	return {
		event: async ({ event }) => {
			if (event.type === "session.idle") {
				if (await isTopLevelSession(event.properties.sessionID)) {
					notifyAndBell("Ready for input");
				}
				return;
			}

			if (event.type === "permission.updated") {
				if (await isTopLevelSession(event.properties.sessionID)) {
					notifyAndBell("Permission needed");
				}
			}
		},
	};
};

export default NotifyPlugin;
