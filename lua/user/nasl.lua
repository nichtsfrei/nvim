local configs = require("lspconfig.configs")

local util = require("lspconfig.util")

-- vim.lsp.start({
--	name = "nasl-analyzer",
--	cmd = { "nasl-analyzer" },
--	root_dir = vim.fs.dirname(vim.fs.find({ "example.nasl" }, { upward = true })[1]),
--})
local function create_config()
  return {
    default_config = {
      cmd = { "nasl-analyzer" },
      filetypes = { "nasl", "inc" },
      root_dir = util.root_pattern("example.nasl", ".git"),
      single_file_support = true,
      settings = {},
    },
    docs = {
      description = [[
]]     ,
    },
  }
end

configs.nasl = create_config()

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.nasl = {
  install_info = {
    url = "~/src/nichtsfrei/tree-sitter-nasl", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"},
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "nasl", -- if filetype does not match the parser name
}

