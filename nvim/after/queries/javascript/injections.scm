; Use HTML syntax highlighting in template for vue.js
; template: `<html>`
; (pair
;   key: (property_identifier) @_name
;     (#eq? @_name "template")
;   value: (template_string) @html
; )

; Inject HTML syntax highlighting for `template` strings in JavaScript
; Highlight the value of the "template" key as HTML
; (pair
;   key: (property_identifier) @_name
;     (#eq? @_name "template")
;   value: (template_string (string_fragment)) @html
; )
