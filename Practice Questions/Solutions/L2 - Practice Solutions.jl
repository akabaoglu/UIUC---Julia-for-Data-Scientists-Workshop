include("Practice Questions/L2 - Practice.jl")

## 1.1
mean(v1)
median(v1)
std(v1)

## 1.2
quantile(v1, [.15, .85])

## 1.3
mean(skipmissing(v_miss))
median(skipmissing(v_miss))
std(skipmissing(v_miss))

## 1.4
counts(v2)
# Alternatively, using the `filter()` function:
length(filter(x -> x == 2, v2))

## 1.5
draw = rand(10:17, 5000)
proportions(draw)[4]
# Alternatively, using the `filter()` function, again:
length(filter(x -> x == 13, draw))/length(draw)


## 2.1
dist1, dist2 = Normal(10, 10), Uniform(0, 20)

## 2.2
cdf(dist1, 4)
cdf(dist2, 4)
# Or, alternatively:
cdf.([dist1, dist2], 4)

## 2.3
pdf(Poisson(3), 4)

## 2.4
samp_pois = rand(Poisson(3), 10^6)
proportions(samp_pois)[5]

## 2.5
zscore(samp_pois)


## 3.0
describe(pol_admission)

## 3.1
m_ols = lm(@formula(PT ~ GREVerbal), pol_admission)

## 3.2
m_ols_error = residuals(m_ols)
density(m_ols_error)

## 3.3
m_logit = glm(@formula(PT ~ GREVerbal), pol_admission, Binomial(), LogitLink())
m_probit = glm(@formula(PT ~ GREVerbal), pol_admission, Binomial(), ProbitLink())

## 3.4
loglikelihood(m_logit)
loglikelihood(m_probit)
# Or, alternatively:
loglikelihood.([m_logit, m_probit])

## 3.5
est_mean = coef(m_probit)[2]
est_stderr = stderror(m_probit)[2]
est_dist = Normal(est_mean, est_stderr)
plot(est_dist)


## A.1
d1 = Normal(5, 3)
obs1 = rand(d1, 100)

## A.2
d2 = Poisson(5)
obs2 = rand(d2, 100)

## A.3
my_mat = [obs1 obs2]

## A.4
dist_mean = mean(my_mat, dims = 1)
dist_median = median(my_mat, dims = 1)
# Or, alternatively:
my_mat_vectorized = eachcol(my_mat)
mean.(my_mat_vectorized)
median.(my_mat_vectorized)

## A.5
dist_mean .- dist_median