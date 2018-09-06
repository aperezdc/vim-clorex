" Author: Adrián Pérez de Castro <aperez@igalia.com>
" License: Distributed under terms of the MIT license.

if exists('g:autoloaded_clorex')
	finish
endif
let g:autoloaded_clorex = v:true

let s:save_cpo = &cpo
set cpo&vim

let s:scriptpath = fnamemodify(resolve(expand('<sfile>:p')), ':h:h') . '/clorex'
let s:buffer = v:null

function s:listcmd(cmdl)
	let l:cmds = ''
	let l:tail = v:false
	for item in a:cmdl
		if l:tail
			let l:cmds .= ' '
		else
			let l:tail = v:true
		endif
		let l:cmds .= shellescape(item)
	endfor
	return l:cmds
endfunction

function s:runscript(cliargs)
	let l:cmd = ['/bin/sh', s:scriptpath] + a:cliargs
	if has('nvim')
		call add(l:cmd, '--nvim')
	else
		call add(l:cmd, '--vim')
	endif

	if exists('*termopen') && v:false
		let l:opt = {}
		let s:term = termopen(l:cmd, l:opt)
	elseif exists(':terminal')
		execute ':terminal ' . s:listcmd(l:cmd)
	else
		execute ':! ' . s:listcmd(l:cmd)
	endif
endfunction

function clorex#install()
	call s:runscript(['--install-only'])
endfunction

function clorex#update()
	call s:runscript(['--update-only'])
endfunction

function clorex#clean()
	call s:runscript(['--clean-only'])
endfunction

function clorex#()
	call s:runscript([])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
