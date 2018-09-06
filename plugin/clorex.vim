" Author: Adrián Pérez de Castro <aperez@igalia.com>
" License: Distributed under terms of the MIT license.

if exists('g:loaded_clorex')
	finish
endif
let g:loaded_clorex = v:true

let s:save_cpo = &cpo
set cpo&vim

command! Clorex call clorex#()
command! ClorexClean call clorex#clean()
command! ClorexUpdate call clorex#update()
command! ClorexInstall call clorex#install()

let &cpo = s:save_cpo
unlet s:save_cpo
