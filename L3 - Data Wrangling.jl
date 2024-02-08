#############################
##### Abdullah Kabaoglu #####
#####    01.15.2024     #####
#############################

### DATAFRAMES ###

# The DataFrame type is not included in the base Julia module. Instead, it is a part of the DataFrames package, which also provides a wide array of functionalities for data wrangling. 
using DataFrames, Distributions, Random

## BASIC OPERATIONS
Random.seed!(123) # Seed the random number generator for consistent results across runs.

var1 = rand(Normal(0, 1), 100) # Generates a sample of 100 values from a normal distribution with mean 0 and standard deviation 1.
var2 = rand(Poisson(5), 100) # Generates a sample of 100 values from a Poisson distribution with a lambda of 5.
var3 = rand(Uniform(-10, 10), 100) # Generates a sample of 100 values from a uniform distribution ranging from -10 to 10.

# The simplest and most straightforward method to construct a DataFrame is through the DataFrame() function. This approach involves assigning arrays of values to specifically named variables.
df = DataFrame(Y = var1, X1 = var2, X2 = var3) # Creates a DataFrame with three variables. Each variable is named `Y`, `X1`, and `X2` and populated with the values from `var1`, `var2`, `var3`, respectively. 

# Instead of defining each variable separately, a DataFrame can also be created directly from a matrix. By using the `:auto` argument, Julia automatically converts each column of the matrix into a separate variable in the DataFrame.
mat1 = rand(Uniform(1, 10), 10, 2) # Generates a 10x2 matrix with values drawn from a Uniform distribution ranging from 1 to 10.
df2 = DataFrame(mat1, :auto) # Creates a DataFrame from `mat1` with automatic variable naming.

# When a DataFrame is created this way, Julia assigns default names to each variable, typically in the form of `x1`, `x2`, ..., `x<n>`.
names(df2)  # Retrieves the auto-assigned variable names of `df2`, which are generated based on the number of variables in the matrix.

# To provide more meaningful variable names, we can use the `rename!()` function. This changes the existing variable names in the DataFrame.
rename!(df2, [:Var1, :Var2])  # Renames the variables of `df2` to `Var1` and `Var2`.

# To access a particular variable in the DataFrame, we can use `.` operator. 
df.Y # Calls the entire `Y` variable in the DataFrame, `df`.

# While the `.` operator in Julia offers convenience for accessing DataFrame variables, it has its limitations, notably its inability to reference multiple variables simultaneously. To overcome this, one can employ matrix indexing rules. This approach allows for selectively accessing specific variables and observations within a DataFrame, providing greater flexibility and control in data manipulation.
df[:, [:X1, :X2]] # Accesses the entirity of `X1` and `X2` variables.

df[1:15, [:Y, :X1]] # Selects only the first 15 rows and the variables `Y` and `X1`.

# We can use the `.` operator to add a new variable into an pre-existing DataFrame, too.
df.X3 = 1:100 # Creates a new variable `X3` to `df`, with values from 1 to 100.

# The `describe()` function allows for obtaining summary statistics for variables in a DataFrame.
describe(df) # Provides summary statistics for each variable in the DataFrame.

# Similar to R's `head()` and `tail()` functions, Julia provides `first()` and `last()` functions to access the initial and final observations in a DataFrame, respectively.
first(df) # Displays the first row of `df`.
first(df, 5) # Displays the first 5 rows.

last(df) # Displays the last row of `df`.
last(df, 5) # Displays the last 5 rows of `df`.

# When we are interested in knowing the number of observations and variables in a DataFrame, we can use the `nrow()` and `ncol()` functions, respectively. `nrow()` provides the count of rows (observations), while `ncol()` returns the number of columns (variables).
nrow(df) # Provides the number of rows.
ncol(df) # Counts the number of variables.


## SORT: Sorting Data in Ascending/Descending Order

