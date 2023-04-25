 local ls_status, lspconfig = pcall(require, "lspconfig")
 if not ls_status then
   print("lspconfig is not installed or there is an erorr")
   return
 end


 local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
 if not  cmp_nvim_lsp_status then 
   print("cmp_nvim_lsp is not installed or there is an erorr")
   return 
 end

 local typescript_status, typescript = pcall(require, "typescript")
 if not  typescript_status then 
   print("typescript is not installed or there is an erorr")
   return
 end


 local keym = vim.keymap

 local on_atch = function(client, bufnr)
 


  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keym.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keym.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keym.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keym.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keym.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keym.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keym.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keym.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keym.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keym.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keym.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keym.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side


    if client.name == "tsserver" then
          keym.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
        end
      end


-- used to enable autocompletion (assign to every lsp server config)

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_atch,
})

typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_atch,
  },
})

lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_atch,
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_atch,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})
