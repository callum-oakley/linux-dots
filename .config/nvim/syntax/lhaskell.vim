if exists("b:current_syntax")
  finish
endif

syntax match lhsPlain "^[^>].*$" contains=lhsInlineCode
syntax match lhsInlineCode "`[^`]*`" contained

syntax match lhsCodeMarker "^>"

hi def link lhsPlain Comment
hi def link lhsInlineCode Normal
hi def link lhsCodeMarker NonText

let b:current_syntax = "lhaskell"
