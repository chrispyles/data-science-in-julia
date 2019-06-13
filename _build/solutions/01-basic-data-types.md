---
interact_link: content/solutions/01-basic-data-types.ipynb
kernel_name: julia-1.1
title: '1. The Basic Data Types'
prev_page:
  url: /solutions/index
  title: 'Exercise Solutions'
next_page:
  url: /solutions/02-dataframes-in-julia
  title: '2. DataFrames in Julia'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Exercise Solutions: The Basic Data Types

This section contains solutions to the end-of-section exercises found in this book for the **Learn Julia** chapter.

<div id="s01"></div>

### 1.1 Numbers

**Exercise 1.1.1:** What are the type minimum and maximum for `Float64`?



{:.input_area}
```julia
# SOLUTION:
typemin(Float64), typemax(Float64)
```





{:.output .output_data_text}
```
(-Inf, Inf)
```



**Exercise 1.1.2:** Encode `true` as a Float64.



{:.input_area}
```julia
# SOLUTION:
Float64(true)
```





{:.output .output_data_text}
```
1.0
```



**Exercise 1.1.3:** Use Julia to calculate $\lfloor 10/3 \rfloor \mod 2$.



{:.input_area}
```julia
# SOLUTION:
(10 ÷ 3) % 2
```





{:.output .output_data_text}
```
1
```



**Exercise 1.1.4:** What is the output of the following logical expression (recommended that you don't use Julia):

```julia
(((true ⊻ (1 ≥ 2)) || (1 >= 1)) && (true && (1 != 2) && (2 ≠ 2))) ⊻ false
```



{:.input_area}
```julia
# SOLUTION:
(((true ⊻ (1 ≥ 2)) || (1 >= 1)) && (true && (1 != 2) && (2 ≠ 2))) ⊻ false
```





{:.output .output_data_text}
```
false
```



### 1.2 Arrays

**Exercise 1.2.1:** Create an array called `y` with values 2, 10, 3, 44, and 70 encoded as `Float32`s.



{:.input_area}
```julia
y = Float32[2, 10, 3, 44, 70]
```





{:.output .output_data_text}
```
5-element Array{Float32,1}:
  2.0
 10.0
  3.0
 44.0
 70.0
```



**Exercise 1.2.2:** Halve each element of `y`. Do not edit the original array.



{:.input_area}
```julia
y ./ 2
```





{:.output .output_data_text}
```
5-element Array{Float32,1}:
  1.0
  5.0
  1.5
 22.0
 35.0
```



**Exercise 1.2.3:** Reassign `y` to an array of boolean values indicating whether or not each element is greater than or equal to 43.



{:.input_area}
```julia
y = y .≥ 43
```





{:.output .output_data_text}
```
5-element BitArray{1}:
 false
 false
 false
  true
  true
```



**Exercise 1.2.4:** Copy the anonymous function definition below and run it.

```julia
not = x -> !(x)
```

Use this function to negate the values in `y`.



{:.input_area}
```julia
not = x -> !(x)
not.(y)
```





{:.output .output_data_text}
```
5-element BitArray{1}:
  true
  true
  true
 false
 false
```


