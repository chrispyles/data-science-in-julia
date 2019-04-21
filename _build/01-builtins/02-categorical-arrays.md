---
interact_link: content/01-builtins/02-categorical-arrays.ipynb
kernel_name: julia-1.1
title: 'Categorical Arrays'
prev_page:
  url: /01-builtins/01-dataframes
  title: 'DataFrames.jl'
next_page:
  url: /01-builtins/03-importing-exporting
  title: 'Importing and Exporting Data'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Categorical Arrays

Many of the data sets you will come across will have columns that encode categorical data; that is, data that have a specific number of possible outcomes. These data can be hard to work with, but luckily Julia has a package that contains an abstraction for arrays of categorical data; the is called, funnily enough, CategoricalArrays.jl. To begin, we load in both this package and DataFrames.jl.



{:.input_area}
```julia
using CategoricalArrays, DataFrames
```


## Constructing a `CategoricalArray`

Consider the array of individuals below, with possible groups `A`, `B`, or `C`:



{:.input_area}
```julia
individuals = ["A", "C", "B", "B", "C", "C", "B", "A", "A", "A", "C", "B"];
```


(The semicolon is used to suppress output.) We have now a categorical variable, and we want to utilize a data abstraction that will represent this array in a way that allows us to better make use of it. The `CategoricalArray` constructor will determine the unique groups in an array and return a `CategoricalArray` object that stores both the unique groups and the original array. The elements of the original array are stored as `CategoricalString` or `CategoricalValue`, depending on whether or not the variable takes on string or numerical values.



{:.input_area}
```julia
ca = CategoricalArray(individuals)
```





{:.output .output_data_text}
```
12-element CategoricalArray{String,1,UInt32}:
 "A"
 "C"
 "B"
 "B"
 "C"
 "C"
 "B"
 "A"
 "A"
 "A"
 "C"
 "B"
```



### Levels and Ordering

We can see the unique values in the `CategoricalArray` using the `levels` function:



{:.input_area}
```julia
levels(ca)
```





{:.output .output_data_text}
```
3-element Array{String,1}:
 "A"
 "B"
 "C"
```



These levels default to an ascending order; we can mutate the object to change the order of the levels using the `levels!` function.



{:.input_area}
```julia
levels!(ca, ["B", "A", "C"])
levels(ca)
```





{:.output .output_data_text}
```
3-element Array{String,1}:
 "B"
 "A"
 "C"
```



This behavior allows comparison operators to be used on elements of a `CategoricalArray`, as long as they were constructed with the argument `ordered = true`. To achieve, this, we can reconstruct the `CategoricalArray` from individuals with ordering and reapply our `levels!` call.



{:.input_area}
```julia
ordered_ca = CategoricalArray(individuals, ordered=true)
println("Individual 1: $(ordered_ca[1])\t\tIndividual 2: $(ordered_ca[3])")
println("Indivual 1 < Individual 2: $(ordered_ca[1] < ordered_ca[3])")
println("Changing level order...")
levels!(ordered_ca, ["B", "A", "C"])
println("Indivual 1 < Individual 2: $(ordered_ca[1] < ordered_ca[3])")
```


{:.output .output_stream}
```
Individual 1: A		Individual 2: B
Indivual 1 < Individual 2: true
Changing level order...
Indivual 1 < Individual 2: false

```

The level order we implemented changed whether or not an individual of class `A` was less than one of class `B`. We can test whether or not a `CategoricalArray` is ordered using the `isordered` function, and we can change this using the `ordered!` function.



{:.input_area}
```julia
isordered(ca), isordered(ordered_ca)
```





{:.output .output_data_text}
```
(false, true)
```





{:.input_area}
```julia
ordered!(ca, true)
isordered(ca)
```





{:.output .output_data_text}
```
true
```





{:.input_area}
```julia
ordered!(ca, false)
isordered(ca)
```





{:.output .output_data_text}
```
false
```



## Mutating a `CategoricalArray`

The `CategorialArray` is mutable, so we can set a mapping to change the elements of a `CategoricalArray` to some predefined new value. For example, let's say that all individuals of type `A` in our sample suddenly became type `D`, we would employ the `recode` (inplace: `recode!`) function to change these values using a mapper.



{:.input_area}
```julia
recoded_ca = recode(ordered_ca, "A" => "D")
ordered!(recoded_ca, true)
```





{:.output .output_data_text}
```
12-element CategoricalArray{String,1,UInt32}:
 "D"
 "C"
 "B"
 "B"
 "C"
 "C"
 "B"
 "D"
 "D"
 "D"
 "C"
 "B"
```



