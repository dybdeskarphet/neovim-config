;; extends

;; Overwrite the outer string highlighting with plain text
((expression_statement
   (string) @variable)
 (#set! priority 100))

;; Overwrite the inner string content with plain text
((expression_statement
   (string
     (string_content) @variable))
 (#set! priority 100))
