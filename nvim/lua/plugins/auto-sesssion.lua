return {
	"rmagatti/auto-session",
	lazy = false,

	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		auto_restore_last_session = false,

		session_lens = {
			load_on_setup = true, -- Initialize on startup (requires Telescope)
			theme_conf = { -- Pass through for Telescope theme options
				-- layout_config = { -- As one example, can change width/height of picker
				--   width = 0.8,    -- percent of window
				--   height = 0.5,
				-- },
			},
			previewer = false, -- File preview for session picker

			session_control = {
				control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
				control_filename = "session_control.json", -- File name of the session control file
			},
		},
	},
}
