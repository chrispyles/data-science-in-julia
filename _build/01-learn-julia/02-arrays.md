---
interact_link: content/01-learn-julia/02-arrays.ipynb
kernel_name: julia-1.1
title: 'Arrays'
prev_page:
  url: /01-learn-julia/01-basics
  title: 'Numbers'
next_page:
  url: /02-functions-control-flow/index
  title: 'Functions & Control Flow'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Arrays

Julia, as with many other languages, provides arrays to store elements of different or similar types. Arrays are mutable, meaning that an array object can be changed by calling functions on it, even without storing the results using a variable assignment. To create an array, you list the elements between brackets



{:.input_area}
```julia
x = [1, 2, 3]
```





{:.output .output_data_text}
```
3-element Array{Int64,1}:
 1
 2
 3
```



To create an array with a specific data type, you can write the name of that type before the opening bracket:



{:.input_area}
```julia
y = Float32[1, 2, 3]
```





{:.output .output_data_text}
```
3-element Array{Float32,1}:
 1.0
 2.0
 3.0
```



## Indexing Arrays

Julia is a 1-indexed language, meaning that all indices begin at 1 and all ranges include both the lower and upper ends. You can slice an array using backet notation, and you can subset an array by passing an array of indices to the slice.



{:.input_area}
```julia
x[1]
```





{:.output .output_data_text}
```
1
```





{:.input_area}
```julia
x[[3, 2]]
```





{:.output .output_data_text}
```
2-element Array{Int64,1}:
 3
 2
```



## Mutating Arrays

Arrays in Julia are mutable. You can add elements to the end of an array using the `push!` function. (Note the `!`; it is customary in Julia to append a `!` to the end of names of functions which mutate their arguments.)



{:.input_area}
```julia
push!(x, 4)
```





{:.output .output_data_text}
```
4-element Array{Int64,1}:
 1
 2
 3
 4
```



You can also append two arrays using `append!`.



{:.input_area}
```julia
append!(x, [5, 6])
```





{:.output .output_data_text}
```
6-element Array{Int64,1}:
 1
 2
 3
 4
 5
 6
```



### Element-wise Operations

To perform operations by element in an array, Julia provides the dot syntax. Using dot syntax, you can broadcast an operation to an entire array without having to use iteration to work with each element in sequence. For example, to add 2 to each element of `x`, the dot syntax would be:



{:.input_area}
```julia
x .+ 2
```





{:.output .output_data_text}
```
6-element Array{Int64,1}:
 3
 4
 5
 6
 7
 8
```



You can also use the binary assignment operators and logical operators with dot syntax:



{:.input_area}
```julia
x .+= 2
```





{:.output .output_data_text}
```
6-element Array{Int64,1}:
 3
 4
 5
 6
 7
 8
```





{:.input_area}
```julia
x .== 6
```





{:.output .output_data_text}
```
6-element BitArray{1}:
 false
 false
 false
  true
 false
 false
```



The values stored in `x` should all now be the same as they are shown above:



{:.input_area}
```julia
x
```





{:.output .output_data_text}
```
6-element Array{Int64,1}:
 3
 4
 5
 6
 7
 8
```



Dot syntax can also be used to broadcast functions:



{:.input_area}
```julia
# double is a function that doubles its argument
double.(x)
```





{:.output .output_data_text}
```
6-element Array{Int64,1}:
  6
  8
 10
 12
 14
 16
```



## Exercises

**Exercise 1.2.1:** Create an array called `y` with values 2, 10, 3, 44, and 70 encoded as `Float32`s.

**Exercise 1.2.2:** Halve each element of `y`. Do not edit the original array.

**Exercise 1.2.3:** Reassign `y` to an array of boolean values indicating whether or not each element is greater than or equal to 43.

**Exercise 1.2.4:** Copy the anonymous function definition below and run it.

```julia
not = x -> !(x)
```

Use this function to negate the values in `y`.

 
