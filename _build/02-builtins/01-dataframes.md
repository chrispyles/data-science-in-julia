---
interact_link: content/02-builtins/01-dataframes.ipynb
kernel_name: julia-1.1
title: 'DataFrames.jl'
prev_page:
  url: /02-builtins/index
  title: 'DataFrames in Julia'
next_page:
  url: /02-builtins/02-categorical-arrays
  title: 'Categorical Arrays'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# DataFrames.jl

The most rudimentary implementation of labeled rectangular data in Julia comes from Julia's DataFrames.jl package. Similar to the relationship of the `data.frame` class to R, the DataFrames.jl package contains the default representation of labeled rectangular data in Julia, the DataFrame. DataFrames in Julia are very similar to R's `data.frame` in that the rows are indexed and the column labels are represented by symbols rather than strings, as in Python.

Unlike R, however, DataFrames.jl is not automatically included in the Julia distribution. It must be installed locally (see [Installing Dependencies]()) and then loaded in each notebook with the `using` command:



{:.input_area}
```julia
using DataFrames
```


## Constructing a `DataFrame`

To construct a DataFrame, the simplest method is to use the class constructor, `DataFrame`. A DataFrame represents column labels as symbols internally, so when we declare a DataFrame, we input the columns as keyword arguments and pass to these arrays of values, all of the same type. Let's say that we wanted to construct the following data set in Julia:

| Sex | Age |
|-----|-----|
| F | 19 |
| M | 18 |
| M | 20 |
| F | 22 |
| M | 25 |
| F | 23 |

We could apply the class constructor as follows:



{:.input_area}
```julia
DataFrame(
    Sex = ["F", "M", "M", "F", "M", "F"],
    Age = [19, 18, 20, 22, 25, 23]
)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sex</th><th>Age</th></tr><tr><th></th><th>String</th><th>Int64</th></tr></thead><tbody><p>6 rows × 2 columns</p><tr><th>1</th><td>F</td><td>19</td></tr><tr><th>2</th><td>M</td><td>18</td></tr><tr><th>3</th><td>M</td><td>20</td></tr><tr><th>4</th><td>F</td><td>22</td></tr><tr><th>5</th><td>M</td><td>25</td></tr><tr><th>6</th><td>F</td><td>23</td></tr></tbody></table>
</div>



As you can see, the data are constructed using the keyword arguments that we passed as labels. One interesting thing is that the rows are indexed, just as they are in, for example, `pandas` in Python. Also, note that the DataFrame shows us the type of each element in the column. For example, if we were isntead to declare the `Age` variable as `Int32`s, it would show show in the column header:



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



## Slicing DataFrames

The ability to extract data from columns and rows is very important, and DataFrames.jl includes some nice syntax for slicing a DataFrame. We can slice DataFrames as we do any other 2-dimensional representation in Julia (i.e. matrices), the same way as in R. DataFrames allow subsetting using bracket `[]` notation, and the basic subsetting of a DataFrame is accomplished using row and column indices:



{:.input_area}
```julia
# multiple rows and columns
df[4:-1:3, 2:-1:1]
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Age</th><th>Sex</th></tr><tr><th></th><th>Int32</th><th>String</th></tr></thead><tbody><p>2 rows × 2 columns</p><tr><th>1</th><td>22</td><td>F</td></tr><tr><th>2</th><td>20</td><td>M</td></tr></tbody></table>
</div>





{:.input_area}
```julia
# single column, multiple rows
df[1:2, 1]
```





{:.output .output_data_text}
```
2-element Array{String,1}:
 "F"
 "M"
```



As you can see, selecting multiple rows and columns in the slice returns a new DataFrame with the indices reset and selecting a single column returns an array of the values for that column in the selected rows. If you do not pass a tuple to the bracket (e.g. `df[2]`), it returns the column at that index. Finally, subsetting a DataFrame to select a single row returns a `DataFrameRow` object, which is acts similar to a 1-row DataFrame. The details of this type can be find by calling `?DataFrameRow` in Jupyter.



{:.input_area}
```julia
# single row, multiple columns
df[3,1:2]
```





<div markdown="0" class="output output_html">
<p>DataFrameRow</p><table class="data-frame"><thead><tr><th></th><th>Sex</th><th>Age</th></tr><tr><th></th><th>String</th><th>Int32</th></tr></thead><tbody><p>1 rows × 2 columns</p><tr><th>3</th><td>M</td><td>20</td></tr></tbody></table>
</div>



### Column Labels

In a DataFrame, the column labels are not represented as strings, as in so many other languages, but as [symbols](https://stackoverflow.com/questions/23480722/what-is-a-symbol-in-julia). This means that DataFrame columns can be accessed using labels in two ways: either through normal slicing with bracket notation, or by accessing them as an attribute of the `DataFrame` class. The bracket notation is as one would expect:



{:.input_area}
```julia
df[:Sex]
```





{:.output .output_data_text}
```
6-element Array{String,1}:
 "F"
 "M"
 "M"
 "F"
 "M"
 "F"
```



To access columns as class attributes, use the dot notation that Julia provides to access attributes of any class:



{:.input_area}
```julia
df.Sex
```





{:.output .output_data_text}
```
6-element Array{String,1}:
 "F"
 "M"
 "M"
 "F"
 "M"
 "F"
```



## Exercises

**Exercise 1.1.1:** Construct a DataFrame that encodes the following data table:

| Name | Year | Midterm Grade |
|-----|-----|-----|
| Jen | Sophomore | 93 |
| Neil | Junior | 88 |
| Lea | Junior | 86 |
| Richard | Sophomore | 75 |
| Penelope | Sophomore | 78 |

_Hint_: Remember that you can include underscores in symbols using the `:a_b` notation, or you can create a symbol from a string using `Symbol("A String")`.

**Exercise 1.1.2:** Create a `DataFrameRow` object that contains Lea's midterm information.

**Exercise 1.1.3:** Using the function `Statistics.mean`, compute the mean of the midterm scores. Do not hardcode the answer, but use a function which accepts an array.
