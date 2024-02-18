############################################
#####        Abdullah Kabaoglu         #####
##### U. of Illinois Urbana-Champaign  #####
##### Date Created:     01.08.2024     #####
##### Last Revision:    02.18.2024     #####
############################################

### 1. PACKAGE MANAGEMENT
# Package Installation
# In Julia, external packages (libraries) are installed using the `Pkg` module.
using Pkg; Pkg.add("Statistics") # This line installs the `Statistics` package. (1.1)
# `using Pkg` loads the Pkg module, which provides functions for package management.
# `Pkg.add("Statistics")` tells Julia to download and install the Statistics package.

# Package Loading
# Once a package is installed, you can use it in your Julia programs by loading it with the `using` keyword.
using Statistics # This line loads the Statistics package.
# After this, functions and types defined in Statistics can be used directly in your code. (1.2)


### 2. VARIABLE TYPES
# Julia has various variable types including integers, floats, strings, vectors, and matrices.

# Integers are whole numbers without a fractional component, like 1, 2, 3, -27, 0. We define a variable with "=".
x = 1 # (2.1)
typeof(x) # Julia automatically chooses an appropriate subtype of `Int` (a shorthand for integers), e.g., Int8, Int16, Int32, Int64, or Int128, based on the system architecture and value. (2.2)

# Floats represent real numbers and include a decimal point, like 1.2, -3.4. Subtypes include Float16, Float32, and Float64.
y = 1.2 # (2.3)
typeof(y) # (2.4)

# Strings are sequences of characters enclosed in double quotes. Used for text.
z = "Joe" # (2.5)
typeof(z) # (2.6)

# Vectors are one-dimensional arrays that can hold elements of any type. They are ordered and indexable.
t1 = [1, 2, 3] # (2.7)
typeof(t1) # t1 is a vector of integers. (2.8)

# Julia, unlike some other languages (like R), allows vectors to hold different types of elements: 
t2 = ["a", 23, .8] # Here, t2 is a mixed-type vector containing a string, an integer, and a float. (2.9)

# Matrices are two-dimensional arrays. They behave like vectors but have rows and columns.
k1 = [1 2 3; 4 5 6; 7 8 9] # Numeric matrix (2.10)
k2 = [1 2 3; "k" "l" "m"] # Mixed-type matrix (2.11)

# Ranges are a way to represent a sequence of numbers. They are not a distinct type but are often used to generate vectors.
l1 = 1:100 # Range from 1 to 100 (2.12)
l2 = 1:.25:5 # Range from 1 to 5 with a step of 0.25 (2.13)

# `collect()` function can be used to convert a range into a vector.
collect(l1) # (2.14)


## Type Conversion
# Variables can be converted between different types. This is often necessary when dealing with functions that require specific types.
m1, m2 = 1, 7.0 # (2.15)

m1_float = Float64(m1) # Converts integer to float (2.16)
m2_int = Int64(m2) # Converts float to integer (2.17)

m1_float
m2_int

## Type Restrictions
n = "1"

n + 3 # Error: Julia is strongly typed and doesn't automatically convert between types. Here, a string, despite storing a number, cannot be directly added to a number.

### 3. BASIC ALGEBRAIC OPERATIONS
# Addition
1 + 2 # Adds two numbers together. (3.1)

# Subtraction
6 - .9 # Subtracts 0.9 from 6. (3.2)

# Multiplication
8 * 9 # Multiplies 8 and 9. (3.3)

p = 8
8p # Julia allows omitting the `*` symbol for multiplication with a variable. Here, it's equivalent to 8 * p. (3.4)

# Division
9 / 2 # Divides 9 by 2. In Julia, this returns a float even if the division is even. (3.5)

# Division Remainder (Modulo operation)
19 % 5 # Returns the remainder of the division of 19 by 5. (3.6)

# Exponentiation
23^3 # Raises 23 to the power of 3. (3.7)

# Square-root
sqrt(12) # Calculates the square root of 12. (3.8)

# Cubic-root
cbrt(8) # Calculates the cubic root of 8. (3.9)

# Natural Logarithm
log(3) # Returns the natural logarithm (base e) of 3. (3.10)

# Logarithm Base 10
log10(3) # Returns the logarithm of 3 to the base 10. (3.11)

# Logarithm to a Specific Base
log(23, 3) # Calculates the logarithm of 3 with base 23. (3.12)

