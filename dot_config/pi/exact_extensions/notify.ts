import { spawn } from "node:child_process";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

function notify(body: string): void {
	const child = spawn(
		"fish",
		["-c", 'notify "$argv[1]" "$argv[2]"', "Pi", body],
		{
			stdio: ["ignore", "inherit", "ignore"],
		},
	);

	// Avoid an unhandled error if Fish cannot be started.
	child.on("error", () => {});
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_execution_start", (event, ctx) => {
		if (ctx.mode !== "tui" || event.toolName !== "ask_user_question") return;

		notify("Question requires input");
	});

	pi.on("agent_settled", (_event, ctx) => {
		if (ctx.mode !== "tui" || !ctx.isIdle()) return;

		notify("Ready for input");
	});
}
