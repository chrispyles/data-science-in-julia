---
interact_link: content/02-functions-control-flow/03-control-flow.ipynb
kernel_name: julia-1.1
title: 'Control Flow'
prev_page:
  url: /02-functions-control-flow/02-conditionals
  title: 'Conditionals'
next_page:
  url: /03-builtins/index
  title: 'DataFrames in Julia'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Control Flow

## While Loops

Julia's `while` loop syntax is similar to that of many other languages:

```julia
while predictate
    # do something
end
```

As with all languages, it is important to make sure that the predicate has a teminating condition so that you don't end up in an infinite loop.



{:.input_area}
```julia
i = 1
while i < 10
    print(string(i) * " ")
    i *= 2
end
```


{:.output .output_stream}
```
1 2 4 8 
```

(Note the `*` above; in Julia, string concatenation is performed with this operator, as opposed to the more standard `+`.)

### Break Statements

Julia's `while` loops also support break statements, which stop and exit the loop when evaluated. To include a break, include the keyword `break`:

```julia
while predicate
    # do something
    if predicate
        break
    end
end
```

An example of this is given below.



{:.input_area}
```julia
println("Without break statement:")
i = 3
while i < 25
    print(string(i) * " ")
    i += 3
end

println("\nWith break statement:")
i = 3
while i < 25
    print(string(i) * " ")
    if i % 18 == 0
        break
    end
    i += 3
end
```


{:.output .output_stream}
```
Without break statement:
3 6 9 12 15 18 21 24 
With break statement:
3 6 9 12 15 18 
```

### Continue Statements

Julia also supports continue statements, which skip the rest of the loop evaluation _in the current loop_ when evaluated. When using `continue` statements, it is **very important** that your increment is _before_ the `continue` predicate, or else you will end up in an infinite loop.

```julia
while predicate
    # do something
    increment
    if predicate
        continue
    end
    # do something
end
```

Consider the example below, which only prints odd numbers.



{:.input_area}
```julia
i = 0
while i < 10
    i += 1
    if i % 2 == 0
        continue
    end
    print(string(i) * " ")
end
```


{:.output .output_stream}
```
1 3 5 7 9 
```

## For Loops

Julia's `for` loop syntax is similar to that of Python. It uses the `in` operator to iterate through the elements of an array or other iterable.

```julia
for element in array
    # do something
end
```

`for` loops support the use of `break` and `continue` statements as well. For ranges, it is simple to create an array of integers using `:` syntax, e.g. `1:10`. These ranges are inclusive at both ends and default to a step size of +1. It is also possible to specify a different step size using a second `:`:

```julia
low:step:high
```

For example, the range `10:-2:1` is $\{10, 8, 6, 4, 2\}$. An example for loop is given below.



{:.input_area}
```julia
for i in 5:5:100
    if i % 20 == 0
        continue
    end
    print(string(i) * " ")
    if i % 17 == 0
        break
    end
end
```


{:.output .output_stream}
```
5 10 15 25 30 35 45 50 55 65 70 75 85 
```

## Exercises

**Exercise 2.3.1:** Create a while loop that prints all of the letters in the phrase "data science is fun" but which are not in the word "string".

_Hint:_ Create an array of the letters and iterate through the index. You can check if a substring occurs in a larger string using `occursin(substring, big_string)`.

**Exercise 2.3.2:** Write a for loop to print out all multiples of 3 from 0 to 100 that are not odd. The loop should stop when it hits upon a multiple of 31 **that is not 0**.

**Exercise 2.3.3:** Write a function `cosines(start, stop)` that returns an array of the cosine of each number in the range `start:stop`. Use a for loop to add items to the array.

**Exercise 2.3.4:** Rewrite your `cosines` implementation to allow for a different step size. In this implementation using dot syntax to broadcast the cosine function to each element of the range.

 