# Exponential Function
exp(4) # Calculates e^4, where e is Euler's number (approximately 2.71828). (3.13)


## Compound Assignment Operators
# These operators combine an arithmetic operation with assignment, updating the original variable's value.
val = 123 # (3.14)

# Addition-Assignment
val += 3 # Adds 3 to val and updates val. Equivalent to val = val + 3. (3.15)

# Subtraction-Assignment
val -= 23 # Subtracts 23 from val and updates val. Equivalent to val = val - 23. (3.16)

# Multiplication-Assignment
val *= 7 # Multiplies val by 7 and updates val. Equivalent to val = val * 7. (3.17)

# Division-Assignment
val /= 8 # Divides val by 8 and updates val. Equivalent to val = val / 8. (3.18)


## Matrix Operations
# Defining a matrix by specifying rows. Each row is separated by a semicolon.
mat = [6 7 8; 9 2 3; 12 8 9] # This creates a 3x3 matrix. (3.19)

# Alternatively, matrices can be defined by specifying columns using column vectors.
mat2 = [[1, 2, 3] [2, 3, 4] [3, 4, 5]] # Each column vector forms a column of the matrix. (3.20)

# Creating a matrix with undefined values to be assigned later.
mat3 = Matrix{Int}(undef, 50, 2) # Creates a 50x2 matrix of undefined integers. (3.21)
mat3[:] = 1:100 # Assigns values 1 through 100 to the matrix elements in column-major order. (3.22)

# Matrix Transposition
mat' # Using the apostrophe symbol for transposition. Turns rows into columns and vice versa. (3.23)
transpose(mat) # The `transpose()` function achieves the same result as the apostrophe symbol. (3.24)

# Matrix Addition
mat + mat # Adds the matrix to itself element-wise. (3.25)

# Matrix Multiplication
mat3 = [9, 2, 3] # (3.26)
mat * mat3 # Multiplies mat (3x3) with mat3 (3x1). In Julia, the standard `*` operator is used for matrix multiplication. (3.27)

# Scalar Multiplication
mat * 2 # Multiplies every element of the matrix by 2. (3.28)

# Matrix Inversion
inv(mat) # Calculates the inverse of the matrix, if it exists. (3.29)

# Getting the Size of a Matrix
size(mat) # Returns a tuple indicating the dimensions of the matrix (rows, columns). Similar to `dim()` in R. (3.30)

# Note: For more advanced matrix functionalities, check out the LinearAlgebra package in Julia.


### 4. INDEXING 
# Understanding how to retrieve specific values from vectors and matrices is essential in Julia.

v1 = [1, 2, 3] # (4.1)
v2 = [2, 3, 4] # (4.2)
v3 = [3, 4, 5] # (4.3)

# Vectors are one-dimensional arrays, and individual elements can be accessed by their index inside square brackets.
v3[2] # Accesses the second element of the vector `v3`. (4.4)

v3[1:3] # Accesses a range of elements. This gets the first to third elements of `v3`. (4.5)
v3[[1,3]] # Accesses multiple specific elements. This gets the first and third elements of `v3`. (4.6)

# Matrices in Julia are two-dimensional, requiring both row and column indices for accessing elements.
mat
mat[1, 2] # Accesses the element at row 1, column 2 of the matrix `mat`. (4.7)

# To retrieve multiple elements from a matrix, use ranges or vectors for indices.
mat[1:2, 3] # Accesses elements in rows 1 to 2 of the third column. (4.8)
mat[1:3, [1, 3]] # Accesses all elements in rows 1 to 3 of the first and third columns. (4.9)

# The colon `:` is used to indicate all elements in a row or column.
mat[1, :] # Retrieves all elements in the first row. (4.10)
mat[:, 3] # Retrieves all elements in the third column. (4.11)

# In Julia, both vectors and matrices can be elements of larger vectors or matrices.
vv = [v1, v2, v3] # Creates a vector `vv` containing three other vectors `v1`, `v2`, and `v3`. (4.12)
isequal(vv[1], v1)

# To access elements within nested structures, use consecutive square brackets.
vv[2][3] # Accesses the third element of the second vector in `vv`. (4.13)

# Indexing in strings is similar to vectors, but the result is a combined string, not individual characters.
s = "Jason" # (4.14)
s[1] # Accesses the first character `J`. (4.15)
s[1:3] # Accesses the first to third characters `Jas`. (4.16)
s[[2, 4, 5]] # Accesses the 2nd, 4th, and 5th characters `a`, `o`, `n` and combines them into `aon`. (4.17)


