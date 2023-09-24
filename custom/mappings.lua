---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-]>"] = { "<cmd>vsplit<CR>", "Split Window Verticaly" },
    ["<C-[>"] = { "<cmd>split<CR>", "Split Window Horizontally" },
    ["<C-n>"] = {"<cmd>Dired<CR>", "open Dired buffer"},
    ["<leader>gh"] = { "<cmd>Neogit<CR>"},
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

M.nvimtree = {
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
}


return M
