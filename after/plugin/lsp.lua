local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"ltex"
})

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = {}
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
	signs = false
    }
)

lsp.configure("ltex", {
  settings = {
    ltex = {
      language = "en-GB",
			disabledRules = {["en-GB"] = {"OXFORD_SPELLING_NOUNS", "OXFORD_SPELLING_VERBS", "PASSIVE_VOICE", "OXFORD_SPELLING_Z_NOT_S"}},
		  additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-GB",
      },
    }
  },
  on_attach = function(client, bufnr)
			lsp.default_keymaps({buffer = bufnr}) -- add lsp-zero defaults

			local opts = {buffer = bufnr}
			vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

lsp.configure("rust_analyzer", {
  settings = {
			["rust-analyzer"] = {
					diagnostics = {
							enable = true,
							disabled = {"unresolved-proc-macro"},
							enableExperimental = true,
					},
				  checkOnSave = {
            command = "clippy"
          },
			}
  },
})

lsp.setup()