As a sanity check, let's make sure that our original levels were inherited:



{:.input_area}
```julia
println("Individual 1: $(recoded_ca[1])\t\tIndividual 2: $(recoded_ca[3])")
println("Indivual 1 < Individual 2: $(recoded_ca[1] < recoded_ca[3])")
```


{:.output .output_stream}
```
Individual 1: D		Individual 2: B
Indivual 1 < Individual 2: false

```

By default, the `CategoricalArray` class can hold up to $2^{32}$ categories, which takes up a lot of memory. Because allocating memory efficiently is one of the keystones of Julia, the package provides a function to free up memory not being used by the available categories; this function is `compress`.



{:.input_area}
```julia
ca = compress(ca)
```





{:.output .output_data_text}
```
12-element CategoricalArray{String,1,UInt8}:
 "A"
 "C"
 "B"
 "B"
 "C"
 "C"
 "B"
 "A"
 "A"
 "A"
 "C"
 "B"
```



You can also add elements to a `CategoricalArray` of a new type by pushing elements as you would any other array. For example, if we wanted to add an individual of type `E` to our data set, we would push this individual to the array and then check the levels, with any reordering necessary.



{:.input_area}
```julia
push!(ca, "E")
```





{:.output .output_data_text}
```
13-element CategoricalArray{String,1,UInt8}:
 "A"
 "C"
 "B"
 "B"
 "C"
 "C"
 "B"
 "A"
 "A"
 "A"
 "C"
 "B"
 "E"
```





{:.input_area}
```julia
levels(ca)
```





{:.output .output_data_text}
```
4-element Array{String,1}:
 "B"
 "A"
 "C"
 "E"
```



## Categorical Data in DataFrames

Columns of DataFrames are represented internally as arrays, but the `DataFrame` type supports using `CategoricalArray` as columns as well. Recall our simple data set from the last section:



{:.input_area}
```julia
df = DataFrame(
    Sex = ["F", "M", "M", "F", "M", "F"],
    Age = Int32[19, 18, 20, 22, 25, 23]
)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sex</th><th>Age</th></tr><tr><th></th><th>String</th><th>Int32</th></tr></thead><tbody><p>6 rows × 2 columns</p><tr><th>1</th><td>F</td><td>19</td></tr><tr><th>2</th><td>M</td><td>18</td></tr><tr><th>3</th><td>M</td><td>20</td></tr><tr><th>4</th><td>F</td><td>22</td></tr><tr><th>5</th><td>M</td><td>25</td></tr><tr><th>6</th><td>F</td><td>23</td></tr></tbody></table>
</div>



The sex column is encoding a categorical variable which takes on values `F` or `M`. To encode this column as a `CategoricalArray`, we apply the `categorical!` function to the DataFrame and column.



{:.input_area}
```julia
categorical!(df, :Sex)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sex</th><th>Age</th></tr><tr><th></th><th>Categorical…</th><th>Int32</th></tr></thead><tbody><p>6 rows × 2 columns</p><tr><th>1</th><td>F</td><td>19</td></tr><tr><th>2</th><td>M</td><td>18</td></tr><tr><th>3</th><td>M</td><td>20</td></tr><tr><th>4</th><td>F</td><td>22</td></tr><tr><th>5</th><td>M</td><td>25</td></tr><tr><th>6</th><td>F</td><td>23</td></tr></tbody></table>
</div>



As you can see, the type of the `Sex` column has changed from `String` to `CategoricalString`, another data abstraction from CategoricalArrays.jl.



{:.input_area}
```julia
eltype(df.Sex)
```





{:.output .output_data_text}
```
CategoricalString{UInt32}
```



If you don't pass a column label to `categorical!`, it converts each column to a `CategoricalArray!`.

<!-- conclude -->

## Exercises

**Exercise 1.2.1:** Create a categorical array `arr` for the midterm grades data set from the last set of exericses.

| Name | Year | Midterm Grade |
|-----|-----|-----|
| Jen | Sophomore | 93 |
| Neil | Junior | 88 |
| Lea | Junior | 86 |
| Richard | Sophomore | 75 |
| Penelope | Sophomore | 78 |

**Exercise 1.2.2:** Add two `Freshman` individuals and three `Senior` individuals to the array (in that order). Recall that you can append arrays using the `append!` function.

**Exercise 1.2.3:** Order the levels of the array so that `Freshman` is less than `Sophomore` is less than `Junior` etc.

**Exercise 1.2.4:** Test your ordering using `arr[3] > arr[1] == arr[4] > arr[6]`. (This should return `true`.)
