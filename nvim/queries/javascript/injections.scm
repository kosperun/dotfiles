; Inject HTML into JavaScript template strings enclosed in backticks (`)
; extends
(
  (pair
    key: (property_identifier) @_name
    (#eq? @_name "template")  ; Match when the key is "template"
    value: (template_string) @injection.content
     (#set! injection.combined)
     (#set! injection.include-children)
    (#set! injection.language "html")  ; Treat the content as HTML
  )
)
