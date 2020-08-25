# VimComFun
A simple complete function for vim. 

*VimComFun* (or VCF) stands for “Vim Complete Function”. This simple vim script
defines a complete function which is based on a dictionary to provide suggestions.
You can put everything inside your `.vimrc` file, or you can just `source` the script from there.

A complete function is a function which Vim uses to complete what is written by the user,
just like in an IDE.

A complete function:

+ Is invoked two times: the first time it returns the position of
the line where the completion should start (e.g. at the beginning of the line, or 
at the beginning of the previous word). The second time it returns
a list of words (these words are actually used to provide suggestions to the user).

+ Receives two arguments: `findstart` and `base`. The first time, `findstart`
is equal to 1, and `base` could be ignored. The second time, `findstart` is equal to 0
and `base` is equal to the word which should be completed.

## The dictionary

In this script, the complete function starts the completion
at the beginning of the current word and gets the suggestions from a dictionary.
You have to define this dictionary as a global variable named `g:complete_dict` in your `vimrc` file or 
somewhere else, otherwise you will get an error message.
It would be a good idea to have separate dictionaries for different languages.

Personally I really like this approach, though there's maybe a better way to do
it.

Each key in the dictionary is a “keyword” which has a list of suggestions
as value. If one of the keys contains the word which you're writing and you 
call the complete function, you get the corresponding list of suggestions.
For example, if you just wrote _“docum”_ and the dictionary has the keyword
_“document”_ inside of it, you will get all the suggestions which are associated
with the _“document”_ keyword.

You can remap the combination `<C-x><C-u>` (which is associated with the complete
function) to the combination `<C-@>` (i.e. CTRL+Space) to get something similar
to other IDEs:
  
  ``` 
  "this goes inside you .vimrc file
  ino <C-@> <C-x><C-u>
  ```
