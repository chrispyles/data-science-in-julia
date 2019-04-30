---
interact_link: content/02-builtins/04-missing-data.ipynb
kernel_name: julia-1.1
title: 'Missing Data'
prev_page:
  url: /02-builtins/03-importing-exporting
  title: 'Importing and Exporting Data'
next_page:
  url: /solutions/index
  title: 'Exercise Solutions'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Missing Data

In Julia, missing data are represented as `missing` in DataFrames, and are of type Missing. To access the methods of missing values, we need to import the Missings.jl package.



{:.input_area}
```julia
using Missings
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



## Missing as a Data Type

In Julia, as in many other languages, there is an abstract data type to represent missing values: `Missing`. Like any other data type, this means that values of type Missing have methods and attributes that control how they can be worked with. As noted above, missing values propagate, and so it is important to understand how Missing works as an abstract data type in order to understand how we can work with these data in conjunction with DataFrames.

### Propagation of Missing Values

It is important to understand _how_ missing vaules propagate so we know when we need to change missing values in order to get a desired output. Numerical functions, operations, and comparison operators all propagate missing values:



{:.input_area}
```julia
sin(missing), 1 / missing, missing == missing, 1 != missing
```





{:.output .output_data_text}
```
(missing, missing, missing, missing)
```



We can test whether or not a value is missing using the `ismissing` function.



{:.input_area}
```julia
ismissing(missing), ismissing(1)
```





{:.output .output_data_text}
```
(true, false)
```



Logical operators return `missing` only when the result cannot be determined without the missing data. This means that a comparison like `true & missing` returns `missing`, but `true | missing` returns `true`.



{:.input_area}
```julia
# should return (missing, true, missing, false, missing, missing)
true & missing, true | missing, true ⊻ missing, false & missing, false | missing, false ⊻ missing
```





{:.output .output_data_text}
```
(missing, true, missing, false, missing, missing)
```



### Skipping Missing Values

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

### Replacing Missing Values

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



## Missing Values in DataFrames

DataFrames.jl includes some support for dealing with missing values that are more difficult to implement using the standard functions from Missings.jl. For example, it provides the `dropmissing` and `dropmissing!` functions, which drop rows with missing values in a copy and inplace, respectively.

Recall our `iris` data set:



{:.input_area}
```julia
iris = CSV.read("data/iris.csv")
first(iris, 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sepal.Length</th><th>Sepal.Width</th><th>Petal.Length</th><th>Petal.Width</th><th>Species</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>String⍰</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>5.1</td><td>3.5</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>2</th><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>3</th><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr><tr><th>4</th><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr><tr><th>5</th><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr></tbody></table>
</div>



If we were to set the first value of sepal length to `missing`, we could drop that row using `dropmissing`.



{:.input_area}
```julia
iris_missing = copy(iris)
iris_missing[1,Symbol("Sepal.Length")] = missing
first(iris_missing, 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sepal.Length</th><th>Sepal.Width</th><th>Petal.Length</th><th>Petal.Width</th><th>Species</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>String⍰</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>missing</td><td>3.5</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>2</th><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>3</th><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr><tr><th>4</th><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr><tr><th>5</th><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr></tbody></table>
</div>





{:.input_area}
```julia
first(dropmissing(iris), 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sepal.Length</th><th>Sepal.Width</th><th>Petal.Length</th><th>Petal.Width</th><th>Species</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>String⍰</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>2</th><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr><tr><th>3</th><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr><tr><th>4</th><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>5</th><td>5.4</td><td>3.9</td><td>1.7</td><td>0.4</td><td>setosa</td></tr></tbody></table>
</div>



As you can see, we lost the first row of the DataFrame because we set the value to `missing`.

If you're only concerned about specific columns, you can specify which columns to drop.

## Exercises

**Exercise 1.4.1:** 
