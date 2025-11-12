set path =.,,**
let mapleader = " "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set nu
set rnu
filetype on
filetype plugin on
filetype indent on
nnoremap <leader>f :find<Space>
nnoremap <leader>w :w<CR>

function! RecentFiles()
    let l:files = copy(v:oldfiles)

    "call filter(l:files, 'filtereadable(expand(v:val))')
    call setqflist([], 'r', {'Title': 'Recent Files', 'lines': l:files})
    copen

    nnoremap <buffer> q :cclose<CR>
    nnoremap <CR> :call <SID>OpenFromQuickfix()<CR>
endfunction

function! s:OpenFromQuickfix()
    let l:item = getqflist()[line('.') - 1]

    cclose

    execute 'edit ' . fnameescape(l:item.text)
endfunction

let g:python_highlight_all = 1
nnoremap <leader>ff :call RecentFiles()<CR>

function! ResizeMode()
    echo "-- RESIZE MODE -- (h/j/k/l to resize, = to equalize, q/Enter to exit)"
    while 1
        let l:key = nr2char(getchar())
        if l:key == 'h'
            vertical resize -5
        elseif l:key == 'l'
            vertical resize +5
        elseif l:key == 'j'
            resize +5
        elseif l:key == 'k'
            resize -5
        elseif l:key == '='
            resize '='
        elseif l:key == 'q' || l:key == "\<CR>"
			echo ""
            redraw
			return
        else
            echo "Invalid key. Use h/j/k/l/=/q"
        endif
        redraw
        echo "-- RESIZE MODE -- (h/j/k/l to resize, = to equalize, q/Enter to exit)"
    endwhile
endfunction

nnoremap <leader>r :call ResizeMode()<CR>
