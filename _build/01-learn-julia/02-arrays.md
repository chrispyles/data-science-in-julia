---
interact_link: content/01-learn-julia/02-arrays.ipynb
kernel_name: julia-1.1
title: 'Arrays'
prev_page:
  url: /01-learn-julia/01-basics
  title: 'Numbers'
next_page:
  url: /02-builtins/index
  title: 'DataFrames in Julia'
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


