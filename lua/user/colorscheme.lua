vim.cmd [[
try
  set background=dark
  colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