### 5. USEFUL FUNCTIONS
## Basic Value Operations
a = -1.28323 # (5.1)

round(a) # Rounds `a` to the nearest integer. (5.2)

ceil(a) # Rounds `a` up to the nearest integer. (5.3)

floor(a) # Rounds `a` down to the nearest integer. (5.4)

a2 = 7 # (5.5)

# Checking if an integer is odd or even.
isodd(a2) # Returns true if `a2` is odd. (5.6)

iseven(a2) # Returns true if `a2` is even. (5.7)

## Vector Operations
b = [9, 3, 1, 1, -3] # (5.8)

# Summing and multiplying all elements in a vector.
sum(b) # Sums all elements. (5.9)
prod(b) # Multiplies all elements. (5.10)

# Getting the number of elements.
length(b) # Returns the length of vector `b`. (5.11)

# Accessing first and last elements.
first(b) # Returns the first element. (5.12)
last(b) # Returns the last element. (5.13)

# Creating a range of indices for the vector.
eachindex(b) # Returns an iterable of all indices in `b`. (5.14)
collect(eachindex(b)) # Collects the indices into an array. (5.15)

# Finding the index of a particular value
indexin(1, b) # Finds the index(es) of the first occurrence of the specified value (1 in this case) in vector 'b'. (5.16)

# Removing duplicate elements.
unique(b) # Returns a new vector with duplicates removed. (5.17)

# Sorting values by magnitude.
sort(b) # Sorting `b` in ascending order based on their magnitude. (5.18)

# Reversing the order of values.
reverse(b) # Rearranging the elements of `b` in the opposite order. (5.19)

# Repeating values
repeat(b, 10) # Replicating the entire vector `b`, 10 times in a row. (5.20)

# Finding maximum and minimum values.
maximum(b) # Returns the maximum value. (5.21)
minimum(b) # Returns the minimum value. (5.22)

# Finding the index of minimum and maximum values.
findmax(b) # Returns a pair of values containing the maximum value in vector `b` and its corresponding index. (5.23)
findmin(b) # Returns a pair of values with the minimum value in `b` and its index. (5.24)

# Adding elements to a vector.
push!(b, 2) # Adds 2 to the end of `b`. (5.25)
pushfirst!(b, 2) # Adds 2 to the beginning of `b`. (5.26)
# Note: Functions ending with `!` modify the original vector.

# Removing elements from a vector. 
pop!(b) # Removes the last element. (5.27)
popfirst!(b) # Removes the first element. (5.28)
popat!(b, 3) # Removes the third element. (5.29)

b2 = [8, 2, 3, 1, 4] # (5.30)

# Set operations on vectors.
union(b, b2) # Combines unique elements of `b` and `b2`. (5.31)
intersect(b, b2) # Returns common elements between `b` and `b2`. (5.32)
setdiff(b, b2) # Returns elements in `b` not in `b2`. (5.33)

# The same functions are applicable to ranges.
union(1:10, 5:15) # (5.34)
setdiff(1:10, 5:15) # (5.35)

## Matrix Operations
c = [1 2 3; 4 5 6] # (5.36)

# Converting rows and columns into separate vectors.
# For columns,
eachcol(c) # Returns an iterable over columns. (5.37)
eachcol(c)[1] # Accesses the first column. (5.38)
isequal(eachcol(c)[1], c[:,1])

# For rows,
eachrow(c) # Returns an iterable over rows. (5.39)
isequal(eachrow(c)[1], c[1, :]) 


### 6. BOOLEANS
# Booleans are data types representing logical values, either `true` or `false`. Boolean operations in Julia evaluate the truth value of statements.

# Basic Comparison Operations
2 > 6 # Evaluates if 2 is greater than 6. Returns false. (6.1)

3 >= -2 # Evaluates if 3 is greater than or equal to -2. Returns true. (6.2)

# Equality Checks
# There are two ways to evaluate the equality of values in Julia.
isequal(2, 2) # Checks if two values are exactly the same. Returns true. (6.3)
2 == 2 # `==` is another operator for checking equality. Also returns true. (6.4)

# Logical OR
# The `or` operator (||) checks if at least one of the conditions is true.
2 > 6 || 6 > 2 # Evaluates if either `2 > 6` or `6 > 2` is true. Returns `true` since `6 > 2` is true. (6.5)

