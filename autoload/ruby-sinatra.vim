function! s:FTRubySinatra()
  if exists("g:filetype_ruby_sinatra")
    exe "setfiletype " . g:filetype_ruby_sinatra
    return
  else
    call s:FTRubySinatraCheck()
    return
  endif
endfunc

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
      let g:filetype_ruby_sinatra = "ruby-sinatra"
      exe "setfiletype " . g:filetype_ruby_sinatra
      return
    endif
    let lnum = lnum + 1
  endw
  setfiletype ruby
endfunc

