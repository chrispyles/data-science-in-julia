---
interact_link: content/01-builtins/04-missing-data.ipynb
kernel_name: julia-1.1
title: 'Missing Data'
prev_page:
  url: /01-builtins/03-importing-exporting
  title: 'Importing and Exporting Data'
next_page:
  url: /solutions/index
  title: 'Exercise Solutions'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Missing Data

In Julia, missing data are represented as `missing` in DataFrames, and are of type Missing. 



{:.input_area}
```julia
typeof(missing)
```





{:.output .output_data_text}
```
Missing
```



Missing values propagate in calculations, and so including missing values in your data can cause you to end up with `missing` answers.



{:.input_area}
```julia
mean([1, 2, missing])
```





{:.output .output_data_text}
```
missing
```



## Skipping Missing Values

To skip missing values, you can create an interator using `skipmissing` that iterates over an array and yields only non-missing values.



{:.input_area}
```julia
vals = [1, 2, missing, 4, 5, missing, 7, 8, missing, 10]
not_missing = skipmissing(vals)
```





{:.output .output_data_text}
```
Base.SkipMissing{Array{Union{Missing, Int64},1}}(Union{Missing, Int64}[1, 2, missing, 4, 5, missing, 7, 8, missing, 10])
```





{:.input_area}
```julia
for x in not_missing
    print(x, " ")
end
```


{:.output .output_stream}
```
1 2 4 5 7 8 10 
```

The iterator can be collected into an array using the `collect` function, which iterates through an iterator and collects all of the values into an array. 

## Replacing Missing Values

To replace missing values, the `coalesce` function is useful. It is important to note that it applies to elements of arrays, not to arrays themselves, and so it must be used with dot notation if you want to broadcast it to an entire array.



{:.input_area}
```julia
coalesce.(vals, 0)
```





{:.output .output_data_text}
```
10-element Array{Int64,1}:
  1
  2
  0
  4
  5
  0
  7
  8
  0
 10
```


