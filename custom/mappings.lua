---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<c-]>"] = { "<cmd> vsplit <CR>", "Split Window Verticaly" },
    ["<c-[>"] = { "<cmd> split <CR>", "Split Window Horizontally" },
  },
  i = {
    ["zz"] = { "<Esc>", "Replace <Esc> to zz" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

M.telescope = {
  plugin = false,
}

M.nvterm = {
  -- toggle in terminal mode
  t = {
    ["<C-\\>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },

  n = {
    ["<C-\\>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
  -- terminals = {
  --     shell = vim.o.shell,
  --     list = {},
  --     type_opts = {
  --       float = {
  --         relative = 'editor',
  --         row = 0.25,
  --         col = 0.5,
  --         width = 0.8,
  --         height = 0.6,
  --         border = "single",
  --       },
  --       horizontal = { location = "rightbelow", split_ratio = .3, },
  --       vertical = { location = "rightbelow", split_ratio = .5 },
  --     }
  --   },
  --   behavior = {
  --     autoclose_on_quit = {
  --       enabled = false,
  --       confirm = true,
  --     },
  --     close_on_exit = true,
  --     auto_insert = true,
  --   },
}
-- more keybinds!

return M
