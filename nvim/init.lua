vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.signcolumn = 'no'
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.opt.guicursor = ""

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
-- extensions
require('lazy').setup({
  'tpope/vim-sleuth',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  { 'folke/which-key.nvim',                   opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },
  {
    'bozkayasalihx/vim-phoenix',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'phoenix'
    end,
  },
  {
    'nvim-focus/focus.nvim',
    lazy = false,
    config = function(_, opt)
      require("focus").setup({
        ui = {
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = {
            enable = true,
            list = '+1,+2',
            cursorline = false,
          },
          winhighlight = true,
        },
        commands = true,
        autoresize = {
          enable = true,
        },
      })
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim", run = 'make'
  },

  { 'nvim-telescope/telescope-ui-select.nvim' },

  -- fuzzy finder framework
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      require('telescope').load_extension('fzf')
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      opleader = {
        line = "ga",
      },

      toggler = {
        line = "ga"
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',
  { import = 'custom.plugins' },
}, {})

-- extensions ends here
-- keymaps

-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set("n", "<C-p>", function()
  return require("telescope.builtin").find_files()
end, { desc = "Seach all [F]iles" })
vim.keymap.set("n", "<C-\\>", require("nvterm.terminal").toggle, { desc = "Show the Terminal" })
vim.keymap.set("t", "<C-\\>", require("nvterm.terminal").toggle, { desc = "Show the Terminal" })
vim.keymap.set("n", "<S-e>", vim.diagnostic.open_float, { desc = "show floting diagnostic menu" })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.cmd [[inoremap zz <esc>]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", opts)
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", opts)
vim.keymap.set("n", "<esc>", "<esc>:noh<cr>", opts)
vim.keymap.set("n", "zz", "<esc>:noh<cr>", opts)
vim.keymap.set("n", "ff", "<esc>:Format<cr>", opts)

vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

local dired = require("dired")
vim.keymap.set("n", "q", function()
  if vim.bo.filetype ~= "dired" then
    return dired.open()
  end
  if vim.bo.filetype == "dired" then
    return dired.quit()
  end
end, opts)

vim.keymap.set('n', '<C-]>', function()
  require('focus').split_command("l")
end)

vim.keymap.set('n', '<C-[>', function()
  require('focus').split_command("j")
end)

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'go', 'lua', 'rust', 'vimdoc', 'vim' },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)


local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require('which-key').register({
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lsputil   = require "lspconfig.util"

local servers   = {
  clangd = {
    filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp", "cuda" },
    flags = lsp_flags,
    cmd = { "clangd", "--background-index", "--all-scopes-completion" },
    single_file_support = true,
  },
  pyright = {
    filetypes = { "python" },
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
  rust_analyzer = {
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        diagnostics = {
          enable = false,
          disabled = { "unresolved-proc-macro" },
          enableExperimental = false,
        },
        procMacro = {
          enable = false
        },
      },
    },
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local Uopts = { unique = true, silent = true, noremap = true }
local opts = { silent = true, noremap = true }

local builtin = require('telescope.builtin')
vim.o.hlsearch = false
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})


vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  command = "setlocal signcolumn=no",
  pattern = { "*" },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*" },
  command = "cclose",
})

vim.cmd [[autocmd BufEnter <buffer> lua vim.diagnostic.hide()]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false
  }
)

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