# The `sort()` function in Julia is employed to reorder the rows of a DataFrame based on the values of one or more specified variables. This function is analogous to the `arrange()` function in dplyr (R). The primary syntax of `sort()` involves two arguments: the first is the DataFrame to be reordered, and the second is the variable(s) upon which the sorting is based:
sort(df, :X1) # Sorts the DataFrame `df` by the variable `X1` in ascending order. Rows are rearranged so that values in `X1` are in increasing order.

# By default, the `sort()` function arranges the data in ascending order. If you need to sort the data in descending order, you can achieve this by passing the argument `rev = true`.
sort(df, :X1, rev = true) # Sorts `df` by `X1` in descending order. The `rev` parameter specifies that the sorting should be reversed.

# The `sort()` function in Julia also allows for reordering based on multiple variables. This is done by passing an array of variables, rather than a single variable, to the function. In such cases, the order of variables within the array is crucial. Julia prioritizes the sorting based on the variables positioned earlier in the array. Consequently, the subsequent variables are considered for sorting only when there are equivalent values in the preceding ones
sort(df, [:X1, :X2]) # Sorts `df` first by `X1` and then by `X2` in ascending order. If there are duplicate values in `X1`, `X2` is used to determine the order.

# We can particularly specify on which variables we'd like to arrange the DataFrame in ascending or desceding order:
sort(df, [:X1, :X2], rev = [true, false]) # Sorts `df` first by `X1` in descending order and then by `X2` in ascending order. The `rev` parameter is a boolean array that specifies the sorting order for each variable.

#  Please note that the `sort()` function, when suffixed with `!`, modifies the original dataset. This variant, `subset()`, directly alters the existing DataFrame instead of creating a new one.
sort!(df, [:X1, :X2], rev = [true, false])


## SELECT: Selecting Variables in a DataFrame

# The `select()` function allows for downsizing DataFrames by removing redundant variables. Its syntax is similar to dplyr's `select()` function, but it differs in one significant aspect: Variable names have to be provided in one argument within an array, instead of multiple arguments.
select(df, [:Y, :X1, :X2]) # Selects the variables `Y`, `X1`, and `X2` from the DataFrame `df` and returns a new DataFrame with just these variables.

# Sometimes it may be more convenient to specify the variable names we'd like to remove. In such cases, the `Not()` function might be of help.
select(df, Not(:X3)) # Selects all variables from `df` except for `X3`.

# To select variables within a range, we can use the `Between()` function.
select(df, Between(:X1, :X3)) # Selects all variables between `X1` and `X2`, inclusive. 

# When working with large datasets, it's often more practical to select variables based on a pattern rather than specifying each name individually. In such scenarios, the `Cols()` function proves to be highly useful. This function accepts an anonymous function as its argument and retains variables for which the provided function returns `true`.
select(df, Cols(x -> startswith(x, "X"))) # Selects variables whose names start with "X". The `Cols()`function, with the anonymous function in it, checks the beginning of each variable name.
select(df, Cols(x -> endswith(x, "2"))) # Selects variables whose names end with "2". Similar to the above, but checks the end of variable names.
select(df, Cols(x -> contains(x, "X"))) # Selects variables that contain the character "X" anywhere in their names.

# The `Cols()` function can also be used in conjunction with the `Not()` function.
select(df, Not(Cols(x -> contains(x, "X")))) # Excludes variables that contain the character "X" in their names. It's the opposite of the previous command.

# Please note that the `select()` function, when suffixed with `!`, modifies the original dataset. This variant, `select!()`, directly alters the existing DataFrame instead of creating a new one.
select!(df, Not(:X3))


## SUBSET: Row-wise Filtering

# While the `select()` function reduces the size of a DataFrame by selecting specific variables, the `subset()` function accomplishes this by filtering observations. It serves as the equivalent of R's `filter()` function in Julia. Despite some similarities between the two, the syntax of `subset()` is admittedly a bit more complex, yet it offers greater flexibility compared to `filter()`.