# Logical AND
# The `and` operator (&&) checks if both conditions are true.
2 > 6 && 6 > 2 # Evaluates if both `2 > 6` and `6 > 2` are true. Returns `false` since `2 > 6` is false. (6.6)

# Logical NOT
# The `!` operator negates the truth value of a statement.
!(2 > 6) # Negates the statement `2 > 6`. Since `2 > 6` is false, `!(2 > 6)` returns `true`. (6.7)

# Membership Check
# The `in` function checks if a value is a member of a collection (like a vector or matrix).
1 in [1, 2, 3] # Checks if 1 is an element of the vector `[1, 2, 3]`. Returns `true`. (6.8)
3 in [2, 8, 9, 23] # Checks if 3 is an element of the vector `[2, 8, 9, 23]`. Returns `false`. (6.9)


#### 7. DEEP DOWN
## FUNCTIONS 
# Functions are arguably the most essential component of any programming endeavor. Similar to its definition in mathematics, they take an input(s) and convert it into an output following a particular pattern. Being able to write a new function is one of the key skills one might gain in programming. In the following lines, we create a new function, which basically increases the value of its input by two.


function add2(input) #  This line starts the definition of a new function. `function` is a keyword in Julia, used to declare that you're defining a function. `add2` is the name given to this function. This is how you'll refer to the function when you want to use it. `input` is the parameter of the function. It's a placeholder for the value you'll pass into `add2()` when you call it.
    output = input + 2 # Inside the function body, a new variable `output` is created. This line assigns to `output` the result of adding 2 to `input`. `input` is the value passed to the function, so if `input` is 5, then `output` will be set to 7.
    return output #  This line specifies what the function will return when it's called. `return` is a keyword that causes the function to finish and send back the specified value. `output` is the value being returned here. So, when you call `add2(5)`, the function returns 7.
end # This marks the end of the function definition. (7.1)

add2(3) # (7.2)
add2(23) # (7.3)


function complex_function(input1, input2, input3) # Here, we define another function with multiple inputs.
    output = 6*input1^2 + 12*input2 + 92*input3 - cbrt(987*input1*input2*input3)
    return output
end # (7.4)

complex_function(2, 45, 87) # (7.5)

# There are three ways to apply functions on a vector of values

## FOR LOOP
# This is the most inefficient way of applying a function to multiple values, and as we will see shortly, Julia offers far better alternatives. Yet, it is important to know how for loops work, as it is one of the universal structures in programming.

vals = 983:73:9962 # Here we create a vector of arbitrary values. We will serially use them as inputs. (7.6)

store1 = Vector(undef, length(vals)) # First, I create a vector of undefined values, having the same length as our input vector, `vals`. (7.7)

for i in 1:124 # Here, we start a for-loop. `1:124` creates a range from 1 to 124, inclusive. The variable `i` will take each value in this range, one at a time. So, i will be 1 in the first iteration, 2 in the second, and so on, up to 124.
    store1[i] = add2(vals[i]) # `vals[i]` accesses the i-th element of the array vals. If vals is an array of numbers, `vals[i]` is the number at position i. `add2(vals[i]` calls calls the function `add2()`, passing `vals[i]` as input. `store1[i]`, the result of `add2(vals[i])`, is stored in the i-th position of the vector `store1`. 
end # This marks the end of the for-loop. (7.8)

store1

## BROADCASTING
# Broadcasting is the most efficient way of applying functions over multiple values. It is sufficient to add a dot before paranthesis to carry out the broadcasting.
add2.(vals) # (7.9)

add2.(vals) == store1


## COMPREHENSION
# Comprehensions are used to create loops in a more expressive and succinct manner. It saves from for-loop's clunky syntax and creatinf storage object. 

[add2(i) for i in vals] # (7.10)

# `for i in vals`: This is the loop part of the comprehension. It iterates over each element in the array `vals`. During each iteration, `i` represents the current element from `vals`. 
# `add2(i)`: For each element `i` in `vals`, the function `add2` is called with `i` as its input. 
# `[ ... ]`: The entire expression is enclosed in square brackets, indicating that the result of `add2(i)` for each element `i` in `vals` is collected into a new vector.


