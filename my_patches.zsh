# Strategies to use to fetch a suggestion 
# Will try each strategy in order until a suggestion is returned 
(( ! ${+ZSH_AUTOSUGGEST_STRATEGY} )) && { 
       typeset -ga ZSH_AUTOSUGGEST_STRATEGY 
       ZSH_AUTOSUGGEST_STRATEGY=(history completion) 
} 

# Widgets that accept the entire suggestion 
(( ! ${+ZSH_AUTOSUGGEST_ACCEPT_WIDGETS} )) && { 
       typeset -ga ZSH_AUTOSUGGEST_ACCEPT_WIDGETS 
       ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( 
               end-of-line
               vi-end-of-line 
               vi-add-eol 
       ) 
} 

# Widgets that accept the suggestion as far as the cursor moves 
(( ! ${+ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS} )) && { 
       typeset -ga ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS 
       ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=( 
               forward-char 
               emacs-forward-word 
               vi-forward-word 
               vi-forward-word-end 
               vi-forward-blank-word 
               vi-forward-blank-word-end 
               vi-find-next-char 
               vi-find-next-char-skip 
       ) 
}
