	" define nasl
	if exists("did_load_filetypes")
	  finish
	endif
	augroup filetypedetect
	  au! BufRead,BufNewFile *.nasl		setfiletype nasl
	augroup END
