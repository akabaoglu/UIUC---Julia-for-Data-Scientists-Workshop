using Random
Random.seed!(123)

### SECTION 1: FUNCTIONS

## 1.1 
# The following line of code defines an object `v1` comprising a series of 100 random values between 0 and 1:
v1 = rand(100)
# Can you create a function named `vec_diff` that calculates the difference between the largest and smallest elements of a vector? Then, apply this function to the vector `v1`.

## 1.2 
# In the following line, a new object `v_series` is defined, consisting of 100 vectors, each containing 20 values: 
v_series = [rand(20) for _ in 1:100]
# Can you compute the sum of values stored in the 79th vector?

## 1.3 
# Using the function `vec_diff()` created in Question 1, apply it to the object `v_series` using broadcasting.


## 1.4 
# Following that, obtain the same result using the `map()` function.


## 1.5
# Suppose that the function `vec_diff()` from Question 1 was not defined, yet we'd like to perform the same operation on `v_series` using an anonymous function within the `map()` function, how would you do this?



### SECTION 2: BOOLEANS

## 2.1
# Please evaluate whether 10^11 is greater than 11^10. 


## 2.2
# A matrix object (100x3), `rand_mat`, has been defined with values randomly drawn between 0 and 1, rounded up to the second decimal:
rand_mat = round.(rand(100, 3), digits = 2)
# Evaluate whether the sum of values in the 1st column is greater than the sum of values in the 2nd column.


## 2.3
#  Please create a boolean vector evaluating which values in the 3rd column of `rand_mat` are greater than 0.47.


## 2.4
# Create another boolean vector evaluating in which rows the value in the 1st column is greater than the value in the 3rd column in `rand_mat`.


## 2.5
# Please count how many values in the 1st column of rand_mat are equal to 0.52.


### 3. USEFUL FUNCTIONS

## 3.1
# A sequence of values is defined to the object l1 in the following line:
l1 = -100:1:100
# Filter out the odd values from l1, ensuring that l1 no longer contains any odd values.


## 3.2
# Modify the remaining values in l1 applying the following pattern: If the absolute value of a given value is greater than 10, replace it with its modulo to 3, otherwise replace it with its square.


## 3.3 
# Remove all values that are equal to 0.


## 3.4 
# Now, sort the values in l1 in descending order. (Tip: You may want to check the documentation for the sort() function, where you will find a functionality to sort vectors in descending order.)


## 3.5 
# Finally, find the intersection set of the original interval (-100:1:100) and the final l1 object.

