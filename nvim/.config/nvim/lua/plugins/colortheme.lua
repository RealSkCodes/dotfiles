return {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup {
      style = "night",        -- Options: "storm", "night", "moon", "day"
      transparent = true,     -- Enables transparency
      terminal_colors = true, -- Ensures terminal colors match theme
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
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
    vim.cmd.colorscheme "tokyonight"

    -- Toggle background transparency
    local bg_transparent = true
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require("tokyonight").setup {
        transparent = bg_transparent,
        styles = {
          sidebars = bg_transparent and "transparent" or "dark",
          floats = bg_transparent and "transparent" or "dark",
        },
      }
      vim.cmd.colorscheme "tokyonight"
    end

    vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
  end,
}
