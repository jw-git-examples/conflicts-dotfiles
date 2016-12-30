" APPEARANCE

set title
set number
set scrolloff=2
set sidescrolloff=5

" Search highlighting with modified coloring
set hlsearch
highlight Search cterm=reverse ctermfg=NONE ctermbg=NONE
highlight Visual cterm=NONE ctermfg=NONE  ctermbg=black
" Clear highlighting on escape in normal mode
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

highlight DiffAdd cterm=none ctermfg=green ctermbg=black
highlight DiffDelete cterm=none ctermfg=darkred ctermbg=black
highlight DiffChange cterm=none ctermfg=none ctermbg=black
highlight DiffText cterm=none ctermfg=black ctermbg=darkyellow

" don't move cursor when leaving insert mode
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" BEHAVIOUR

" let arrows and h,l move cursor accross newlines
set whichwrap+=h,l,<,>,[,]

" move on soft lines in insert mode
"inoremap <Down> <C-o>g<Down>
"inoremap <Up> <C-o>g<Up>

noremap <silent> j gj
noremap <silent> k gk
noremap <Down> gj
noremap <Up> gk

" wrap only on word boundaries
set linebreak

set cursorline cursorcolumn

set expandtab
set tabstop=8
set shiftwidth=2
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching

" enable mouse support. This makes scrolling behave normally (moves content
" instead od moving cursor) and lets user select text with mouse.
set mouse=a

" Automatically use system wide clipboard
set clipboard=unnamedplus

" Allow having multiple files with unsaved changes opened simultaneously
set hidden

" new undo item when pressed CR
inoremap <CR> <C-G>u<CR>
"Enable middle mouse button clipboard support
set guioptions+=a

set pastetoggle=<F5>

" Use green cursor in insert mode, red in normal mode
" gvim settings:
autocmd InsertEnter * highlight Cursor guifg=white guibg=green
autocmd InsertLeave * highlight Cursor guifg=white guibg=green
autocmd InsertLeave * highlight Normal guibg=white guifg=black 
autocmd InsertEnter * highlight Normal guibg=lightyellow guifg=black
" terminal vim settings:
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;green\x7"
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]12;white\007"
endif

" Leader commands
let mapleader = "\<Space>"
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>wc :w<CR>:bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>v :source $MYVIMRC<CR>
vmap <Leader>y "+y
nnoremap <Leader>p "+p



" REMAPS

" make paragraph-jumping go to last line of the next paragraph when jumping
" downwards, and first line of the previous paragraph when jumping upwards.
nnoremap { k{<Space>0
vnoremap { k{<Space>0
nnoremap } j}<BS>0
vnoremap } j}<BS>0

" Make backspace work in normal mode
nnoremap <BS> X
nnoremap <S-BS> x

" break line in normal mode
nnoremap <CR> i<CR><ESC>

"Preview unsaved changes
command! Showchanges w !diff % -

" Plugins managed by Vim-Plug (github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chase/vim-ansible-yaml'

Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-V> <Plug>(expand_region_shrink)

" Make register behaviour more resonable
Plug 'svermeulen/vim-easyclip'
"" Map x to cut 
let g:EasyClipUseCutDefaults = 0
nmap x <Plug>MoveMotionPlug
xmap x <Plug>MoveMotionXPlug
nmap xx <Plug>MoveMotionLinePlug
"" Map s to substitute 
let g:EasyClipUseSubstituteDefaults = 1

" TODO: plugins to investigate
"Plug 'terryma/vim-multiple-cursors' "overrides default C-n and C-p mappings
"Valloric/YouCompleteMe
"align
"autoclose (!)
"asynccommand
"colorpack (!)
"ctrlp (!)
"easymotion
"gist
"nerdcomment
"omnicppcomplete
"snipMate (!)
"supertab (!)
"syntastic (!)
"(!) means that the plugin is super awesome. 
"reedes/vim-textobj-sentence
"garbas/vim-snipmate
"scrooloose/nerdtree
"pearofducks/ansible-vim
call plug#end()

" TODO: settings to try out
"
" don't move cursor when exiting insert mode
"inoremap <Esc> <Esc>`^
"https://zenbro.github.io/2015/07/24/auto-change-keyboard-layout-in-vim.html
"keymap
"
"reflow text during formatting
"set formatoptions=ant
"
"set textwidth=79
"

"map ctrl-s in insert mode to save, because it's unused anyway (traditionally
"it was a terminal control flow binding)
"
" would allow changing escape behaviour so that it doensn't move cursor,
" as well as make it possible to e.g. do backward deletions (currently
" when the cursor is on the last char of a word and you say 'db' it will
" not delete this character. having this on would allow to move one char
" further and then be able to delete the word correctly.
"set virtualedit=onemore
"
"backspace in normal mode doesn't do anything useful (just moves left like h),
"so what about making it delete words? note that deleting words backwards in
"vim sometimes behaves strangely (try doing db when cursor is on the last
"letter).
"
"maybe make H (or equivalent in my keyboard layout) move by word, like b (or
"maybe like ge)?  In my current layout b is in an inconvenient spot.
"
"Currently in normal mode shift-arrows and control-arrows do the same.  Maybe
"I could use them for something different?  E.g. control-arrows move to the
"beginning of the word, and shift-arrows to the end?  Just like in most
"editors, where the direction you're going affects whether you land at word's
"beginning or end.
"
"Also, think whether hjkl (or rather the equivalent in my layout) and their
"control and shift combinations should do exactly the same as arrows and their
"combinations, or maybe I should rather take advantage of having many keys?
"
"Make C-Z work in insert mode (either as undo or as sending vim to background)

" TODO: how to do these?
"
" don't break undo into lines when pasting a block of text
"
"make control-arrows jump words instead of Words
"make ctrl-shift-arrow move by Words
"make ctrl-backspace work
"make control-arrow don't move to the next line if the cursor is not on line
"end
"
"define a command that deletes selection without putting it into any clipboard
"(i.e. delete instead of cut).  Maybe map it to x?
"
"autohighlight word under cursor, but with some non-intrusive colors
"
"make copying and pasting to system clipboard work with some reasonable
"shortcut.
"
"when moving by word, jump two words if there is a one-letter word next to
"ordinary one (e.g. in /paths/like/this)
"
"find a motion to move by indentation level (or code blocks)
"
" use backspace and enter for something in normal mode (maybe actually make backspace do backspace?)
" consider adding a mapping for inserting spaces/newlines without leaving normal mode - see https://www.reddit.com/r/vim/comments/3a1y8v/i_just_realized_backspace_doesnt_do_much_in/cs9a1g9
