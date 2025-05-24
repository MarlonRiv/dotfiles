return {
	{
		"tadachs/ros-nvim",
		config = function()
			require("ros-nvim").setup({
				only_workspace = true,
				treesitter = { enabled = true },
				commands = { enabled = true },
				autocmds = { enabled = true },
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
