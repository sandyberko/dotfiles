(list . (symbol) @function)
(list . (unquote "," @keyword))
(list
  .
  (symbol) @keyword
  (#any-of? @keyword "^" "=" "||")
)

(number) @constant.numeric

["(" ")"] @punctuation.bracket

(list
  .
  (
    (symbol) @keyword
    (symbol) @variable.parameter
  )
  (#eq? @keyword "?")
)

(list
  .
  ((symbol) @comment)
  ((symbol) @info)
  (#eq? @comment "//")
)
