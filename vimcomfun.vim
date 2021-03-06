"Add these lines to your .vimrc file, or just source this file from there.

"given a path, return a dictionary; the file which contains the dictionary
"should have the following format: 
" - each key of the dictionary has a hash character (#) before 
" - each key is followed by the values (suggestions) one by line
function ReadDict(path)
  let dictionary = #{}
  let file = readfile(a:path)
  for line in file 
	if(line[0] == "#")
	  let key = line[1:]
	  let dictionary[key] = []
	else
	  call add(dictionary[key], line)
	endif
  endfor
  return dictionary
endfunction

"if the pattern contains a key from the dictionary or a key 
"contains the pattern, return the key
"else return an empty string
function! KeywordFrom(pattern)
  let idx = -1
  let keywords = keys(g:complete_dict)
  for word in keywords
	let match = max([stridx(a:pattern, word), stridx(word, a:pattern)])
	let idx+=1
	if(match != -1)
	  return keywords[idx]
	endif
  endfor  
  return ""
endfunction

"given a pattern, returns the list of possible complete options
"you have to define the global variable 'g:complete_dict' (a dictionary)
"it would be a good idea to define this variable for each different filetype
function! GetCompleteOptions(pattern)
  if !exists("g:complete_dict")
	echoerr "g:complete_dict not set!" 
	return []
  endif
  let key = KeywordFrom(a:pattern)
  if(key!="")
	return g:complete_dict[key]
  endif
  if(stridx(a:pattern, '.') != -1 && exists("g:complete_dict['dot']"))
	  return g:complete_dict["dot"]
  endif
  return []
endfunction

function! GetCompStart()
  normal b
  return col('.')-1
endfunction

"invoked by the combination <C-x><C-u>. You can remap this combination
"to <C-@> (i.e. CTRL+Space) to have something similar to other IDEs.
function! CompleteFunc(findstart, base)
  if(a:findstart == 1)
	return GetCompStart()
  endif
  if(a:findstart == 0)
	let completeoptions = GetCompleteOptions(a:base)
	if(completeoptions == [])
	  echo "nothing found"
	endif
	let retval = #{words: completeoptions, refresh: "always"}
	return retval
  endif
endfunction

set completefunc=CompleteFunc
