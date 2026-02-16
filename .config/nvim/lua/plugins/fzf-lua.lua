return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")

			fzf.setup({
				files = {
					fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude build",
				},
				grep = {
					rg_opts = '--column --line-number --no-heading --color=always --smart-case --glob "!.git/" --glob "!node_modules/" --glob "!dist/" --glob "!build/"',
				},
			})

			vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
			vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "Find git files" })
			vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
		end,
	},
}
