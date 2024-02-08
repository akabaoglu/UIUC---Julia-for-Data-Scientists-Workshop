#############################
##### Abdullah Kabaoglu #####
#####    01.13.2024     #####
#############################

### BASIC STATISTICAL OPERATIONS ###
using Statistics, StatsBase # Statistics and StatsBase are two key packages to perform basic statistical operations on Julia.

# I start off with defining an array of numbers.
lost_numbers = [4, 8, 15, 16, 23, 42]

# The `mean()` function is used in calculating the mean of a series of values. 
mean(lost_numbers) # Calculates the average of 'lost_numbers'.

# What is special about the `mean()` function is that it allowing for the calculation of the mean of a collection of values directly, or after applying a specific function to each element in the collection.

mean(sqrt, lost_numbers) # Returns the mean of `lost_numbers` after applying the square-root function to each element. Instead of first creating a separate array of square roots, this approach directly applies the `sqrt()` function to each element and then calculates the mean.

# It is also possible to use an anonymous function for the same purpose:
mean(x -> x^2 + 2, lost_numbers) # Returns the mean of `lost_numbers` after applying f(x) = x^2 + 2 function.

# Calculating the Median
median(lost_numbers) # Finds the median value of `lost_numbers`.

# Standard Deviation
std(lost_numbers) # Calculates the standard deviation of `lost_numbers`.

# Finding specific quantiles of the data
quantile(lost_numbers, .05) # Returns the value located at 5th percentile in `lost_numbers`.

# Similar to R, we can retrive multiple quantile values by passing an array instead of a single value:
quantile(lost_numbers, [.025, .975]) # Returns the value located at 2.5th and 97.5th percentiles in `lost_numbers`.

# Handling Missing Data
# The nominator for missing values in Julia is `missing`. 
lost_numbers_miss = [4, 8, 15, missing, 23, 42]

# If we try to calculate the mean Julia would return `missing` due to the presence of missing values.
mean(lost_numbers_miss)
median(lost_numbers_miss)

# The`skipmissing()` function is intended to tackle this problem:
mean(skipmissing(lost_numbers_miss)) # Mean, excluding 'missing'.
std(skipmissing(lost_numbers_miss)) # Standard deviation, excluding 'missing'.

# When working with matrices, we sometimes have to perform statistical calculations across rows or columns. We can do this by passing argument to `dims`.

matrix_example = [1 72; 23 4] # Defines a 2x2 matrix.

# Calculation across columns.
mean(matrix_example, dims = 1) # Mean across columns.
std(matrix_example, dims = 1) # Standard deviation.
median(matrix_example, dims = 1) # Median.

# Calculation across rows.
mean(matrix_example, dims = 2) # Mean across rows.
std(matrix_example, dims = 2) # Standard deviation.
median(matrix_example, dims = 2) # Median.

# If we fail to pass argument to `dims` Julia would reduce the matrix into an array and spit out a single statistic.
mean(matrix_example) # Mean of all values in `matrix_example`.
std(matrix_example) # Standard deviation.
median(matrix_example) # Median.

vals = [4, 3, 2, 2, 3, 4, 5, 6, 7, 10] # Defines an array of numerical values.

# The `counts()` function calculates the frequency of each unique value in an array.
counts(vals) # Calculating counts in `vals`.

# The `proportions()` function computes the proportion (relative frequency) of each unique value in an array.
proportions(vals) # Returns the proportion (relative frequency) of each unique value in 'vals'.

# The `zscore()` function computes the z-scores for each value in an array.
zscore(vals) # Returns an array of z-scores for each value in `vals`.


### DISTRIBUTIONS ###
using Distributions, StatsPlots

# Defining a simple range to act as a population for sampling.
ran1 = 1:10

## Sampling with Replacement
# The `sample()` function is used to randomly select elements from a population. Here, we draw 25 samples from `ran1`. By default, sampling is with replacement.
sample(ran1, 25) # Draws 25 samples from the range `ran1`.

## Sampling without Replacement
# To draw samples without replacement, set `replace` to false.
sample(ran1, 5, replace = false) # Draws 5 unique samples from `ran1`.

## Sampling from Probability Distributions
# The Distributions package allows for creating and sampling from statistical distributions.
# Defining a Normal Distribution
dist1 = Normal(4, 2) # Creates a Normal distribution with mean = 4 and std dev = 2. 

# Drawing Samples from the Distribution
# The `rand()` function can be used to draw samples from a defined distribution.
samp1 = rand(dist1, 25) # Draws 25 samples from the Normal distribution `dist1`.

plot(dist1, lab = "Normal (4, 2)")
density!(samp1, lab = "Our Sample")

## Other Distribution Types
# Poisson Distribution
dist2 = Poisson(5) # Defines a Poisson distribution with lambda = 5.
samp2 = rand(dist2, 100) # Draws 100 samples from `dist2`.

plot(dist2, lab = "Poisson(5)")
density!(samp2, lab = "Our Sample")

