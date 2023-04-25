local ms_status, mason = pcall(require, "mason")
if not ms_status then
  print("mason is not installed / erorr")
  return
end

local ms_lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ms_lsp_status then 
  print("mason lsp is not working or not installed")
  return
end


local mason_nullls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_nullls_status then 
  print("mason_null_ls is not installed or not working")
  return
end




mason.setup()

mason_lspconfig.setup({
  ensure_installed = {

      "cssls",
      "html",
      -- "hls",
      "tsserver",
      "lua_ls",
      "pyright",


  }
})

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",


  }
})
