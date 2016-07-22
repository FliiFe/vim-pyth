let g:pyth_interpreter_path = get(g:, 'pyth_interpreter_path', "~/pyth/pyth.py")
let g:pyth_arguments = get(g:, 'pyth_arguments', '-cD')

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
    silent put! p
    silent :%s#\n\%$##
    " let command = 'silent :%!' . g:pyth_interpreter_path . ' -d'
    " execute command
    let @p = system(g:pyth_interpreter_path . ' ' . g:pyth_arguments . ' ', getreg('p', 1))
    silent %delete _
    silent put! p
    silent :%s#\n\%$##
    setlocal nomodifiable
    let @p = oldregisterP
    wincmd p
endfunction

