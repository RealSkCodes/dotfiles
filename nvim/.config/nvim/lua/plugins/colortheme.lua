return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
      transparent_background = true, -- Enables transparency
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
        },
        telescope = true,
        cmp = true,
        gitsigns = true,
      },
    }

    -- Load the colorscheme
    vim.cmd.colorscheme "catppuccin"

    -- Toggle background transparency
    local bg_transparent = true
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require("catppuccin").setup { transparent_background = bg_transparent }
      vim.cmd.colorscheme "catppuccin"
    end

    vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
  end,
}