# The `subset()` function consists of two arguments: a DataFrame and filtering criterion.
subset(df, :Y => y -> y .> 0) # Here, the DataFrame being operated on is `df`, and the filtering criterion is specified by `:Y => y -> y .> 0`. A filtering criterion in Julia typically consists of two components: a variable name and an anonymous boolean function. In our case, `:Y` identifies the variable based on which the DataFrame will be filtered. The expression `y -> y .> 0` represents an anonymous boolean function, indicating that only observations where `Y` is greater than 0 will be retained. The dot (`.`) preceding `>` signifies that the evaluation is to be made element-wise across the dataset. The variable name and the boolean function are linked together using the `=>` operator. Thus, this line of code effectively filters `df`, keeping only those observations where the value of `Y` is greater than 0.

# The `ByRow()` function in Julia offers an alternative to using the element-wise operator `.`. Both `ByRow()` and `.` ensure that the anonymous function is applied on an element-wise basis, meaning it operates on each row individually. This allows for a more intuitive and explicit way of specifying that the function should be applied to each row, rather than using the dot syntax.
subset(df, :Y => ByRow(y -> y > 0)) # This line is similar to the previous one, with the key difference being the use of `ByRow()` in place of the `.` operator. Throughout the rest of this script, I'll primarily use `ByRow()` the reasons explained above. However, it's important to note that the same operations can be effectively performed using the dot operator as well.

# Frequently, filtering data requires multiple variable conditional. To achieve this, we need to concatenate two variable names within an array and pair them with an anonymous boolean function that takes two inputs. 
subset(df, [:Y, :X1] => ByRow((y, x) -> y > 0 || x < 5)) # This line filters `df` to retain rows where either the value in the `Y` variable is greater than 0, OR the value in the `X1` variable is less than 5. It's important to note that the filtering is based on two variables, `Y` and `X1`, which are grouped together in an array. The anonymous function `(y, x) -> y > 0 || x < 5` defines the condition: a row is kept if either `y` (the value in `Y`) exceeds 0, or `x` (the value in `X1`) is below 5.

# The `in` operator is equivalent of R's `%in%` in Julia.
subset(df, :X1 => ByRow(x -> x in [1, 3, 6])) # Filters `df` to keep rows where `X1` values are in the set `[1, 3, 6]`.

# Please note that the `subset()` function, when suffixed with `!`, modifies the original dataset. This variant, `subset!()`, directly alters the existing DataFrame instead of creating a new one.
subset!(df, :X1 => ByRow(x -> x < 20)) # Directly modifies `df` to keep only rows where `X1` is less than 20.


## TRANSFORM: Creating New Variables out of Existing Ones

# The `transform()` function in Julia is used to create new variables from existing ones in a DataFrame, similar to dplyr's `mutate()` function in R. The syntax of `transform()` closely resembles that of `subset()`, with a key difference being the nature of the anonymous function it uses. Unlike the boolean output in the filtering criteria of `subset()`, the anonymous function in `transform()` yields a numerical or categorical output. Essentially, `transform()` is focused on data augmentation and modification, rather than data filtering.

transform(df, :X1 => ByRow(x -> sqrt(x))) # In this context, `df` refers to the DataFrame where we intend to create a new variable. The expression `:X1 => ByRow(x -> sqrt(x))` represents the pattern for generating this new variable. Here, `:X1` identifies the existing variable from which the new variable will be derived. The `ByRow()` function indicates that the transformation will be applied element-wise across the variable. The anonymous function `x -> sqrt(x)` is responsible for the actual transformation, taking each input value `x`, calculating its square root, and then returning this result. Ultimately, this line of code executes the square root function on every element in the `X1` variable, appending the results as a new variable in the DataFrame `df`.

transform(df, :X1 => x -> sqrt.(x)) # Similar to `subset()`, we can alternatively choose to use element-wise operation `.` (instead of `ByRow()`) to apply the square root function to the `X1` variable.

