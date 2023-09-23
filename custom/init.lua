vim.opt.guicursor = ""
vim.opt.relativenumber =true
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

vim.keymap.set('n', '<S-e>', vim.diagnostic.open_float)

vim.cmd [[autocmd BufWritePre <buffer> lua vim.diagnostic.hide()]]


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   underline = true,
   virtual_text = false,
 }
)


