function! s:FTRubySinatraCheck()
  " This function checks for valid Ruby/Sinatra syntax in the first twenty lines.
  " Look for either an opening comment or a program start.
  " If not found, just Ruby.
  let lnum = 1
  while lnum <= 20 && lnum < line('$')
    let line = getline(lnum)
    if line =~ '^\s*\(sinatra/*\|Sinatra::Base\|Sinatra::Application\)\>'
          \ || '^\s*\(configure\|set\|enable\|disable\)\>'
          \ || '^\s*\(use\|register\|helpers\|template\)\>'
          \ || '^\s*\(get\|post\|put\|delete\)\>'
      let g:filetype_ruby_sinatra = "ruby,sinatra"
      return
    endif
    let lnum = lnum + 1
  endwhile
endfunc

function! s:FTRubySinatra()
  call s:FTRubySinatraCheck()
  if exists("g:filetype_ruby_sinatra")
    execute "set filetype=" . g:filetype_ruby_sinatra
    execute "set syntax=ruby-sinatra"
  endif
  return
endfunc

" Ruby/Sinatra application name
autocmd BufNewFile,BufRead *.rb call s:FTRubySinatra()

" Ruby/Sinatra Extension
autocmd BufNewFile,BufRead sinatra/*.rb
      \ set filetype=ruby,sinatra
      \ set syntax=ruby-sinatra

