return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "numToStr/Comment.nvim", -- Smart commenting
    "JoosepAlviste/nvim-ts-context-commentstring", -- Fixes JSX/TSX comments
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      -- Add languages to be installed here that you want installed for Treesitter
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "regex",
        "terraform",
        "sql",
        "dockerfile",
        "toml",
        "json",
        "java",
        "groovy",
        "go",
        "gitignore",
        "graphql",
        "yaml",
        "make",
        "cmake",
        "markdown",
        "markdown_inline",
        "bash",
        "tsx",
        "css",
        "html",
      },

      -- Autoinstall languages that are not installed
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    }

    -- Register additional file extensions
    vim.filetype.add { extension = { tf = "terraform" } }
    vim.filetype.add { extension = { tfvars = "terraform" } }
    vim.filetype.add { extension = { pipeline = "groovy" } }
    vim.filetype.add { extension = { multibranch = "groovy" } }

    -- Comment.nvim setup with Treesitter integration
    require("Comment").setup {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }

    -- Disable default LSP comment behavior (to prevent conflicts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        vim.bo.commentstring = ""
      end,
    })
  end,
}
