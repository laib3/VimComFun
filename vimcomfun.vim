"given a pattern, returns the list of possible complete options
"you have to define the global variable 'g:complete_dict' (a dictionary)
"it would be a good idea to define this variable for each different filetype
function! GetCompleteOptions(pattern)
  if !exists("g:complete_dict")
	echoerr "g:complete_dict not set!" 
	return []
  endif
  let idx = -1
  let keywords = keys(g:complete_dict)
  for word in keywords
	let match = max([stridx(a:pattern, word), stridx(word, a:pattern)])
	let idx+=1
	"if the pattern is in keywords then get the list of possible completions
	if (match != -1) 
	  let keyword = keywords[idx]
	  return g:complete_dict[keyword]
	endif	  
  endfor
  return []
endfunction

"invoked by the combination <C-x><C-u>. You can remap this combination
"to <C-@> (i.e. CTRL+Space) to have something similar to other IDEs.
function! CompleteFunc(findstart, base)
  if(a:findstart == 1)
	normal b
	return col('.')-1
  endif
  if(a:findstart == 0)
	let completeoptions = GetCompleteOptions(a:base)
	if(completeoptions != [])
	  let retval = #{words: completeoptions, refresh: "always"}
	  return retval
	endif
  endif
endfunction


set completefunc=CompleteFunc