# When a new variable is generated, Julia automatically assigns a name to it, typically following the pattern "<original_variable_name>_function". If a more specific or descriptive name is preferred, you can manually assign a custom name. This is done by adding another `=>` followed by the desired name.
transform(df, :X1 => ByRow(x -> x + 2) => :X1_new) # Adds 2 to each element of `X1` and stores the result in a new variable named `X1_new`.

# In cases where the new variable in a DataFrame is intended to be derived from multiple existing variables, Julia's `transform()` function can accommodate this as well. To create a variable that is a combination of several existing ones, you would concatenate the names of these source variables within an array. This array is then paired with an anonymous function designed to accept multiple inputs, corresponding to each of the source variables.
transform(df, [:X1, :X2] => ByRow((x1, x2) -> cbrt(2x1 + 3x2)))# This line introduces a new variable into the DataFrame `df`, leveraging data from two existing variables, `Y` and `X1`. These source variables are grouped within an array. The anonymous function `(x1, x2) -> cbrt(2x1 + 3x2)` outlines the logic for creating the new variable: it calculates the cubic root of the expression `2*X1 + 3*X2` for each row. Essentially, this operation takes each corresponding pair of values from `X1` and `X2`, applies the formula `2x1 + 3x2`, and then computes the cubic root of the result.

# Again, remember that the `transform()` function, when suffixed with `!`, modifies the original dataset. This variant, `transform!()`, directly alters the existing DataFrame instead of creating a new one.
transform!(df, [:X1, :X2] => ByRow((x1, x2) -> cbrt(2x1 + 3x2)) => :X_new) 


## GROUPBY & COMBINE: Subgroup Analyses
# In Julia, the `groupby()` and `combine()` functions serve purposes analogous to dplyr's `group_by()` and `summarize()` in R, respectively. These functions are fundamental for computing descriptive statistics within specific subgroups of a DataFrame. The `groupby()` function effectively segments the DataFrame into distinct groups, each corresponding to a unique combination of values from the specified grouping variables. It achieves this by creating a separate SubDataFrame for each unique value or set of values of the specified variables. Consequently, every observation is categorized into its corresponding subgroup. 

df_grouped = groupby(df, :X1) # Groups the DataFrame `df` by the variable `X1`.

df_grouped[8] # Accesses the 8th SubDataFrame from the grouped DataFrame `df_grouped`. In that SubDataFrame, `X1` is incidentally equal to 8. 

combine(df_grouped, :Y => mean => :Mean_Y) # Applies the `mean()` function to the `Y` column for each group defined by `X1` and creates a new column `Mean_Y` in the result.

combine(df_grouped, :Y => mean) # Calculates the mean of `Y` for each group but does not specify a new column name for the mean.

combine(df_grouped, :Y => var) # Applies the `var()` function to calculate the variance of 'Y' for each group.

combine(df_grouped, :Y => x -> mean(x) - minimum(x)) # Applies an anonymous function to `Y` for each group, calculating the difference between the mean and minimum of `Y`.

combine(df_grouped, [:Y, :X2] .=> x -> mean(x)) # Calculates the mean for both `Y` and `X2` for each group.

combine(df_grouped, [:Y, :X2] .=> (x -> mean(x)) .=> [:Y_new, :X2_new]) # Similar to the previous line, but assigns new names (`Y_new`, `X2_new`) to the resulting columns.

combine(df_grouped, :Y => (x -> (a = sum(x), b = length(x))) => AsTable) # Applies a function to `Y` that returns a tuple (sum and count), and presents the results as a table with column names 'a' and 'b'.

combine(df_grouped, :Y => x -> first(x, 3)) # For each group, extracts the first 3 elements of 'Y'.
combine(df_grouped, :Y => x -> last(x, 5)) # For each group, extracts the last 5 elements of 'Y'.


