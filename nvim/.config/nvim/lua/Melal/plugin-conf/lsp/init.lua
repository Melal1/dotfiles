local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "Melal.plugin-conf.lsp.mason"
require("Melal.plugin-conf.lsp.handlers").setup()
require "Melal.plugin-conf.lsp.null-ls"
