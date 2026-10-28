vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<leader>e', ':Explore <CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = false })
end)
