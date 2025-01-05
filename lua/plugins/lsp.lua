return {
		{
				"neovim/nvim-lspconfig",
				event = { "BufReadPost", "BufWritePost", "BufNewFile" },
				dependencies = {
						"mason.nvim",
						{ "williamboman/mason-lspconfig.nvim", config = function() end },
				},
				opts = function()
						local ret = {
								-- options for vim.diagnostic.config()
								diagnostics = {
										underline = true,
										update_in_insert = false,
										virtual_text = {
												spacing = 4,
												source = "if_many",
												prefix = "●",
										},
										severity_sort = true,
										signs = false
								},
								-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
								-- Be aware that you also will need to properly configure your LSP server to
								-- provide the inlay hints.
								inlay_hints = {
										enabled = true,
										exclude = { }, -- filetypes for which you don't want to enable inlay hints
								},
								-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
								-- Be aware that you also will need to properly configure your LSP server to
								-- provide the code lenses.
								codelens = {
										enabled = false,
								},
								-- add any global capabilities here
								capabilities = {
										workspace = {
												fileOperations = {
														didRename = true,
														willRename = true,
												},
										},
								},
								-- options for vim.lsp.buf.format
								-- `bufnr` and `filter` is handled by the LazyVim formatter,
								-- but can be also overridden when specified
								format = {
										formatting_options = nil,
										timeout_ms = nil,
								},
								setup = {},
								-- LSP Server Settings
								servers = {
										lua_ls = {
												-- mason = false, -- set to false if you don't want this server to be installed with mason
												-- Use this to add any additional keymaps
												-- for specific lsp servers
												-- ---@type LazyKeysSpec[]
												-- keys = {},
												settings = {
														Lua = {
																workspace = {
																		checkThirdParty = false,
																},
																codeLens = {
																		enable = true,
																},
																completion = {
																		callSnippet = "Replace",
																},
																doc = {
																		privateName = { "^_" },
																},
																hint = {
																		enable = true,
																		setType = false,
																		paramType = true,
																		paramName = "Disable",
																		semicolon = "Disable",
																		arrayIndex = "Disable",
																},
														},
												},
										},
										rust_analyzer = {
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
												}
										},
								},
						}
						return ret
				end,
				config = function(_, opts)
						vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
						vim.diagnostic.config{
							float = { border = "rounded" }
						}

						vim.api.nvim_create_autocmd('LspAttach', {
							desc = 'LSP actions',
							callback = function(event)
								local opts = {buffer = event.buf}

								vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
								vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
								vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
								vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
								vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
								vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
								vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
								vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
								vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
								vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
								vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
								vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
								vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) 
							end
						})

						vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

						local servers = opts.servers
						local cmp_nvim_lsp = require("cmp_nvim_lsp")
						local capabilities = vim.tbl_deep_extend(
								"force",
								vim.lsp.protocol.make_client_capabilities(),
								cmp_nvim_lsp.default_capabilities(),
								opts.capabilities or {}
						)
						local function setup(server)
								local server_opts = vim.tbl_deep_extend("force", {
										capabilities = vim.deepcopy(capabilities),
								}, servers[server] or {})
								if server_opts.enabled == false then
										return
								end

								if opts.setup[server] then
										if opts.setup[server](server, server_opts) then
												return
										end
								elseif opts.setup["*"] then
										if opts.setup["*"](server, server_opts) then
												return
										end
								end
								require("lspconfig")[server].setup(server_opts)
						end

						local have_mason, mlsp = pcall(require, "mason-lspconfig")
						local all_mslp_servers = {}
						if have_mason then
								all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
						end

						local ensure_installed = {} ---@type string[]
						for server, server_opts in pairs(servers) do
								if server_opts then
										server_opts = server_opts == true and {} or server_opts
										if server_opts.enabled ~= false then
												-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
												if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
														setup(server)
												else
														ensure_installed[#ensure_installed + 1] = server
												end
										end
								end
						end
						if have_mason then
								mlsp.setup({
										ensure_installed = vim.tbl_deep_extend(
										"force",
										ensure_installed,
										{}
										),
										handlers = { setup },
								})
						end
				end
		},
		{
				"williamboman/mason.nvim",
				cmd = "Mason",
				keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
				build = ":MasonUpdate",
				opts_extend = { "ensure_installed" },
				opts = {
						ensure_installed = {
								"stylua",
								"shfmt",
								"rust-analyzer",
								"python-lsp-server",
						},
				},
				config = function(_, opts)
						require("mason").setup(opts)
						local mr = require("mason-registry")
						mr:on("package:install:success", function()
								vim.defer_fn(function()
										-- trigger FileType event to possibly load this newly installed LSP server
										require("lazy.core.handler.event").trigger({
												event = "FileType",
												buf = vim.api.nvim_get_current_buf(),
										})
								end, 100)
						end)

						mr.refresh(function()
								for _, tool in ipairs(opts.ensure_installed) do
										local p = mr.get_package(tool)
										if not p:is_installed() then
												p:install()
										end
								end
						end)
				end,
		},
		{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
						"hrsh7th/cmp-nvim-lsp",
						"hrsh7th/cmp-buffer",
						"hrsh7th/cmp-path",
						"saadparwaiz1/cmp_luasnip",
						"L3MON4D3/LuaSnip",
						"rafamadriz/friendly-snippets",
						"hrsh7th/cmp-nvim-lsp-signature-help",
						"onsails/lspkind.nvim",
				},
				config = function()
						local cmp = require("cmp")
						cmp.setup({
								enabled = function()
										local context = require("cmp.config.context")
										-- keep command mode completion enabled when cursor is in a comment
										if vim.api.nvim_get_mode().mode == 'c' then
												return true
										else
												return not context.in_treesitter_capture("comment")
												and not context.in_syntax_group("Comment")
										end
								end,
								snippet = {
										expand = function(args)
												require('luasnip').lsp_expand(args.body)
										end,
								},
								formatting = {
										format = require('lspkind').cmp_format({
												mode = 'symbol', -- show only symbol annotations
												maxwidth = {
														menu = 30, -- leading text (labelDetails)
														abbr = 50, -- actual suggestion item
												},
										})
								},
								sources = cmp.config.sources({
										{ name = 'nvim_lsp' },
										{ name = 'luasnip' },
										{ name = "nvim_lsp_signature_help" },
								}),
								window = {
										completion = cmp.config.window.bordered(),
										documentation = cmp.config.window.bordered(),
								},
								mapping = cmp.mapping.preset.insert({
										['<C-Up>'] = cmp.mapping.scroll_docs(-4),
										['<C-Down>'] = cmp.mapping.scroll_docs(4),
										['<C-Space>'] = cmp.mapping.complete(),
										['<C-e>'] = cmp.mapping.abort(),
										['<CR>'] = cmp.mapping.confirm({ select = true }),
								})
						}, {
								{ name = 'buffer' },
						})
				end
		},
}
