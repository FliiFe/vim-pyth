let g:pyth_interpreter_path = get(g:, 'pyth_interpreter_path', "~/pyth/pyth.py")

function! PythDebug()
    call OpenPythWindow()
    autocmd TextChanged *.pyth :call UpdatePyth()
    autocmd TextChangedI *.pyth :call UpdatePyth()
endfunction

function! OpenPythWindow()
    silent keepalt botright vertical 50 split __PythWindow__
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    set nobuflisted
    set nomodifiable
    set nonu
    wincmd p
endfunction

function! UpdatePyth()
    let pythwindow = bufwinnr('__PythWindow__')
    if pythwindow == -1
        return
    endif
    let oldregisterP = @p
    silent %yank p
    execute pythwindow.'wincmd w'
    setlocal modifiable
    silent %delete _
    silent put p
    let command = 'silent :%!' . g:pyth_interpreter_path
    setlocal nomodifiable
    let @p = oldregisterP
    wincmd p
endfunction

