 local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "c", "cpp","css", "lua", "bash", "arduino", "gitcommit","gitignore","go","gomod","gosum","json5","rust","typescript","tsx","yaml", "vim", "vimdoc", "query",  "heex", "javascript", "html" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },  
})


