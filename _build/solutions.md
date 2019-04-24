---
interact_link: content/solutions.ipynb
kernel_name: julia-1.1
title: 'Exercise Solutions'
prev_page:
  url: /01-builtins/04-missing-data
  title: 'Missing Data'
next_page:
  url: 
  title: ''
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Exercise Solutions

This section contains solutions to the end-of-section exercises found in this book.

## Table of Contents

1. [DataFrames in Julia](#ch01)

<div id="ch01"></div>

### DataFrames in Julia

#### Section 1: DataFrames.jl

**Exercise 1.1.1:** Construct a DataFrame that encodes the following data table:

| Name | Year | Midterm Grade |
|-----|-----|-----|
| Jen | Sophomore | 93 |
| Neil | Junior | 88 |
| Lea | Junior | 86 |
| Richard | Sophomore | 75 |
| Penelope | Sophomore | 78 |

_Hint_: Remember that you can include underscores in symbols using the `:a_b` notation, or you can create a symbol from a string using `Symbol("A String")`.



{:.input_area}
```julia
# SOLUTION:
df_1_1_1 = DataFrame(
    Name = ["Jen", "Neil", "Lea", "Richard", "Penelope"],
    Year = ["Sophomore", "Junior", "Junior", "Sophomore", "Sophomore"],
    Midterm_Grade = [93, 88, 86, 75, 78]
)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Name</th><th>Year</th><th>Midterm_Grade</th></tr><tr><th></th><th>String</th><th>String</th><th>Int64</th></tr></thead><tbody><p>5 rows × 3 columns</p><tr><th>1</th><td>Jen</td><td>Sophomore</td><td>93</td></tr><tr><th>2</th><td>Neil</td><td>Junior</td><td>88</td></tr><tr><th>3</th><td>Lea</td><td>Junior</td><td>86</td></tr><tr><th>4</th><td>Richard</td><td>Sophomore</td><td>75</td></tr><tr><th>5</th><td>Penelope</td><td>Sophomore</td><td>78</td></tr></tbody></table>
</div>



**Exercise 1.1.2:** Create a `DataFrameRow` object that contains Lea's midterm information.



{:.input_area}
```julia
# SOLUTION:
df_1_1_1[3,:]
```





<div markdown="0" class="output output_html">
<p>DataFrameRow</p><table class="data-frame"><thead><tr><th></th><th>Name</th><th>Year</th><th>Midterm_Grade</th></tr><tr><th></th><th>String</th><th>String</th><th>Int64</th></tr></thead><tbody><p>1 rows × 3 columns</p><tr><th>3</th><td>Lea</td><td>Junior</td><td>86</td></tr></tbody></table>
</div>



**Exercise 1.1.3:** Using the function `Statistics.mean`, compute the mean of the midterm scores. Do not hardcode the answer, but use a function which accepts an array.



{:.input_area}
```julia
# SOLUTION:
# # if you need to, import statistics
# using Statistics

mean(df_1_1_1[:Midterm_Grade])
```





{:.output .output_data_text}
```
84.0
```



#### Section 2: Categortical Arrays

**Exercise 1.2.1:** Create a categorical array `arr` for the midterm grades data set from the last set of exericses.

| Name | Year | Midterm Grade |
|-----|-----|-----|
| Jen | Sophomore | 93 |
| Neil | Junior | 88 |
| Lea | Junior | 86 |
| Richard | Sophomore | 75 |
| Penelope | Sophomore | 78 |



{:.input_area}
```julia
# SOLUTION:
arr = CategoricalArray(df_1_1_1[:Year])
```





{:.output .output_data_text}
```
5-element CategoricalArray{String,1,UInt32}:
 "Sophomore"
 "Junior"   
 "Junior"   
 "Sophomore"
 "Sophomore"
```



**Exercise 1.2.2:** Add two `Freshman` individuals and three `Senior` individuals to the array (in that order). Recall that you can append arrays using the `append!` function.



{:.input_area}
```julia
# SOLUTION:
append!(arr, CategoricalArray(["Freshman", "Freshman", "Senior", "Senior", "Senior"]))
```





{:.output .output_data_text}
```
10-element CategoricalArray{String,1,UInt32}:
 "Sophomore"
 "Junior"   
 "Junior"   
 "Sophomore"
 "Sophomore"
 "Freshman" 
 "Freshman" 
 "Senior"   
 "Senior"   
 "Senior"   
```



**Exercise 1.2.3:** Order the levels of the array so that `Freshman` is less than `Sophomore` is less than `Junior` etc.



{:.input_area}
```julia
# SOLUTION:
levels!(arr, ["Freshman", "Sophomore", "Junior", "Senior"])
levels(arr)
```





{:.output .output_data_text}
```
4-element Array{String,1}:
 "Freshman" 
 "Sophomore"
 "Junior"   
 "Senior"   
```



**Exercise 1.2.4:** Test your ordering using `arr[3] > arr[1] == arr[4] > arr[6]`. (This should return `true`.)



{:.input_area}
```julia
# SOLUTION:
ordered!(arr, true)
arr[3] > arr[1] == arr[4] > arr[6]
```





{:.output .output_data_text}
```
true
```



#### Section 3: Importing and Exporting Data

**Exercise 1.3.1:** Write code to open the follow text file as a DataFrame. The assume the filename is `data.txt`.

```
Col_1|Col_2|Col_3
1|2|3
4|5|6
```

```julia
# SOLUTION:
CSV.read("data.txt", delim="|")
```

**Exercise 1.3.2:** How would you adapt the `load_json` function if the data in your JSON file as oriented as a dictionary of columns to arrays of values, e.g.

```
{ 
    "Col_1" : [1, 4],
    "Col_2" : [2, 5],
    "Col_3" : [3, 6]
}
```

```julia
# SOLUTION:
function load_json(path)
    dictarr = JSON.parsefile(path)
    df_dict = Dict()
    for col in keys(dictarr)
        df_dict[col] = dictarr[col]
    end
    return DataFrame(df_dict)
end
```

#### Section 4: Missing Data
