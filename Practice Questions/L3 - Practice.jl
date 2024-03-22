using DataFrames, Distributions, Random, RDatasets
Random.seed!(123)


### SECTION 1: BASIC OPERATIONS

## 1.1
# Create a DataFrame named dat that includes three columns: `v1`, `v2`, and `v3`. Populate these columns with 100 values each, generated according to the following distributions: `v1` should contain values from a Standard Normal Distribution. `v2` should be filled with values from a Uniform Distribution, with the range set between -1 and 1. `v3` should consist of values from a Poisson Distribution, with the λ parameter (Lambda) set to 5. Ensure the DataFrame is properly constructed with these specifications.


## 1.2
# Rename the columns in the DataFrame as follows: `v1` to `stdnorm`, `v2` to `uniform`, and `v3` to `pois5`. After updating the column names, ensure to verify the changes to confirm that the renaming process was successful.


## 1.3
# Generate a new object named `dat_truncated` by extracting the first 25 observations from the `dat` DataFrame. This subset should include all columns present in `dat`, limited to the initial 25 rows.


## 1.4
# Create a new object named `dat_truncated2` that includes only the first two columns, `stdnorm` and `uniform`, from the original `dat` DataFrame. This new DataFrame should retain all rows present in `dat`, but only for these specified columns.


## 1.5
# Utilize the `describe()` function to perform a statistical summary for each of the three DataFrames: `dat`, `dat_truncated`, and `dat_truncated2`.



### SECTION 2: SORT & SELECT

# The code snippet provided initializes a new DataFrame named `horsekick`, which encapsulates the Prussian horsekick data found within the `pscl` package in R. This dataset records the annual number of Prussian cavalry soldiers who were fatally injured by horse kicks. The data spans from 1875 to 1894 and encompasses 14 distinct cavalry corps. The structure of the dataset is as follows: the first column details the count of fatalities, the second column indicates the year, and the third column specifies the corps number.
horsekick = dataset("pscl", "prussian")

## 2.1
# Identify the top 15 instances of fatalities within the dataset, specifying the cavalry corps and the corresponding years in which these highest death occurrences were recorded.


## 2.2
# In cases where multiple observations share the same death count from 2.1, ensure they are ordered by year in ascending fashion. This will provide a chronological ranking of the incidents with identical fatality numbers.


## 2.3
# Assume that we're only interested in learning in what corps most death occurances took place. Remove the `Year` variable and do 2.1 again.


## 2.4
# Now assume that we're only interested in learning when most death occurances take place. Remove the `Corp` variable and do 2.1 again. (Notice that both variables, `Y` and `Year`, start with the letter `Y`. We have seen a streamlined way of selecting variables starting with the same letter using anonymous functions)



### SECTION 3: SUBSET & TRANSFORM

## 3.1
# Utilizing the dataset referenced in the previous section, eliminate any observations that record zero instances of deaths due to horse kicks. This will ensure the analysis focuses solely on data representing actual fatalities.


## 3.2 
# Identify the cavalry corps that reported the highest number of fatalities due to horse kicks in the year 1880.


## 3.3
# Identify the years during which Corps XIV reported one or more fatalities resulting from horse kicks.


## 3.4
# You may have observed that the `Year` variable is represented with the final two digits, omitting the century. For example, the year 1880 is listed as 80. Please adjust this variable to display the full four-digit years for clarity and accuracy.


## 3.5
# Given the assumption that Corp X consistently underreported their fatalities due to horse kicks by not accounting for the first two deaths each year within the dataset's timeframe, please generate a modified dataset specific to Corp X. This dataset should adjust the reported deaths to reflect the true values by accounting for the underreported fatalities.



### SECTION 4: GROUPBY & COMBINE

## 4.1 
# Group the `horsekick` dataset based on the `Corp` variable, and store the resultant grouped data in a new object titled `horsekick_grouped`.


## 4.2
# Retrieve the second subgroup from `horsekick_grouped`.


## 4.3
# Summarize the total fatalities due to horse kicks for each year within the dataset. Subsequently, organize these annual totals in descending order to identify the years with the highest number of deaths.


## 4.4
# Now, compute the cumulative number of fatalities due to horse kicks for each corps within the dataset. Then, arrange these totals in descending order to discern which corps experienced the greatest number of deaths.