# Uniform Distribution
dist3 = Uniform(-1, 1) # Defines a Uniform distribution between -1 and 1.
samp3 = rand(dist3, 100) # Draws 100 samples from `dist3`.

plot(dist3, lab = "Uniform(-1, 1)")
density!(samp3, lab = "Our Sample")

## Calculating Probability and Cumulative Densities
# Probability Density Function (pdf)
pdf(dist2, 4) # Calculates the probability of observing a value of 4 in a Poisson distribution with lambda = 5.

# Cumulative Distribution Function (cdf)
cdf(dist1, 4) # Calculates the cumulative probability of values up to 4 in the Normal distribution with mean = 4 and std dev = 2.

# Note: For more distribution options, check out the Distributions.jl documentation.


### GLM ###
using GLM, DataFrames, RDatasets

## OLS
midwest_dem_dat = RDatasets.dataset("ggplot2", "midwest")

select!(midwest_dem_dat, [:PopDensity, :PercBlack])

# `lm` is used to fit a linear regression model. Here, we directly use the @formula macro to specify the model.
m1 = lm(@formula(PopDensity ~ PercBlack), midwest_dem_dat)

# Alternative Model Specification
# You can also define the model formula separately and then pass it to `lm()`.
spec = @formula(PopDensity ~ PercBlack)
lm(spec, midwest_dem_dat)

# Retrieving Coefficient Estimates
# The `coef` function is used to extract the coefficient estimates from the fitted model.
coef(m1) # Returns the coefficients of the linear model `m1`.

# Illustration
scatter(midwest_dem_dat.PercBlack, midwest_dem_dat.PopDensity, ms = 2, msw = 0, color = :black, lab = :none)
Plots.abline!(coef(m1)..., color = :red, lab = "fit")

# `stederror()` gives standard error of coefficients:
stderror(m1) # Calculates the standard errors of the coefficient estimates.

# To extract predicted values, we can use the `predict()` function:
predict(m1) # Generates predicted values using the fitted model.

# For residuals:
residuals(m1) # Retrieves the residuals (differences between observed and predicted values).

# Confidence Intervals for Coefficients:
confint(m1) # Computes confidence intervals for the coefficient estimates.

# R-squared Value:
r2(m1) # Calculates the R-squared value, a measure of how well the model explains the observed data.

# Adjusted R-squared:
adjr2(m1) # Adjusted R^2 accounts for the number of predictors in the model, often more reliable than R^2 in multiple regression.

# Degrees of Freedom:
dof(m1) # Returns the degrees of freedom of the model.

# Variance-Covariance Matrix of Coefficients
vcov(m1) # Provides the variance-covariance matrix of the model's coefficients.

# Coefficient Table
coeftable(m1) # Displays a table with coefficients, standard errors, t-statistics, and p-values.

# Extracting Specific Statistics from Coefficient Table
# Accessing t-values and p-values from the coefficient table.
coeftable(m1).cols[3] # t-values of the coefficients.
coeftable(m1).cols[4] # p-values associated with the coefficients.    

## Probit/Logit Regression

women_workforce = RDatasets.dataset("car", "Womenlf")
select!(women_workforce, [:Partic, :HIncome])
women_workforce.Partic = map(x -> x == "not.work" ? 0 : 1, women_workforce.Partic)

describe(women_workforce)
# Fitting Generalized Linear Models (GLMs)

# The `glm()` function is used to fit generalized linear models. Here, a probit regression model is fitted:
m2 = glm(@formula(Partic ~ HIncome), women_workforce, Binomial(), ProbitLink())
# The model predicts `Partic` (binary outcome) using `HIncome` as a predictor. The `Binomial()` function specifies a binomial distribution of the response variable, and `ProbitLink()` specifies the probit link function.

# Illustration
scatter(women_workforce.HIncome, women_workforce.Partic, ms = 2, msw = 0, color = :black, lab = "Observations")
scatter!(women_workforce.HIncome, predict(m2), lab =  "Pred. Probability")


# For Logistic Regression Model, all we need to do is to change the link function into `ProbitLink()`:
m3 = glm(@formula(Partic ~ HIncome), women_workforce, Binomial(), LogitLink())

# Most of the functions we've seen on OLS are also applicable to Generalized Linear Models:
coef(m2) # Returns the coefficients of the model `m2`.
stderror(m2) # Calculates the standard errors of the coefficients.
predict(m2) # Returns predicted values.

# Since GLMs are estimated based on maximum likelihood, there are additional functions only applicable to them:

# Log-Likelihood
loglikelihood(m2) # Returns the log-likelihood of `m2`.

# Null Log-Likelihood
nullloglikelihood(m2) # Returns the log-likelihood of the null model for comparison.

# Akaike Information Criterion (AIC):
GLM.aic(m2) # Returns the AIC for `m2`.

# Bayesian Information Criterion (BIC):
GLM.bic(m2) # Returns the BIC for `m2`.

# Model Deviance
deviance(m2) # Returns the deviance of `m2`.

# Note: For other model options (i.e. Negative Binomial, Poisson, etc.), check out the GLM.jl documentation.