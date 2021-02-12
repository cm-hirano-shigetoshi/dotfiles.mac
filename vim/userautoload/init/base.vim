" 書き込み権限がないとき、!をつけても上書きしない
set cpoptions+=W
" スワップファイルを作成しない
set noswapfile
" backupファイルの出力先
set backup
set backupdir=~/.nvim/backup
" 折り返したときは行番号の部分にも描画する
set cpoptions+=n
" 現在のバッファに変更があっても他のバッファに移れる
set hidden
" 行番号を表示
set number
" タブなどに対して薄く文字を表示する
set list
" 表示する文字の設定
set listchars=tab:>\ ,trail:_,nbsp:%
" 折り返ししない
set nowrap
" タブの代わりに空白を挿入
set expandtab
" タブは4文字
set tabstop=4
" 自動挿入されるタブも4文字
set shiftwidth=4
" 先頭の空白だけBackspaceでタブのように消す
set smarttab
" タブインデント行を<<した時に空白にしない
set preserveindent
" タブインデント行の次の行はタブにする
set copyindent
" ファイル名補完では大文字小文字を区別しない
set fileignorecase
" =はファイル名を表す文字列と解釈しない
set isfname-=\=
" 最後の行に改行がないファイルをそのまま扱う
set nofixeol
" 検索のハイライト
set hlsearch
" 数値の増減は10進数
set nf=""
" mapleaderの設定
let mapleader = " "


nnoremap Y "*y$
nnoremap y "*y
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap <Leader><CR> V:!sh<CR>
nnoremap # *zz
nnoremap g# g*NNzz
nnoremap <C-i> <C-i>zz
nnoremap <C-o> <C-o>zz

inoremap <C-c> <ESC>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

cnoremap <C-a> <C-b>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

vnoremap y "*y
vnoremap Y "*Y
vnoremap * y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>zz
vnoremap # y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>NNzz
vnoremap <Leader><CR> :!sh<CR>

let g:omni_sql_no_default_maps = 1
