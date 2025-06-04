return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		-- Format visual selection
		vim.keymap.set("v", "=", function()
			vim.lsp.buf.format({
				range = {
					["start"] = vim.api.nvim_buf_get_mark(0, "<"),
					["end"] = vim.api.nvim_buf_get_mark(0, ">"),
				},
			})
		end, {})
	end,
}
