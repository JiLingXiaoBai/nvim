
"======================
"=== Vim-Plug Begin ===
"======================

call plug#begin(g:pluggedpath)

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

call plug#end()

"======================
"==== Vim-Plug End ====
"======================
nnoremap <LEADER>u :UndotreeToggle<CR>

"自动生成 C 项目文件
function! s:generate_compile_commands_via_cmakelists()
	if empty(glob('CMakeLists.txt'))
		echo "Can not find CMakeLists.txt!"
		return
	endif
	if empty(glob('.build'))
		execute 'silent !mkdir .build'
	endif
	execute '!cmake -DCMAKE_BUILD_TYPE=debug
		\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .build'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands_via_cmakelists()

"自动生成 C 项目文件
"function! s:generate_compile_commands_via_makefile()
	"if empty(glob('.build/Makefile'))
		"echo "Can not find Makefile!"
	"else
		"echo "123"
	"endif
	"return
"endfunction
"command! -nargs=0 Gcmake1 :call s:generate_compile_commands_via_makefile()



"============================
"===== Rainbow Brackets =====
"============================
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
	\	'guifgs': ['#C186BF', '#268EDB','#F79318'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

"======================
"====== coc.nvim ======
"======================
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-json',
	\ 'coc-vimlsp',
	\ 'coc-sumneko-lua'
	\]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-cr> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cla  <Plug>(coc-codelens-action)


" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <leader><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <leader><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  vnoremap <silent><nowait><expr> <leader><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <leader><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> \a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> \e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> \c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> \o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> \s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> \j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> \k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> \p  :<C-u>CocListResume<CR>



