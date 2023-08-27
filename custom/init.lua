-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

vim.opt.guicursor = ""

vim.keymap.set(
  "n",
  "<C-p>",
  "<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<CR>",
  { silent = true }
)

vim.keymap.set(
  "n",
  "<C-g>",
  "<cmd>lua require('fzf-lua').live_grep({ cmd = \"git grep --line-number --column --color=always\" })<CR>",
  { silent = true }
)

vim.wo.wrap = false
vim.opt.swapfile = false
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