# map function
map(add2, vals) # This applies the function add2 to each element in the array vals. The map function takes two inputs here: the function `add2()` and the vector `vals`. It returns a new vector where each element is the result of applying `add2()` to the corresponding element of vals. (7.11)

map(complex_function, 1:100, 1:100, 1:100) # Here, map is used with the function `complex_function()` that presumably takes more than one input. It applies `complex_function()` to each corresponding set of elements from the three ranges `1:100`, `1:100`, and `1:100`. The function is called for each combination of elements at the same position in these ranges. For example, `complex_function()` is called with inputs (1, 1, 1), then (2, 2, 2), and so on, up to (100, 100, 100). The result is a vector of the return values of `complex_function()`. (7.12)

map(x -> x + 2, 1:100) # This uses an anonymous function `x -> x + 2`, which takes a single input `x` and returns `x + 2`. The map function applies this anonymous function to each element in the range 1:100. Essentially, this adds 2 to each number in the range `1:100`, resulting in a vector with elements 3, 4, 5, ..., 102. (7.13)

map((x, y) -> x + sqrt(y) + 3, 1:100, 101:200) # It is also possible to use anoynmous functions with multiple inputs. (7.14)


### 8. USEFUL FUNCTIONS FURTHER
## Ternary Operator
# Ternary operator is an equivalent of if_else function in R. In the following line, the expression before the `?` is a condition `-7 > 0`. If this condition is true, the expression after the `?` and before the `:` is returned `"Positive"`. If the condition is false, the expression after the `:` is returned `"Negative"`.

-7 > 0 ? "Positive" : "Negative" # Since the condition, `-7 > 0`, is false, `"Negative"` is returned.

# Ternary operator is particularly useful when it is used in conjunction with map function and comprehensions. 
map(x -> x > 0 ? "Positive" : "Negative", -9:2:9)

[x > 0 ? "Positive" : "Negative" for x in -9:2:9]

## filter
# As its name implies, `filter` is used to create a new array containing only those elements of an existing array or range that satisfy a given condition.

filter(isodd, 1:100) # This line of code uses the `filter()` function to select elements from the range `1:100` that satisfy a certain condition. `isodd()` is a predefined function in Julia that checks if a number is odd, and returns boolean output, `true` or `false`.  `filter()` applies the `isodd()` function to each value in 1:100, and keeps only those to which `isodd()` function returns `true`. Thus, `filter(isodd, 1:100))` effectively filters out all the odd numbers from the range `1:100`. The result is an array of all odd numbers between 1 and 100. (7.15)

# It is also possible to define anoynmous functions within `filter()`:
filter(x -> x > 50, 1:100) # Here, filter is used with an anonymous function `x -> x > 50` and the range `1:100`. The anonymous function `x -> x > 50` checks if a number `x` is greater than 50. `filter()` applies this function to each number in the range `1:100` and keeps only those numbers for which the function returns `true`. The result of this line of code is an array of all numbers greater than 50 in the range `1:100`. (7.16)

## replace
# The `replace()` function is used to create a new collection by replacing certain elements in an existing collection based on specified criteria. It takes two primary arguments: a collection (like an array, vector, or range) and a function

replace(x -> x > 3 ? 0 : x, 1:10) # This performs a replacement operation on each element of the range `1:10`. `x -> x > 3 ? 0 : x` is an anonymous function that acts as a condition for the replacement. For each element `x` in the range, if `x` is greater than 3, the function returns `0`. Otherwise, it returns `x` itself. Consequently, this line of code replaces all the values greater than 3 with 0. (7.17)

### 9. MISCELLANEOUS

## @time
# The @time macro in Julia is used to measure the time taken to execute a piece of code, along with the amount of memory it allocates. It's a handy tool for performance profiling.
@time [x^2 + 3x + 7 for x in 1:10^6] # (7.18)

# The '@time' macro here is used to measure how long it takes to compute the expression following it.
# The expression is a list comprehension that calculates 'x^2 + 3x + 7' for each 'x' in the range 1 to 10^6.
# This will output the time taken to execute the operation and the memory used by it.

## Random.seed!
# This is the equivalent of R's `set.seed()` function in Julia. It allows for replicating analyses with random components, such as Monte Carlo methods. Unlike R, however, it requires the installation of the `Random` package. 

using Pkg; Pkg.add("Random")
using Random

Random.seed!(123) # Sets the random number generator's seed to 123. Any random operations performed after this will produce the same results each time the code is run with this seed. (7.19)