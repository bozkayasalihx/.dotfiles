-- Utilities for creating configurations
local util = require "formatter.util"

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {

    go = {
      function()
        return {
          exe = "/Users/salihbozkaya/go/bin/gofumpt",
          args = {
            "-l",
            "-w",
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = false,
        }
      end
    }
  }
}
