local M = {}

M.load_mappings = function(section, mapping_opt)
  local moveline = require('moveline')
  vim.keymap.set('n', '<M-k>', moveline.up)
  vim.keymap.set('n', '<M-j>', moveline.down)
  vim.keymap.set('v', '<M-k>', moveline.block_up)
  vim.keymap.set('v', '<M-j>', moveline.block_down)
end

return M
