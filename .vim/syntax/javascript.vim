syntax keyword javaScriptOperator of
syntax keyword javaScriptReserved require
syntax keyword javaScriptStatement async await

syntax match javaScriptOperator "\.\.\."
syntax match javaScriptFunction "=>"

syntax region javaScriptStringTV start='${' end="}"
syntax region javaScriptStringT start='`' skip=/\\\\\|\\`/ end='`' contains=javaScriptStringTV,javaScriptSpecial,@htmlPreproc

highlight link javaScriptStringT String
highlight link javaScriptStringTV Operator
