---
interact_link: content/02-functions-control-flow/02-conditionals.ipynb
kernel_name: julia-1.1
title: 'Conditionals'
prev_page:
  url: /02-functions-control-flow/01-functions
  title: 'Functions'
next_page:
  url: /02-functions-control-flow/03-control-flow
  title: 'Control Flow'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Conditionals

This section covers the if-else statement in Julia and the ternary operator, and contains a short discussion of short-circuit evaluation in Julia.

## If-Else Statements

Julia conditionals are comprised of an `if` statement and and optional `else` statement, followed by the `end` keyword. The `if` statement requires a boolean predicate value.

```julia
if boolean
    # do something
else
    # do something else
end
```



{:.input_area}
```julia
if 1 < 2
    print("true")
else
    print("false")
end
```


{:.output .output_stream}
```
true
```

### Else If

It is also possible to provide `elseif` clauses to the conditional to check for mutiple possible outcomes.



{:.input_area}
```julia
number = "three"

if number == "one"
    print(1)
elseif number == "two"
    print(2)
elseif number == "three"
    print(3)
elseif number == "four"
    print(4)
else
    print("not 1, 2, 3, or 4")
end
```


{:.output .output_stream}
```
3
```

## Ternary Operator

For quick-and-dirty evaluations, Julia provides a ternary operator which is similar to those of many other languages. It uses `? :` syntax:

```julia
predicate ? value_if_true : value_if_false
```

For example, you could assign a value based on whether or not some other value is even or odd:



{:.input_area}
```julia
x = 3
y = x % 2 == 0 ? 1 : 0
```





{:.output .output_data_text}
```
0
```



## Short-Circuit Evaluation

Finally, Julia short-circuits evaluation of compound expressions using `&&` and `||` as in most other languages:

* Evaluation of `A && B` stops if `A` is `false` and returns `false`.
* Evaluation of `A || B` stops if `A` is `true` and returns `true`.

Because `⊻` requires the left and right predicates to be different, its evaluation cannot be short-circuited.

As a demonstration, consider the conditional below. `B` is not defined, but this won't error because the evaluation will short-circuit upon evaluating `A` in each case and thus `B` is never evaluated.



{:.input_area}
```julia
A = false
if !(A && B)
    println("&& short-circuited")
end

A = true
if A || B
    println("|| short-circuited")
end
```


{:.output .output_stream}
```
&& short-circuited
|| short-circuited

```

## Exercises

**Exercise 2.2.1:** Write a function `print_name(name::String)` which prints out the name `name` only if it's length is greater than 0. If the length is 0, it should print out `"Name string is empty."`.

_Hint:_ You can use `length(s)` to get the length of a string `s`.

**Exercise 2.2.2:** Following each line below, write the value of `x`.

```julia
x = 1 < 2 ? 0 : 1          # x = ____
x = x > -1 ? 2 : 0         # x = ____
x = true && false ? 3 : 5  # x = ____
x = x == 5 ? 2 : -1        # x = ____
x = x < 0 ? -1 : 4         # x = ____
```

**Exercise 2.2.3:** For each line below, determine whether or not the line will error in evaluation. If a line errors, assume it is not executed. Assume that `A = true`, `B = false`, and `C = true` have already been set.

```julia
A && B                     # Error? ____
A && D                     # Error? ____
A || C                     # Error? ____
B && E                     # Error? ____
C || D                     # Error? ____
C && (A || B)              # Error? ____
B && (A || D)              # Error? ____
A && (C && D)              # Error? ____
B ⊻ D                      # Error? ____
```

 
