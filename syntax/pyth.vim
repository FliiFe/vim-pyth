if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword K t
highlight link potionKeyword Keyword

let b:current_syntax = "pyth"
