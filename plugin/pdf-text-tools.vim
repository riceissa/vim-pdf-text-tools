if exists('g:loaded_pdf_text_tools')
  finish
endif
let g:loaded_pdf_text_tools = 1

" Filter text pasted from PDFs, so that formatting is suitable. Progress is
" ongoing. The join must be called at the very end because vim assigns <line1>
" and <line2> when the command is invoked (rather than continually resetting
" them to be the new boundaries), so we can't change the boundaries of the
" line markers; for the same reason, we can't regex replace new lines.
command! -range FilterPDFText silent <line1>,<line2>s/$/ /e |
  \ silent <line1>,<line2>s/\-\s\+$//e |
  \ silent <line1>,<line2>s/\s\+/ /ge |
  \ silent <line1>,<line2>s/^\s\+//e |
  \ <line1>,<line2>join!

" TODO: This probably overrides whatever was visually selected, but it
" probably shouldn't.
nnoremap <expr> Q &textwidth == 0 ?
  \ 'Vip:FilterPDFText<CR>:s/\s\+$//e<CR>' :
  \ 'Vip:FilterPDFText<CR>:s/\s\+$//e<CR>gqip'

" vim: sw=2 et:
