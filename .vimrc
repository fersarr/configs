colo koehler
tabstop=4
set expandtab
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
set autoindent


" Pathogen: allows auto install of plugins like NERDTree
execute pathogen#infect
syntax on
filetype plugin indent on

" NERDTree shortcut
:map <C-y> :NERDTreeToggle<CR>
