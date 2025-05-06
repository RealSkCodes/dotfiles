-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- autoclose tags
    "windwp/nvim-ts-autotag",
  },
  -- {
  --   -- detect tabstop and shiftwidth automatically
  --   "tpope/vim-sleuth",
  -- },
  {
    -- Powerful Git integration for Vim
    "tpope/vim-fugitive",
  },
  {
    -- GitHub integration for vim-fugitive
    "tpope/vim-rhubarb",
  },
  {
    -- Hints keybinds
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- win = {
      --   border = {
      --     { '┌', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '┐', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --     { '┘', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '└', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --   },
      -- },
    },
    keys = {
      {
        "<leader>r",
        [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]],
        mode = "n",
        desc = "Replace word (all occurrences)",
      },
    },
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
