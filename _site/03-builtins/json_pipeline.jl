# Helper functions for loading JSON files
# from _Data Science in Julia_ by Christopher Pyles

# JSON should be formatted as list of dicts:
# [{"col" : val, ...}, ...]

# Dependencies: JSON, DataFrames

using JSON, DataFrames

function load_json(path; orient="records")
    """
    Loads JSON file located at path. JSON file should be oriented
    as list of dicts, where each item in the list is a row of the
    DataFrame, i.e.
    
    [{"col1" : val1, "col2" : val2, ...},
    {"col1" : val1, "col2" : val2, ...},
    ...]
    
    Arguments:
        path   - path to the JSON file relative to current
                 environment
        orient - String describing how the JSON file is
                 structured; values:
    
            "records" - array of rows, each row is a dict mapping
                        col to value
                        
                        [{"col1" : val1, "col2" : val2, ...},
                        {"col1" : val1, "col2" : val2, ...},
                        ...]
            
            "index"   - dict of rows to dict of cols to values
            
                        {"row1" : {"col1" : val1, "col2" : val2}},
                        {"row2" : {"col1" : val1, "col2" : val2}},
                        ...}
    
            "columns" - dict of columns to dict of rows to values
                        
                        {"col1" : {"row1" : val1, "row2" : val2}},
                        {"col2" : {"row1" : val1, "row2" : val2}},
                        ...}
    """
    dictarr = JSON.parsefile(path)
    df_dict = Dict()
    if orient == "records"
        for col in keys(dictarr[1])
            df_dict[col] = [row[col] for row in dictarr]
        end
    elseif orient == "index"
        for col in keys(dictarr[collect(keys(dictarr))[1]])
            df_dict[col] = []
        end
        for row in keys(dictarr)
            for col in keys(dictarr[row])
                push!(df_dict[col], dictarr[row][col])
            end
        end
    elseif orient == "columns"
        for col in keys(dictarr)
            df_dict[col] = [dictarr[col][row] for row in keys(dictarr[col])]
        end
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