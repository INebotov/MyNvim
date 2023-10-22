local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    'gopls',
    'pylsp',
    'yamlls',
})

local util = require'lspconfig.util'
require("lspconfig").gopls.setup({
   root_dir = function(fname)
      -- see: https://github.com/neovim/nvim-lspconfig/issues/804
      local mod_cache = vim.trim(vim.fn.system 'go env GOMODCACHE')
      if fname:sub(1, #mod_cache) == mod_cache then
         local clients = vim.lsp.get_active_clients { name = 'gopls' }
         if #clients > 0 then
            return clients[#clients].config.root_dir
         end
      end
      return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
   end,

  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
    vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
    vim.keymap.set('n', 'fm', '<cmd>lua vim.lsp.buf.format()<cr>', {})
    vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})

    vim.keymap.set("n", "gh", function() require("trouble").toggle() end)
    vim.keymap.set("n", "<leader>wd", function() require("trouble").toggle("workspace_diagnostics") end)
    vim.keymap.set("n", "<leader>dd", function() require("trouble").toggle("document_diagnostics") end)
    vim.keymap.set("n", "<leader>qf", function() require("trouble").toggle("quickfix") end)
    vim.keymap.set("n", "<leader>ll", function() require("trouble").toggle("loclist") end)
    vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
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
