return {
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
			{ "<c-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
			{ "<c-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
			{ "<c-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
			{ "<c-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
		},
	},
}
