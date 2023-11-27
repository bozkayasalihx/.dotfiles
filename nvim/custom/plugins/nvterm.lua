return {
  "rsship/nvterm",
  init = function()
    -- require("core.utils").load_mappings "nvterm"
  end,
  config = function()
    -- require "base46.term"
    require("nvterm").setup {
      terminals = {
        shell = vim.o.shell,
        type = "float",
        list = {},
        type_opts = {
          float = {
            relative = "editor",
            row = 0.25,
            col = 0.5,
            width = 0.8,
            height = 0.6,
            border = "single",
          },
          horizontal = { location = "rightbelow", split_ratio = 0.3 },
          vertical = { location = "rightbelow", split_ratio = 0.5 },
        },
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    }
  end,
}
