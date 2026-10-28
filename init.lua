require("config")
require("keymappings")
require("autopairs")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
  },
})

vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.cpp",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})


