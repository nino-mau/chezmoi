import type { Plugin } from "@opencode-ai/plugin";
import type { Event } from "@opencode-ai/sdk/v2";

export const NotifyPlugin: Plugin = async (plugin) => {
	return {
		// Event type from @opencode-ai/plugin@1.18.23 is out of date
		// TODO: use event directly when @opencode-ai/plugin is fixed
		event: async ({ event: legacyEvent }) => {
			const event = legacyEvent as Event;
			if (event.type === "session.idle") {
				await plugin.$`fish -c 'notify \"Opencode\" \"Ready for input\"'`;

				if (process.env.TMUX) {
					process.stdout.write("\x07");
				}
			}
			if (event.type === "question.asked") {
				await plugin.$`fish -c 'notify \"Opencode\" \"Question requires input\"'`;

				if (process.env.TMUX) {
					process.stdout.write("\x07");
				}
			}
			if (event.type === "permission.asked") {
				await plugin.$`fish -c 'notify \"Opencode\" \"Permission needed\"'`;

				if (process.env.TMUX) {
					process.stdout.write("\x07");
				}
			}
		},
	};
};
