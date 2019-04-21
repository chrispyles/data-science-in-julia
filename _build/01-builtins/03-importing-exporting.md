---
interact_link: content/01-builtins/03-importing-exporting.ipynb
kernel_name: julia-1.1
title: 'Importing and Exporting Data'
prev_page:
  url: /01-builtins/02-categorical-arrays
  title: 'Categorical Arrays'
next_page:
  url: 
  title: ''
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Import and Exporting Data

It is common practice to import data from external files so that the DataFrames do not need to be hardcoded. Julia provides the CSV.jl package to handle reading and writing CSV files; it is also easily integrated with DataFrames.jl.

_A quick note about the data:_ The data in this section is exported from a pre-loaded data set in R with information about different Iris species. The data original comes from [UCI](https://archive.ics.uci.edu/ml/datasets/Iris).



{:.input_area}
```julia
using CSV, DataFrames
```


## CSV Files

### Reading Data

The easiest way to load a CSV file is to call `CSV.read()` on a string containing the relative file path, as with any other language. This function reads the file and outputs a `DataFrame` object with the data from that file.



{:.input_area}
```julia
iris = CSV.read("data/iris.csv")
first(iris, 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sepal.Length</th><th>Sepal.Width</th><th>Petal.Length</th><th>Petal.Width</th><th>Species</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>String⍰</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>5.1</td><td>3.5</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>2</th><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>3</th><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr><tr><th>4</th><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr><tr><th>5</th><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr></tbody></table>
</div>



We apply the `first` function so that the cell only outputs the first 5 rows of the DataFrame. Some files, TSV for example, are similar to CSV files but use different delimeters. To load these into Julia, you can set the `delim` argument to a String containing the separator for that file. An example for a TSV file is given below.



{:.input_area}
```julia
iris_tsv = CSV.read("data/iris.tsv", delim="\t")
first(iris_tsv, 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Sepal.Length</th><th>Sepal.Width</th><th>Petal.Length</th><th>Petal.Width</th><th>Species</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>String⍰</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>5.1</td><td>3.5</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>2</th><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr><tr><th>3</th><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr><tr><th>4</th><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr><tr><th>5</th><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr></tbody></table>
</div>



It is import for this function that you append the package name `CSV` to the beginning as the Julia base package includes a `read` function that performs a different function. Other helpful keyword arguments for `CSV.read` are:

| Argument | Default | Description |
|-----|-----|-----|
| `header` | `1` | Row index in file which contains column headers |
| `missingstrings`, `missingstring` | `""` | String or vector of strings to parse as `missing` when loading the DataFrame |
| `delim` | `","` | Value delimiter in each row |
| `truestrings`, `falsestrings` | `nothing` | Vector of strings containing values to parse as `true` and `false`, respectively |
| `types` | `nothing` | Vector or Dict of types to use for columns |
| `categorical` | `false` | Bool to indicate whether or not String columns should be parsed into `CategoricalArray` |

The `missingstrings` and `missingstring` arguments have to do with values that are `missing` in the data set; this is a topic that will be covered in a later section.

### Exporting Data

To export a DataFrame, CSV.jl provides `CSV.write`. As with `CSV.read`, appending the `CSV` is important here, as the base package includes a `write` method as well. To write a DataFrame, pass it to `CSV.write` with a filepath as the first argument:



{:.input_area}
```julia
CSV.write("export/iris-export.csv", iris)
```





{:.output .output_data_text}
```
"iris-export.csv"
```



`CSV.write` includes many of the same optional arguments as `CSV.read`; the main ones to consider are `delim`, `missingstring`, and `header`, the last of which allows you to overwrite the column headings in the DataFrame object that you passed to the function. 

## JSON Files

### Reading Data

Julia provides the JSON.jl package to parse strings formatted as JSON files. To load a JSON file using JSON.jl, the best way is to pass a filepath to `JSON.parsefile`.



{:.input_area}
```julia
using JSON
```




{:.input_area}
```julia
parsed_iris = JSON.parsefile("data/iris.json")
```





{:.output .output_data_text}
```
150-element Array{Any,1}:
 Dict{String,Any}("Sepal.Width"=>3.5,"Petal.Length"=>1.4,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>5.1)   
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>1.4,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>4.9)     
 Dict{String,Any}("Sepal.Width"=>3.2,"Petal.Length"=>1.3,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>4.7)   
 Dict{String,Any}("Sepal.Width"=>3.1,"Petal.Length"=>1.5,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>4.6)   
 Dict{String,Any}("Sepal.Width"=>3.6,"Petal.Length"=>1.4,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>5)     
 Dict{String,Any}("Sepal.Width"=>3.9,"Petal.Length"=>1.7,"Petal.Width"=>0.4,"Species"=>"setosa","Sepal.Length"=>5.4)   
 Dict{String,Any}("Sepal.Width"=>3.4,"Petal.Length"=>1.4,"Petal.Width"=>0.3,"Species"=>"setosa","Sepal.Length"=>4.6)   
 Dict{String,Any}("Sepal.Width"=>3.4,"Petal.Length"=>1.5,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>5)     
 Dict{String,Any}("Sepal.Width"=>2.9,"Petal.Length"=>1.4,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>4.4)   
 Dict{String,Any}("Sepal.Width"=>3.1,"Petal.Length"=>1.5,"Petal.Width"=>0.1,"Species"=>"setosa","Sepal.Length"=>4.9)   
 Dict{String,Any}("Sepal.Width"=>3.7,"Petal.Length"=>1.5,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>5.4)   
 Dict{String,Any}("Sepal.Width"=>3.4,"Petal.Length"=>1.6,"Petal.Width"=>0.2,"Species"=>"setosa","Sepal.Length"=>4.8)   
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>1.4,"Petal.Width"=>0.1,"Species"=>"setosa","Sepal.Length"=>4.8)     
 ⋮                                                                                                                     
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>4.8,"Petal.Width"=>1.8,"Species"=>"virginica","Sepal.Length"=>6)    
 Dict{String,Any}("Sepal.Width"=>3.1,"Petal.Length"=>5.4,"Petal.Width"=>2.1,"Species"=>"virginica","Sepal.Length"=>6.9)
 Dict{String,Any}("Sepal.Width"=>3.1,"Petal.Length"=>5.6,"Petal.Width"=>2.4,"Species"=>"virginica","Sepal.Length"=>6.7)
 Dict{String,Any}("Sepal.Width"=>3.1,"Petal.Length"=>5.1,"Petal.Width"=>2.3,"Species"=>"virginica","Sepal.Length"=>6.9)
 Dict{String,Any}("Sepal.Width"=>2.7,"Petal.Length"=>5.1,"Petal.Width"=>1.9,"Species"=>"virginica","Sepal.Length"=>5.8)
 Dict{String,Any}("Sepal.Width"=>3.2,"Petal.Length"=>5.9,"Petal.Width"=>2.3,"Species"=>"virginica","Sepal.Length"=>6.8)
 Dict{String,Any}("Sepal.Width"=>3.3,"Petal.Length"=>5.7,"Petal.Width"=>2.5,"Species"=>"virginica","Sepal.Length"=>6.7)
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>5.2,"Petal.Width"=>2.3,"Species"=>"virginica","Sepal.Length"=>6.7)  
 Dict{String,Any}("Sepal.Width"=>2.5,"Petal.Length"=>5,"Petal.Width"=>1.9,"Species"=>"virginica","Sepal.Length"=>6.3)  
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>5.2,"Petal.Width"=>2,"Species"=>"virginica","Sepal.Length"=>6.5)    
 Dict{String,Any}("Sepal.Width"=>3.4,"Petal.Length"=>5.4,"Petal.Width"=>2.3,"Species"=>"virginica","Sepal.Length"=>6.2)
 Dict{String,Any}("Sepal.Width"=>3,"Petal.Length"=>5.1,"Petal.Width"=>1.8,"Species"=>"virginica","Sepal.Length"=>5.9)  
```



Sadly, there isn't yet an package which has a pipeline to get from an array of Dicts to a DataFrame, so we need to build our own function. The function defined below will take in a filepath and read in the JSON file and then use a Dict and array comprehensions to create a DataFrame.



{:.input_area}
```julia
function load_json(path)
    dictarr = JSON.parsefile(path)
    df_dict = Dict()
    for col in keys(dictarr[1])
        df_dict[col] = [row[col] for row in dictarr]
    end
    return DataFrame(df_dict)
end

iris_json = load_json("data/iris.json")
first(iris_json, 5)
```





<div markdown="0" class="output output_html">
<table class="data-frame"><thead><tr><th></th><th>Petal.Length</th><th>Petal.Width</th><th>Sepal.Length</th><th>Sepal.Width</th><th>Species</th></tr><tr><th></th><th>Real</th><th>Real</th><th>Real</th><th>Real</th><th>String</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>1.4</td><td>0.2</td><td>5.1</td><td>3.5</td><td>setosa</td></tr><tr><th>2</th><td>1.4</td><td>0.2</td><td>4.9</td><td>3</td><td>setosa</td></tr><tr><th>3</th><td>1.3</td><td>0.2</td><td>4.7</td><td>3.2</td><td>setosa</td></tr><tr><th>4</th><td>1.5</td><td>0.2</td><td>4.6</td><td>3.1</td><td>setosa</td></tr><tr><th>5</th><td>1.4</td><td>0.2</td><td>5</td><td>3.6</td><td>setosa</td></tr></tbody></table>
</div>



As you can see, our algorithm is farily simple. We simple load the array of Dicts, create a new, empty Dict, and then iterate through the columns (encoded as the keys of each Dict) and use an array comprehension to extract the values for that column from each row. We then pass this new Dict to `DataFrame`, which constructs the DataFrame that we want.

### Writing Data

To write a JSON file, you need to load a Dict into `JSON.json` and write the string that is returned to a file.



{:.input_area}
```julia
function to_array(df)
    arr = []
    for row in 1:size(df, 1)
        push!(arr, Dict((col => df[row, col] for col in names(df))))
    end
    return arr
end

to_array(iris_json)
```





{:.output .output_data_text}
```
150-element Array{Any,1}:
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>3.5,Symbol("Sepal.Length")=>5.1,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>4.9,Symbol("Petal.Width")=>0.2,:Species=>"setosa")     
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.3,Symbol("Sepal.Width")=>3.2,Symbol("Sepal.Length")=>4.7,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.5,Symbol("Sepal.Width")=>3.1,Symbol("Sepal.Length")=>4.6,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>3.6,Symbol("Sepal.Length")=>5,Symbol("Petal.Width")=>0.2,:Species=>"setosa")     
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.7,Symbol("Sepal.Width")=>3.9,Symbol("Sepal.Length")=>5.4,Symbol("Petal.Width")=>0.4,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>3.4,Symbol("Sepal.Length")=>4.6,Symbol("Petal.Width")=>0.3,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.5,Symbol("Sepal.Width")=>3.4,Symbol("Sepal.Length")=>5,Symbol("Petal.Width")=>0.2,:Species=>"setosa")     
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>2.9,Symbol("Sepal.Length")=>4.4,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.5,Symbol("Sepal.Width")=>3.1,Symbol("Sepal.Length")=>4.9,Symbol("Petal.Width")=>0.1,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.5,Symbol("Sepal.Width")=>3.7,Symbol("Sepal.Length")=>5.4,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.6,Symbol("Sepal.Width")=>3.4,Symbol("Sepal.Length")=>4.8,Symbol("Petal.Width")=>0.2,:Species=>"setosa")   
 Dict{Symbol,Any}(Symbol("Petal.Length")=>1.4,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>4.8,Symbol("Petal.Width")=>0.1,:Species=>"setosa")     
 ⋮                                                                                                                                                    
 Dict{Symbol,Any}(Symbol("Petal.Length")=>4.8,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>6,Symbol("Petal.Width")=>1.8,:Species=>"virginica")    
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.4,Symbol("Sepal.Width")=>3.1,Symbol("Sepal.Length")=>6.9,Symbol("Petal.Width")=>2.1,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.6,Symbol("Sepal.Width")=>3.1,Symbol("Sepal.Length")=>6.7,Symbol("Petal.Width")=>2.4,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.1,Symbol("Sepal.Width")=>3.1,Symbol("Sepal.Length")=>6.9,Symbol("Petal.Width")=>2.3,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.1,Symbol("Sepal.Width")=>2.7,Symbol("Sepal.Length")=>5.8,Symbol("Petal.Width")=>1.9,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.9,Symbol("Sepal.Width")=>3.2,Symbol("Sepal.Length")=>6.8,Symbol("Petal.Width")=>2.3,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.7,Symbol("Sepal.Width")=>3.3,Symbol("Sepal.Length")=>6.7,Symbol("Petal.Width")=>2.5,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.2,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>6.7,Symbol("Petal.Width")=>2.3,:Species=>"virginica")  
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5,Symbol("Sepal.Width")=>2.5,Symbol("Sepal.Length")=>6.3,Symbol("Petal.Width")=>1.9,:Species=>"virginica")  
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.2,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>6.5,Symbol("Petal.Width")=>2,:Species=>"virginica")    
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.4,Symbol("Sepal.Width")=>3.4,Symbol("Sepal.Length")=>6.2,Symbol("Petal.Width")=>2.3,:Species=>"virginica")
 Dict{Symbol,Any}(Symbol("Petal.Length")=>5.1,Symbol("Sepal.Width")=>3,Symbol("Sepal.Length")=>5.9,Symbol("Petal.Width")=>1.8,:Species=>"virginica")  
```



To write this to a JSON file, we can use `JSON.json` in conjuction with the base package's `write` method.



{:.input_area}
```julia
json_string = JSON.json(to_array(iris_json))
write("export/iris-export.json", json_string)
```





{:.output .output_data_text}
```
14459
```



The output that we see above is the number of bytes in the file that we've just written.

### Reproducing the Pipeline

For ease of reproducing this pipeline in your future data science endeavors, we include this pipeline in the [json_pipeline.jl](json_pipeline.jl) file, that you may make use of as you need to. To use it, simply load the file from wherever you have it downloaded using `include`.



{:.input_area}
```julia
include("json_pipeline.jl")
```





{:.output .output_data_text}
```
write_json (generic function with 1 method)
```



The file includes the functions `load_json` and `write_json`, as well as the helper function `to_array`. Read their docstrings for more information on each function.
