---
interact_link: content/02-functions-control-flow/01-functions.ipynb
kernel_name: julia-1.1
title: 'Functions'
prev_page:
  url: /02-functions-control-flow/index
  title: 'Functions & Control Flow'
next_page:
  url: /02-functions-control-flow/02-conditionals
  title: 'Conditionals'
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



### Implicit and Explicit Returns

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

## Named Arguments and Default Values

In Julia, it is possible to have named arguments with default values. Keyword parameters are separated from non-keyword paremeters using a semicolon in the function definition, and their default values are set with the assignment operator `=`, as in many other languages.



{:.input_area}
```julia
function pow(base; exp=2)
    return base ^ exp
end

pow(2), pow(2, exp=3)
```





{:.output .output_data_text}
```
(4, 8)
```



When an argument is keyworded, Julia will not allow you to pass it positionally. This means that the call `pow(2, 3)` in the example above would result in an error.



{:.input_area}
```julia
pow(2, 3)
```


{:.output .output_traceback_line}
```

    MethodError: no method matching pow(::Int64, ::Int64)
    Closest candidates are:
      pow(::Any; exp) at In[23]:2

    

    Stacktrace:

     [1] top-level scope at In[24]:1


```

It is possible, although **not recommended**, to include keyworded arguments before or without a semicolon, which will allow them to retain their default value but have their arguments passed positionally also.



{:.input_area}
```julia
# NOT recommended
function pow(base, exp=2)
    return base ^ exp
end

pow(2, 3)
```





{:.output .output_data_text}
```
8
```



## Input Types

While Julia does not require it, it is possible to specify the input type of arguments when defining a function. This is useful for overriding functions for custom classes (called `struct`s in Julia) and for altering the behavior of a function depending upon its input.

Let's consider the case when we want to return an _integer_ doubled even when a different numeric type (e.g. a float) is passed as the argument. We would want to construct our function to accept both integers and floats, but behave differently when the input is an integer as opposed to a float. The type of an argument is specified in the function signature using the `::` syntax:

```julia
function my_func(arg_1::Type, arg_2::Type)
```

Continuing our `double` example from earlier, consider the following definitions of `int_double`:



{:.input_area}
```julia
function int_double(x::Int64)
    return 2*x
end

int_double(2)
```





{:.output .output_data_text}
```
4
```





{:.input_area}
```julia
function int_double(x::Float64)
    x = Int64(floor(x))
    return 2 * x
end

int_double(2.2)
```





{:.output .output_data_text}
```
4
```



In the second implementation of `int_double`, we convert our argument `x` to an integer. (Note that we call `floor` on `x` first; if we had not done this, we would have gotten an error from Julia because you can't convert floats to integers if the float has a nonzero fractional part.)

One thing to consider when you construct a function that specifies input types is that we get errors when calling the method on types that are not covered in the definitions.



{:.input_area}
```julia
int_double(Float32(2.2))
```


{:.output .output_traceback_line}
```

    MethodError: no method matching int_double(::Float32)
    Closest candidates are:
      int_double(!Matched::Float64) at In[7]:2
      int_double(!Matched::Int64) at In[1]:2

    

    Stacktrace:

     [1] top-level scope at In[9]:1


```

This happens because we have not defined an `int_double` function with the signature `int_double(::Float32)`. One way of alleviating a subset of these issues is to use unions of types, which are defined using `Union{}` syntax. Any type listed in the union will be accepted as a valid argument for that function.



{:.input_area}
```julia
function int_double(x::Union{Int64,Int32})
    return 2*x
end

function int_double(x::Union{Float64,Float32})
    x = Int(floor(x))
    return 2*x
end

int_double(Int32(2)), int_double(Float32(2.2))
```





{:.output .output_data_text}
```
(4, 4)
```



Another way to ensure that you don't run into errors is to provide a final method with no type specification that does something else with the input, or prints an error message.



{:.input_area}
```julia
function int_double(x)
    println("Argument is not a valid type.")
end

int_double("2"), int_double(Int8(2));
```


{:.output .output_stream}
```
Argument is not a valid type.
Argument is not a valid type.

```

Julia checks the functions with specified types before going to the generic, so our `int_double(2.2)` will still work.



{:.input_area}
```julia
int_double(2.2)
```





{:.output .output_data_text}
```
4
```



## Anonymous Functions

Finally, Julia provides a simple syntax for defining anonymous (lambda) functions:

```julia
(args) -> action
```

As an example, consider the `lambda_pow` implementation below, which is similar to the `pow` function defined above.



{:.input_area}
```julia
lambda_pow = (base, exp) -> base ^ exp

lambda_pow(2, 3)
```





{:.output .output_data_text}
```
8
```



## Exercises

**Exercise 2.1.1:** Define a function with the signature below that returns $ax^2 + bx + c$.

```julia
function quad(a, b, c, x)
```

**Exercise 2.1.2:** Define a higher order function `make_quad(a, b, c)` with the signature below that accepts `Int64`s as arguments and returns a function with the signature `f(x)` that returns $ax^2 + bx + c$.

**Exercise 2.1.3:** Create another function `make_quad(a, b, c)` as before that accepts 64-bit numeric types for all of its arguments (i.e. integers _and_ floats). Implicily return an anonymous function in this implementation.

**Exercise 2.1.4:** Finally, create a function `make_quad(a, b, c)` that prints the error `"Argument(s) not acceptable type."` if the arguments are not 64-bit numeric types.

 
