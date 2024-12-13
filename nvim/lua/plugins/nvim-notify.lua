return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#0E0E0E",
			stages = "fade",
		})
	end,
}
