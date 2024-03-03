using Random, Statistics, StatsBase, Distributions, GLM, RDatasets, DataFrames, Plots, StatsPlots
Random.seed!(123)


### SECTION 1: STATISTICAL OPERATIONS

## 1.1
# The following line defines a new object, `v1`, consisting of random values between 0 and 1:
v1 = rand(100)
# Please find the mean, median, and standard deviation of `v1`.


## 1.2 
# Please find the 0.15 and 0.85 quantile values of `v1`.


## 1.3
# The following line of code replaces all values between 0.35 and 0.45 in `v1` with missing values and stores the new vector in `v_miss`:
v_miss = map(x -> x < .45 && x > .35 ? missing : x, v1)
# Please now find the mean, median, and standard deviation of `v_miss`.


## 1.4
# The following line creates a new object, `v2`, which consists of 500 random draws from the interval 1:10:
v2 = rand(1:10, 500)
# Please find how many 2s are present in `v2`.


## 1.5
# Please now draw 5000 numbers from the interval 10:17 and find the proportion of observations equal to 13.



### SECTION 2: DISTRIBUTIONS

## 2.1
# Please create two objects, `dist1` and `dist2`, which are respectively equivalent to a Normal distribution with a mean of 10 and standard deviation of 10, and a Uniform distribution with a minimum of 0 and maximum of 20.


## 2.2
# Please compare `dist1` and `dist2` with regard to the probability of drawing a value less than 3 from these distributions. (Hint: The `cdf()` function might be helpful.)


## 2.3
# Please find the probability of drawing a 4 from a Poisson distribution with lambda equal to 3, using the `pdf()` function.


## 2.4
# Assume we do not have the `pdf()` function available and need to approximate the previous question through simulation. To do this, please first draw 1 million values from the Poisson distribution with lambda equal to 3 (save it as `sample_pois`) and then calculate the proportion of values in the drawn sample equal to 4.


## 2.5
# Finally, standardize the values in `sample_pois`.



### SECTION 3: OLS AND LOGIT/PROBIT REGRESSION

# 3.0
# In this section, we'll be working with a dataset of applicants to Stanford's Political Science PhD program. The dataset contains 106 observations across 6 variables: Score, GREQuant, GREVerbal, AP, PT, and Female. Score is an ordinal metric of applicant quality defined between 1 and 5, as evaluated by the admissions committee (the higher the score, the more qualified an applicant is deemed to be). GREQuant and GREVerbal are the applicant's scores from the Quantitative and Verbal sections of the GRE, respectively. AP and PT are dummy variables for whether the applicant is interested in American Politics and Political Theory, respectively. Finally, Female is a dummy indicator of the applicant's gender. For more detailed information, see Political Analysis, Vol. 12, No. 4, Special Issue on Bayesian Methods (Autumn 2004), pp. 400-424.
pol_admission = RDatasets.dataset("pscl", "admit")

# To get a sense of the dataset, you can use the `describe()` function.


## 3.1 
# Please estimate the linear association between applicants' interest in Political Theory and their score on the Verbal section of the GRE, using Ordinary Least Squares regression. (You may want to save the model in an object, say `m_ols`, for future use.)


## 3.2
# Extract the residuals from OLS estimates from the previous question and create a density plot of them to check whether the model satisfies the assumption of normally distributed errors. (Hint: To create a density plot, you can pass the residuals to the `density()` function.)


## 3.3
# Now, estimate the same association using Logit and Probit regressions. (You may want to save the models in objects, say `m_probit` and `m_logit`, for future use.)


## 3.4
# Compare the Logit and Probit models estimated in the previous question with regard to goodness-of-fit, using their loglikelihood values.


## 3.5 
# Visualize the Probit model estimates of the association between `GREVerbal` and `PT` by (1) creating a Normal distribution with the mean equal to the coefficient estimate and standard deviation equal to the standard error of the estimates, and (2) passing this distribution to the plot() function.



### APPENDIX: WORKSHOP 1 REVIEW

## A.1
# Define a new object, `d1`, equal to the Normal distribution with a mean of 5 and standard deviation of 3. Draw 101 observations from `d1` and save them into a new object named `obs1`.


## A.2
# Define another object, `d2`, equal to the Poisson distribution with lambda equal to 5. Draw 101 observations from `d2` and save them into a new object, `obs2`.


## A.3
# Create a matrix in which each column corresponds to draws from the previous distributions, `obs1` and `obs2`, and save it into a new object, `my_mat`.


## A.4 
# Now, assuming we don't have `obs1` and `obs2` defined in our workspace, calculate their mean and median using `my_mat`. Don't forget to save them into new objects, `dist_mean` and `dist_median`.


## A.5
# Finally, calculate the difference between the mean and median values using `dist_mean` and `dist_median`. (Hint: Broadcasting from the previous workshop might be helpful.)

