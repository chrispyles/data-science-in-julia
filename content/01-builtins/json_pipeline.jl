# Helper functions for loading JSON files
# from _Data Science in Julia_ by Christopher Pyles

# JSON should be formatted as list of dicts:
# [{"col" : val, ...}, ...]

# Dependencies: JSON, DataFrames

using JSON, DataFrames

function load_json(path)
    """
    Loads JSON file located at path. JSON file should be oriented
    as list of dicts, where each item in the list is a row of the
    DataFrame, i.e.
    
    [{"col1" : val1, "col2" : val2, ...},
    {"col1" : val1, "col2" : val2, ...},
    ...]
    
    Arguments:
        path - path to the JSON file relative to current
               environment
    """
    dictarr = JSON.parsefile(path)
    df_dict = Dict()
    for col in keys(dictarr[1])
        df_dict[col] = [row[col] for row in dictarr]
    end
    return DataFrame(df_dict)
end

function to_array(df)
    """
    Helper function that converts a DataFrame to an array of Dicts
    to be passed to JSON.json.
    
    Arguments:
        df - DataFrame to convert
    """
    arr = []
    for row in 1:size(df, 1)
        push!(arr, Dict((col => df[row, col] for col in names(df))))
    end
    return arr
end

function write_json(path, df)
    """
    Writes JSON file oriented as list of dicts, where each item in 
    the list is a row of the DataFrame, i.e.
    
    [{"col1" : val1, "col2" : val2, ...},
    {"col1" : val1, "col2" : val2, ...},
    ...]
    
    Arguments:
        path - path to where to write the JSON file
        df - DataFrame to write to JSON
    """
    arr = to_array(df)
    json_string = JSON.json(arr)
    write(path, json_string)
end









