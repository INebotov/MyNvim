local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
    'gopls',
    'pylsp',
    'yamlls',
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
    vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
    vim.keymap.set('n', 'fm', '<cmd>lua vim.lsp.buf.format()<cr>', {})
    vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
    vim.keymap.set('n', 'gh', '<cmd>lua vim.diagnostic.open_float()<cr>', {})
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    preselect = 'item',
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = {
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ['<C-q>'] = cmp_action.luasnip_jump_forward(),
        ['<C-a>'] = cmp_action.luasnip_jump_backward(),
    },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

lsp.setup()
