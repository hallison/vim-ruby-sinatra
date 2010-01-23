" Ruby/Sinatra application name
au BufNewFile,BufRead app.rb,application.rb call s:FTruby_sinatra

" Ruby/Sinatra Extension
au BufNewFile,BufRead sinatra/*.rb set filetype=ruby,sinatra

func! s:FTruby_sinatra()
  if exists("g:filetype_ruby_sinatra")
    exe "setfiletype " . g:filetype_ruby_sinatra
    return
  endif
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
      setfiletype ruby,sinatra
      let g:filetype_ruby_sinatra = "ruby,sinatra"
      return
    endif
    let lnum = lnum + 1
  endw
  setfiletype ruby
endfunc

