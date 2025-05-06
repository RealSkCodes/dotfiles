-- Import the required files
require "core.keymaps"
require "core.options"

-- Completely disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_nogx = 1 -- Disables gx mapping to open URLs

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins below
require("lazy").setup {
  require "plugins.neotree",
  require "plugins.colortheme",
  require "plugins.bufferline",
  require "plugins.lualine",
  require "plugins.treesitter",
  require "plugins.telescope",
  require "plugins.lsp",
  require "plugins.autocompletion",
  require "plugins.autoformatting",
  require "plugins.gitsigns",
  require "plugins.alpha",
  require "plugins.indent-blankline",
  require "plugins.misc",
  require "plugins.nvim-tmux-navigator",
  require "plugins.lazygit",
}

local ts_group = vim.api.nvim_create_augroup("TelescopeOnEnter", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    local first_arg = vim.v.argv[3]
    if first_arg and vim.fn.isdirectory(first_arg) == 1 then
      -- Close the initial empty buffer
      vim.cmd ":bd 1"

      -- Open Telescope
      require("telescope.builtin").find_files {
        search_dirs = { first_arg },
        attach_mappings = function(_, map)
          map("i", "<C-q>", function()
            require("telescope.actions").close(_)
            vim.cmd("Neotree " .. first_arg) -- Open Neo-Tree in the correct folder
          end)
          return true
        end,
      }
    end
  end,
  group = ts_group,
})
