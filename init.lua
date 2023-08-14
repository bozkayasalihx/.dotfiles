require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end
vim.opt.guicursor = ""

vim.keymap.set("n", "<C-p>","<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<CR>", { silent = true })

vim.keymap.set("n", "<C-g>","<cmd>lua require('fzf-lua').live_grep({ cmd = \"git grep --line-number --column --color=always\" })<CR>", { silent = true})



vim.g.nvchad_theme = {
     theme = {
       ['jellybeans'] = {
         override = {
         }
    }
  }
}
dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function ()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end 
  end,
})
