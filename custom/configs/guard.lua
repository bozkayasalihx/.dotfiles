local ft = require('guard.filetype')

ft('go'):fmt('gofmt')

require('guard').setup({
    fmt_on_save = true,
    lsp_as_default_formatter = false,
})
