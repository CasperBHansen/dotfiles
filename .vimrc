augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

autocmd FileType make setlocal noexpandtab

" SETTINGS "
filetype plugin on

set switchbuf=useopen,usetab
set tags+=/home/casperbhansen/.vim/tags/cpp
set omnifunc=syntaxcomplete#Complete

set encoding=utf-8
set fileencoding=utf-8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set rtp+=/home/casperbhansen/.local/lib/python2.7/site-packages/powerline/bindings/vim
set laststatus=2

let g:Powerline_symbols = 'fancy'
set number

color molokai
syntax on

" MAPPINGS "
nnoremap <C-t> :tabnew<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>

map <F3> :w !detex \| wc -w<CR>
map <C-c> :make clean<CR><CR><CR>
map <C-b> :make all<CR><CR><CR>
map <C-r> :make run<CR>

function! OpenClass(filename)
    let class  = substitute(a:filename, '[.]\w*', '', '')
    let $head = class.".h"
    let $impl = class.".cpp"
    tabnew
    e $impl
    vs
    e $head
endfunction

com! -nargs=1 -complete=file E :call OpenClass("<args>") | 

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" broken for some reason :( "
" au VimEnter * nested :call LoadSession()
" au VimLeave * :call MakeSession()

