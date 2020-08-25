"this is an example of how you can create a simple dictionary for the C language;
"if you type “print” and then you invoke the complete function, for example, you
"get “printf()”, “fprintf()” and “sprintf()” as suggestions.

let g:complete_dict = #{
	  \scan: ["scanf()", "fscanf()"],
	  \print: ["printf()", "fprintf()", "sprintf()"],
	  \fput: ["fputc()", "fputs()", "putchar()"],
	  \fget: ["fgetc()", "fgets()", "getchar()"],
	  \}

