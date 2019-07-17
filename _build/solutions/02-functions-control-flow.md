---
interact_link: content/solutions/02-functions-control-flow.ipynb
kernel_name: julia-1.1
title: '2. Functions & Control Flow'
prev_page:
  url: /solutions/01-basic-data-types
  title: '1. The Basic Data Types'
next_page:
  url: /solutions/03-dataframes-in-julia
  title: '3. DataFrames in Julia'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Exercise Solutions: Functions and Control Flow

This section contains solutions to the end-of-section exercises found in this book for the **Functions and Control Flow** chapter.

### 2.1 Functions

**Exercise 2.1.1:** Define a function with the signature below that returns $ax^2 + bx + c$.

```julia
function quad(a, b, c, x)
```



{:.input_area}
```julia
function quad(a, b, c, x)
    return a*x^2 + b*x + c
end
```





{:.output .output_data_text}
```
quad (generic function with 1 method)
```



**Exercise 2.1.2:** Define a higher order function `make_quad(a, b, c)` with the signature below that accepts `Int64`s as arguments and returns a function with the signature `f(x)` that returns $ax^2 + bx + c$.



{:.input_area}
```julia
function make_quad(a::Int64, b::Int64, c::Int64)
    function my_quad(x)
        return a*x^2 + b*x + c
    end
    return my_quad
end
```





{:.output .output_data_text}
```
make_quad (generic function with 1 method)
```



**Exercise 2.1.3:** Create another function `make_quad(a, b, c)` as before that accepts 64-bit numeric types for all of its arguments (i.e. integers _and_ floats). Implicily return an anonymous function in this implementation.



{:.input_area}
```julia
function make_quad(a::Union{Int64,Float64}, b::Union{Int64,Float64}, c::Union{Int64,Float64})
    (x) -> a*x^2 + b*x + c
end
```





{:.output .output_data_text}
```
make_quad (generic function with 2 methods)
```



**Exercise 2.1.4:** Finally, create a function `make_quad(a, b, c)` that prints the error `"Argument(s) not acceptable type."` if the arguments are not 64-bit numeric types.



{:.input_area}
```julia
function make_quad(a, b, c)
    println("Argument(s) not acceptable type.")
end
```





{:.output .output_data_text}
```
make_quad (generic function with 3 methods)
```



### 2.2 Conditionals

**Exercise 2.2.1:** Write a function `print_name(name::String)` which prints out the name `name` only if it's length is greater than 0. If the length is 0, it should print out `"Name string is empty."`.

_Hint:_ You can use `length(s)` to get the length of a string `s`.



{:.input_area}
```julia
function print_name(name::String)
    if length(name) == 0
        println("Name string is empty.")
    else
        println(name)
    end
end

print_name(""); print_name("John")
```


{:.output .output_stream}
```
Name string is empty.
John

```

**Exercise 2.2.2:** Following each line below, write the value of `x`.



{:.input_area}
```julia
x = 1 < 2 ? 0 : 1;           println(x)
x = x > -1 ? 2 : 0;          println(x)
x = true && false ? 3 : 5;   println(x)
x = x == 5 ? 2 : -1;         println(x)
x = x < 0 ? -1 : 4;          println(x)
```


{:.output .output_stream}
```
0
2
5
2
4

```

**Exercise 2.2.3:** For each line below, determine whether or not the line will error in evaluation. If a line errors, assume it is not executed. Assume that `A = true`, `B = false`, and `C = true` have already been set.

```julia
A && B                     # Error? No
A && D                     # Error? Yes
A || C                     # Error? No
B && E                     # Error? No
C || D                     # Error? No
C && (A || B)              # Error? No
B && (A || D)              # Error? No
A && (C && D)              # Error? Yes
B ⊻ D                      # Error? Yes
```

### 2.3 Control Flow

**Exercise 2.3.1:** Create a while loop that prints all of the letters in the phrase "data science is fun" but which are not in the word "string".

_Hint:_ Create an array of the letters and iterate through the index. You can check if a substring occurs in a larger string using `occursin(substring, big_string)`.



{:.input_area}
```julia
# faster way of splitting up the letters into an array
letters = split("data science is fun", "")

for l in letters
    if occursin(l, "string")
        continue
    end
    print(l * " ") # the space is not necessary
end
```


{:.output .output_stream}
```
d a a   c e c e     f u 
```

**Exercise 2.3.2:** Write a for loop to print out all multiples of 3 from 0 to 100 that are not odd. The loop should stop when it hits upon a multiple of 31 **that is not 0**.



{:.input_area}
```julia
for i in 0:3:100
    print(string(i) * " ")
    if (i % 31 == 0) && (i != 0)
        break
    end
end
```


{:.output .output_stream}
```
0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 
```

**Exercise 2.3.3:** Write a function `cosines(start, stop)` that returns an array of the cosine of each number in the range `start:stop`. Use a for loop to add items to the array.



{:.input_area}
```julia
function cosines(start, stop)
    arr = []
    for i in start:stop
        push!(arr, cos(i))
    end
    return arr
end

cosines(1, 10)
```





{:.output .output_data_text}
```
10-element Array{Any,1}:
  0.5403023058681398 
 -0.4161468365471424 
 -0.9899924966004454 
 -0.6536436208636119 
  0.28366218546322625
  0.960170286650366  
  0.7539022543433046 
 -0.14550003380861354
 -0.9111302618846769 
 -0.8390715290764524 
```



**Exercise 2.3.4:** Rewrite your `cosines` implementation to allow for a different step size. In this implementation using dot syntax to broadcast the cosine function to each element of the range.



{:.input_area}
```julia
function cosines(start, stop, step)
    arr = start:step:stop
    return cos.(arr)
end

cosines(1, 10, 2)
```





{:.output .output_data_text}
```
5-element Array{Float64,1}:
  0.5403023058681398 
 -0.9899924966004454 
  0.28366218546322625
  0.7539022543433046 
 -0.9111302618846769 
```



 
