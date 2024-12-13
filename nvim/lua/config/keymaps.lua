-- bufferline
vim.keymap.set("n", "<Tab>", "<CMD>BufferNext<NL>") -- cycle next Tab
vim.keymap.set("n", "<leader>x", "<CMD>BufferClose<NL>") -- close current Tab
-- vim.keymap.set("n", "<C><Tab>", "<CMD>:bprev<NL>")

vim.keymap.set("n", "<leader>ff", "<CMD>lua Snacks.dashboard.pick('files')<NL>")
-- vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files find_command=rg,--ignore,--hidden,--files<NL>")
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<NL>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<NL>")
vim.keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<NL>")
vim.keymap.set("n", "<leader>fss", "<CMD>:SessionSearch<NL>")
