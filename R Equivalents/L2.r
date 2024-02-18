library(tidyverse)
library(car)

# 1.1
lost_numbers <- c(4, 8, 15, 16, 23, 42)

# 1.2
mean(lost_numbers)

# 1.3
# N/A

# 1.4
# N/A

# 1.5
median(lost_numbers)

# 1.6
sd(lost_numbers)

# 1.7
quantile(lost_numbers, .05)

# 1.8
quantile(lost_numbers, c(.025, .975))

# 1.9
lost_numbers_miss <- c(4, 8, 15, NA, 23, 42)

# 1.10
mean(lost_numbers_miss)

# 1.11
median(lost_numbers_miss)

# 1.12
mean(lost_numbers_miss, na.rm = T)

# 1.13
median(lost_numbers_miss, na.rm = T)

# 1.14
matrix_example <- matrix(c(1, 72, 23, 4), 2, 2, byrow = T)

# 1.15
colMeans(matrix_example)

# 1.16
# N/A

# 1.17
# N/A

# 1.18
rowMeans(matrix_example)

# 1.19
# N/A

# 1.20
# N/A

# 1.21
mean(matrix_example)

# 1.22
sd(matrix_example)

# 1.23
median(matrix_example)

# 1.24
vals <- c(4, 3, 2, 2, 3, 4, 5, 6, 7, 10)

# 1.25
table(vals)

# 1.26
# N/A

# 1.27
# N/A

# 2.1
ran1 <- 1:10

# 2.2
sample(ran1, 25, replace = T)

# 2.3
sample(ran1, 25, replace = F)

# 2.4
# N/A

# 2.5
samp1 <- rnorm(25, 4, 2)

# 2.6
ggplot() +
    stat_function(fun = dnorm, args = list(mean = 4, sd = 2), color = 'tomato2') +
    geom_density(aes(x = samp1), color = 'navyblue')

# 2.7
# N/A

# 2.8
samp2 <- rpois(100, 5)

# 2.9
ggplot() +
    stat_function(fun = dpois, args = list(lambda = 5), color = 'tomato2') +
    geom_density(aes(x = samp2), color = 'navyblue') + 
    xlim(0, 20)

# 2.10
# N/A

# 2.11
samp3 <- runif(100, -1, 1)

# 2.12
ggplot() +
    stat_function(fun = dunif, args = list(min = -1, max = 1), color = 'tomato2') +
    geom_density(aes(x = samp3), color = 'navyblue') + 
    xlim(-1, 1)

# 2.13
dpois(4, 5)

# 2.14
pnorm(4, 4, 2)

# 3.1
midwest_dem_dat <- midwest

# 3.2
midwest_dem_dat <- select(midwest_dem_dat, popdensity, percblack)

# 3.3
m1 <- lm(popdensity ~ percblack, midwest_dem_dat)

# 3.4
# N/A

# 3.5
# N/A

# 3.6
coef(m1)

# 3.7
ggplot(midwest_dem_dat) +
    geom_point(aes(x = percblack, y = popdensity)) +
    geom_abline(aes(intercept = coef(m1)[1], slope = coef(m1)[1]))

# 3.8
# N/A

# 3.9
predict(m1)

# 3.10
residuals(m1)

# 3.11
confint(m1)

# 3.12
summary(m1)$r.squared

# 3.13
summary(m1)$adj.r.squared

# 3.14
vcov(m1)

# 3.15
summary(m1)

# 3.16
summary(m1)[["coefficients"]][, "t value"]

# 3.17
summary(m1)[["coefficients"]][, "Pr(>|t|)"]

# 3.18
women_workforce <- Womenlf

# 3.19
women_workforce <- select(women_workforce, partic, hincome)

# 3.20
women_workforce$partic <- sapply(women_workforce$partic, function(x) ifelse(x == "not.work", 0, 1))

# 3.21
summary(women_workforce)

# 3.22
m2 <- glm(partic ~ hincome, women_workforce, family = binomial(link = "probit"))

# 3.23
ggplot(women_workforce) +
    geom_point(aes(x = hincome, y = partic), color = 'tomato2') +
    geom_point(aes(x = women_workforce$hincome, pnorm(predict(m2))), color = 'navyblue')

# 3.24
m3 <- glm(partic ~ hincome, women_workforce, family = binomial(link = "logit"))

# 3.25
coef(m2)

# 3.26
# N/A

# 3.27
pnorm(predict(m2))

# 3.28
logLik(m2)

# 3.29
# N/A

# 3.30
AIC(m2)

# 3.31
BIC(m2)

# 3.32
deviance(m2)