## STACK/UNSTACK: Reshaping DataFrames
using RDatasets

df2 = select(dataset("ggplot2", "midwest"), 1:6)
subset!(df2, :State => ByRow(x -> x == "IL"))

# Stacking a DataFrame (Long Format)
df2_stacked = stack(df2, [:Area, :PopTotal, :PopDensity])
# The `stack()` function is used to transform `df2` from a wide format to a long format. It stacks the specified columns `Area`, `PopTotal`, and `PopDensity` into two new columns: `variable` and `value`. `variable` contains the names of the original columns, and `value` contains the corresponding values. This long format is useful for certain types of data analysis, particularly when dealing with multiple measurements over the same set of observations.

subset(df2_stacked, :County => ByRow(x -> x == "ADAMS"))

# Unstacking a DataFrame (Back to Wide Format)
unstack(df2_stacked, :variable, :value)
# The `unstack()` function is used to transform `df2_stacked` back to a wide format. It reverses the operation done by `stack()`. The `variable` column becomes multiple columns (as in the original `df2`), and the `value` column provides the values for these new columns. This is useful when you need to perform operations that are more conveniently done in the wide format, such as comparing different variables across the same set of observations.

## JOINs: Merging DataFrames

df3 = DataFrame(KEY = ["A", "B", "C", "D", "E"], V1 = randn(5))
df4 = DataFrame(KEY = sample(["A", "B", "C", "D", "F"], 100), V2 = rand(100))

# Left Join
leftjoin(df3, df4, on = :KEY) # Combines `df3` and `df4` based on the `KEY` column. In a left join, all rows from the left DataFrame (`df3`) are included in the result. If there are matching keys in `df4`, the corresponding values are added to the result. If there is no match, the resulting DataFrame will have missing values in the columns of `df4`.

# Right Join
rightjoin(df3, df4, on = :KEY) # Similar to left join, but here all rows from the right DataFrame (`df4`) are included. If there are matching keys in `df3`, their values are added. If there is no match, the result will have missing values in the columns of '`df3`.

# Inner Join
innerjoin(df3, df4, on = :KEY) # Combines rows from both `df3` and `df4` where there are matching values in the `KEY` column. Only the rows with matching keys are included in the result. Rows from either DataFrame that do not have a matching key are excluded.

# Outer Join
outerjoin(df3, df4, on = :KEY) # Combines `df3` and `df4` and includes all rows from both, regardless of whether there is a match. Where there is no match, missing values are inserted in the place of missing rows.

df5 = DataFrame(KEY1 = ["A", "B", "C", "D", "E"], V1 = randn(5))
df6 = DataFrame(KEY2 = sample(["A", "B", "C", "D", "F"], 100), V2 = rand(100))

df6 = outerjoin(df5, df6, on = [:KEY1 => :KEY2])
# Performs an outer join on `df5` and `df6` with different key names. `KEY1` from `df5` and `KEY2` from `df6` are used as the joining columns. This is useful when the columns you want to join on have different names in each DataFrame.


## MISSING VALUES
dropmissing(df6)
# The `dropmissing()` function removes all rows from the DataFrame `df6` that contain any missing values. This is useful when you want to analyze data without any missing values interfering with calculations or visualizations. Note that this does not modify `df6` directly but returns a new DataFrame with the missing values removed.

coalesce.(df6.V1, -99)
# The `coalesce.()` function is applied element-wise (noted by the dot `.`) to replace missing values in the `V1` column of 'df6' with -99. This is useful when you want to impute missing data with a specific value, such as a default value, zero, mean, median, etc. Unlike `dropmissing()`, `coalesce.()` can be used to fill in missing data instead of removing it.

mean(skipmissing(df6.V1))
# The `skipmissing()` function is used to create an iterator that skips over any missing values in the `V1` column of `df6`. The `mean()` function then calculates the average of the remaining (non-missing) values. This approach is useful when you want to compute summary statistics while ignoring missing data.