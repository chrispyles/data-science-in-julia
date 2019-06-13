---
interact_link: content/02-functions-control-flow/01-functions.ipynb
kernel_name: julia-1.1
title: 'Functions'
prev_page:
  url: /02-functions-control-flow/index
  title: 'Functions & Control Flow'
next_page:
  url: /03-builtins/index
  title: 'DataFrames in Julia'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Functions

In this section, we cover how to define and use functions in Julia. We also cover named arguments, default values, and functions with different argument types.

## Defining Functions

Functions have a very similar definition syntax. They start with the keyword `function` followed by the name and arguments, then the body, and finally the `end` keyword:

```julia
function name(args)
    # this is the function body
    # stuff gets done here
end
```

For example, if we wanted to define a function `double` which doubles its argument, we would do something like this:



{:.input_area}
```julia
function double(x)
    2*x
end

double(2)
```





{:.output .output_data_text}
```
4
```



### Implicit Returns

You may notice that in our definition of `double`, we didn't need to include a keyword such as `return` to tell Julia what the output is. Julia supports lazy typing, aspects of which you've seen already (e.g. defaulting to 64-bit numeric types), and as such it assumes that the last line executed is what you want returned if not keyword is included. If you so desire, you can include the `return` keyword and nothing will change:



{:.input_area}
```julia
function return_double(x)
    return 2*x
end

return_double(2)
```





{:.output .output_data_text}
```
4
```



For the sake of consistency and clarity of code, I will be using explicit returns in this textbook.
