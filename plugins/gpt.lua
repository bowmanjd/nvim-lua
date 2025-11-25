return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatAgents",
			"CopilotChatModels",
			"CopilotChatExplain",
			"CopilotChatToggle",
		},
		keys = {
			{
				"<leader>co",
				"<Cmd>CopilotChatToggle<cr>",
				mode = { "n", "v" },
				desc = "LLM Chat using Github Copilot",
			},
		},
		-- build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "gpt-5-mini",
		},
	},

	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionActions",
			"CodeCompanionCmd",
		},
		keys = {
			{
				"<leader>cc",
				"<Cmd>CodeCompanionChat<cr>",
				mode = { "n", "v" },
				desc = "LLM Chat using CodeCompanion",
			},
		},
		opts = {
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
				},
				inline = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
				},
			},
		},
	},
}
