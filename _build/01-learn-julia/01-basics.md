---
interact_link: content/01-learn-julia/01-basics.ipynb
kernel_name: julia-1.1
title: 'Numbers'
prev_page:
  url: /01-learn-julia/index
  title: 'The Basic Data Types'
next_page:
  url: /01-learn-julia/02-arrays
  title: 'Arrays'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Julia Basics

In this section, we cover the basic data types in Julia and operations (incl. arithmetic and logical operators). We also cover some of Julia's variable features, including Unicode characters.

## Elementary Data Types

Julia's elementary data types are analagous to those of other computing languages, although they differ in two big ways:

1. Floating point numbers and integers can be represented with varying precision and using a different amount of memory.
2. Julia recognizes individual unicode characters as a datatype.

The first of these is important because it allows you to optimize your code for memory usage. The main numerical types are `Int32`, `Int64`, `Float32`, and `Float64`. The first two represent integer values and the second two floating point decimal values. Julia defaults to the 64-bit types when no type is specified.



{:.input_area}
```julia
typeof(4), typeof(4.2)
```





{:.output .output_data_text}
```
(Int64, Float64)
```



As you can see, we use the `typeof` function to get the data type. The primitive integer types in Julia are:

| Type       | Signed? | Number of bits | Smallest value | Largest value |
|:---------- |:------- |:-------------- |:-------------- |:------------- |
| `Int8`     | ✓       | 8              | -2^7           | 2^7 - 1       |
| `UInt8`    | &nbsp;  | 8              | 0              | 2^8 - 1       |
| `Int16`    | ✓       | 16             | -2^15          | 2^15 - 1      |
| `UInt16`   | &nbsp;  | 16             | 0              | 2^16 - 1      |
| `Int32`    | ✓       | 32             | -2^31          | 2^31 - 1      |
| `UInt32`   | &nbsp;  | 32             | 0              | 2^32 - 1      |
| `Int64`    | ✓       | 64             | -2^63          | 2^63 - 1      |
| `UInt64`   | &nbsp;  | 64             | 0              | 2^64 - 1      |
| `Int128`   | ✓       | 128            | -2^127         | 2^127 - 1     |
| `UInt128`  | &nbsp;  | 128            | 0              | 2^128 - 1     |
| `Bool`     | N/A     | 8              | `false` (0)    | `true` (1)    |

Notice that `Bool` objects are considered to be integer types; this is because in Julia, as in many other languages, values are eitehr truthy or falsy, and so we can represent `true` as `1` and `false` as `0`. 

The maximum and minimum of each type can be found using the `typemax` and `typemin` functions.



{:.input_area}
```julia
typemax(Int32), typemin(Int32)
```





{:.output .output_data_text}
```
(2147483647, -2147483648)
```



The primitive floating point types in Julia are:

| Type      | Precision  | Number of bits |
|:--------- |:---------- |:-------------- |
| `Float16` | half       | 16             |
| `Float32` | single     | 32             |
| `Float64` | double     | 64             |

Julia also has types for strings, characters, and arrays, but these will be covered later.

## Operations

Julia contains the standard suite of operations, including `+`, `-`, `*`, `/`, `÷` (floor division), `\` (inverse division), `^`, and `%` (mod).



{:.input_area}
```julia
1 + 2, 1 - 2, 1 * 2, 1 / 2, 1 ÷ 2, 1 \ 2, 1 ^ 2, 1 % 2
```





{:.output .output_data_text}
```
(3, -1, 2, 0.5, 0, 2.0, 1, 1)
```



## Variables

As with many other languages, variables are assigned using the assignment operator `=`. Variables are case sensitive and their values are changeable.



{:.input_area}
```julia
x = 1
```





{:.output .output_data_text}
```
1
```



For all of the operators above, you can append an equal sign `=` to update a value assigned to a variable name:



{:.input_area}
```julia
x += 2
x
```





{:.output .output_data_text}
```
3
```





{:.input_area}
```julia
x /= 2
x
```





{:.output .output_data_text}
```
1.5
```



### Unicode Characters

Note the operator `÷` for integer division. This operator is an instance of Julia's ability to include Unicode characters in code, which is useful for defining variables and for allowing more accurate mathematical notation. These characters are added using by appending a `\` to the beginning of their name and pressing TAB. Some examples:

| Character | Shortcut |
|-----|-----|
| `÷` | `\div + TAB` |
| `≤` | `\le + TAB` |
| `⊻` | `\xor + TAB` |
| `ℯ` | `\euler + TAB` |
| `π` | `\pi + TAB` |
| `ε` | `\varepsilon + TAB` |

For most characters, these are similar to their LaTeX command (if they are available in LaTeX).



{:.input_area}
```julia
ℯ                  # ℯ (|euler) is prefedined as Euler's constant, but the character 'e' is not
```





{:.output .output_data_text}
```
ℯ = 2.7182818284590...
```





{:.input_area}
```julia
π                  # π (\pi) is also predefined
```





{:.output .output_data_text}
```
π = 3.1415926535897...
```



Most characters do not have a preset value, and so you can assign them certain values.



{:.input_area}
```julia
δ = 0.5
```





{:.output .output_data_text}
```
0.5
```



## Comparison and Logical Operators

Julia provides a suite of comparison operators to perform comparisons between data types and logical operators to create complex logical statements that evaluate to `Bool` values. Because of the unicode characters, some operators have more than one representation.

| Operator | Meaning |
|-----|-----|
| `==` | equal to |
| `!=`, `≠` | not equal to |
| `>` | greater than |
| `>=`, `≥` | greater than or equal to |
| `<` | less than |
| `<=`, `≤` | less than or equal to |
| `&&` | and |
| ```\|\|``` | or |
| `⊻` | xor |

Placing expressions on either sides of these operators yields a `true` or `false` value. You can negate a boolean value using the `!` (not) operator.



{:.input_area}
```julia
1 ≠ 2, 1 == 1, 1 == 2, 2 ≤ 1, 2 ≥ 1
```





{:.output .output_data_text}
```
(true, true, false, false, true)
```





{:.input_area}
```julia
((1 ≠ 2) || (2 ≥ 1)) && ((1 ≤ 2) ⊻ (2 != 1))
```





{:.output .output_data_text}
```
false
```





{:.input_area}
```julia
!(((1 ≠ 2) || (2 ≥ 1)) && ((1 ≤ 2) ⊻ (2 != 1)))
```





{:.output .output_data_text}
```
true
```



## Exercises

**Exercise 1.1.1:** What are the type minimum and maximum for `Float64`?

**Exercise 1.1.2:** Encode `true` as a Float64.

**Exercise 1.1.3:** Use Julia to calculate $\lfloor 10/3 \rfloor \mod 2$.

**Exercise 1.1.4:** What is the output of the following logical expression (recommended that you don't use Julia):

```julia
(((true ⊻ (1 ≥ 2)) || (1 >= 1)) && (true && (1 != 2) && (2 ≠ 2))) ⊻ false
```
