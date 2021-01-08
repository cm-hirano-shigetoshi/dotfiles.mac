call plug#begin('~/.local/share/nvim/plugged')
    Plug 'https://github.com/tpope/vim-repeat'
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/nvie/vim-flake8'
    Plug 'https://github.com/osyo-manga/vim-brightest'
    "Plug 'https://github.com/t9md/vim-quickhl'
    Plug 'https://github.com/mechatroner/rainbow_csv'
    Plug 'https://github.com/cm-hirano-shigetoshi/WordSearch.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/TimeMachine.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/RecentUse.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/FileSearch.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/SearchAllBuffers.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/Buffers.vim'
    Plug 'https://github.com/cm-hirano-shigetoshi/vim-csvq'
    Plug 'https://github.com/cm-hirano-shigetoshi/vim-easymotion'
call plug#end()

"
"vim-surround
"
let g:surround_no_mappings = 1
nmap S <Plug>Ysurround
xmap S <Plug>VSurround

"
"vim-easymotion
"
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_do_mapping_textobj = 1
nmap s <Plug>(easymotion-overwin-f)
vmap s <Plug>(easymotion-bd-f)
omap s <Plug>(easymotion-bd-f)

"
"vim-brightest
"
let g:brightest#highlight = {"group": "BrightestUndercurl"}
let g:brightest#pattern = '\k\+'

"
"quickhl
"
"nmap g* g*<Plug>(quickhl-manual-this)
"let g:quickhl_cword_enable_at_startup = 1
"let g:quickhl_cword_hl_command = 'link QuickhlCword SpellCap'


"
"vim-csv
"
nmap <F8> <Plug>(CSVQ)

