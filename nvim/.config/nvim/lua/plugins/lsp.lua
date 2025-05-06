return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "j-hui/fidget.nvim",
      tag = "v1.4.0",
      opts = {
        progress = {
          display = { done_icon = "✓" },
        },
        notification = { window = { winblend = 0 } },
      },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Key mappings for LSP functions
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- Highlight references on cursor hold
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    -- LSP server configurations
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
      ruff_lsp = {},
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      jsonls = {},
      terraformls = {},
      yamlls = {},
      bashls = {},
      dockerls = {},
      docker_compose_language_service = {},
      tailwindcss = {},
      html = { filetypes = { "html", "twig", "hbs" } },
      cssls = {},
      tsserver = {},
    }

    -- Mason setup
    require("mason").setup()

    local ensure_installed = {
      "stylua",                          -- Lua formatter
      "lua-language-server",
      "pyright",                         -- Python language server
      "ruff-lsp",                        -- Python linter
      "typescript-language-server",      -- TypeScript language server
      "html-lsp",                        -- HTML language server
      "css-lsp",                         -- CSS language server
      "tailwindcss-language-server",     -- Tailwind CSS language server
      "json-lsp",                        -- JSON language server
      "terraform-ls",                    -- Terraform language server
      "yaml-language-server",            -- YAML language server
      "bash-language-server",            -- Bash language server
      "dockerfile-language-server",      -- Dockerfile language server
      "docker-compose-language-service", -- Docker Compose language service
    }

    require("mason-tool-installer").setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
