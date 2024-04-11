library(tidyverse)

# 0.1
set.seed(12345)


# 1.1
v1 <- runif(25, 0, 1)

# 1.2
ggplot() +
geom_line(aes(1:25, v1))

# 1.3
ggplot() +
geom_point(aes(1:25, v1))


# 2.1
ggplot() +
geom_point(aes(1:25, v1), color = 'red')

# 2.2
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4)

# 2.3
# N/A

# 2.4
# N/A

# 2.5
# N/A

# 2.6
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4) +
labs(title = "SOME PLOT")

# 2.7
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4) +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25)

# 2.8
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4) +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25) +
scale_y_continuous(breaks = seq(.1, 1, .1))

# 2.9
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4) +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25, limits = c(-5, 30)) +
scale_y_continuous(breaks = seq(.1, 1, .1))

# 2.10
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4) +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25, limits = c(-5, 30)) +
scale_y_continuous(breaks = seq(.1, 1, .1), limits = c(-1, 2))

# 2.11
ggplot() +
geom_point(aes(1:25, v1), color = 'red', size = 4, shape = 11) +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25, limits = c(-5, 30)) +
scale_y_continuous(breaks = seq(.1, 1, .1), limits = c(-1, 2))

# 2.12
# N/A

# 2.13
ggplot() +
geom_line(aes(1:25, v1), color = 'red') +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25, limits = c(-5, 30)) +
scale_y_continuous(breaks = seq(.1, 1, .1), limits = c(-1, 2))

# 2.14
ggplot() +
geom_line(aes(1:25, v1), color = 'red') +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25, limits = c(-5, 30)) +
scale_y_continuous(breaks = seq(.1, 1, .1), limits = c(-1, 2))

# 2.15
# N/A

# 2.16
# N/A


# 3.1
ggplot() +
geom_line(aes(1:25, v1), color = 'red') +
geom_point(aes(1:25, v1), color = 'red') +
labs(title = "SOME PLOT") +
scale_x_continuous(breaks = 1:25) +
scale_y_continuous(breaks = seq(.1, 1, .1))


# 4.1
cars_data <- mtcars

# 4.2
ggplot(count(cars_data, cyl)) +
geom_bar(aes(cyl, n), stat = 'identity')

# 4.3
ggplot(count(cars_data, cyl)) +
geom_bar(aes(cyl, n, fill = as_factor(cyl)), stat = 'identity') +
scale_fill_manual(values = c('red', 'yellow', 'blue', 'orange'))

# 4.4
ggplot(count(cars_data, cyl)) +
geom_bar(aes(cyl, n, fill = as_factor(cyl)), stat = 'identity', width = 1.25) +
scale_fill_manual(values = c('red', 'yellow', 'blue', 'orange'))

# 4.5
# N/A

# 4.6
ggplot(cars_data) +
geom_histogram(aes(cyl))

# 4.7
ggplot(cars_data) +
geom_histogram(aes(cyl), fill = 'cyan') # Some functionalities unavailable.

# 4.8
# N/A

# 4.9
ggplot(cars_data) +
geom_histogram(aes(cyl, fill = as_factor(vs)), position = 'dodge')

# 4.10
ggplot(cars_data) +
geom_boxplot(aes(as_factor(cyl), disp))

# 4.11
ggplot(cars_data) +
geom_jitter(aes(x = as_factor(cyl), y = disp))

# 4.12
ggplot(cars_data) +
geom_violin(aes(x = as_factor(cyl), y = disp))

# 4.13
# N/A

# 4.14
# N/A

# 4.15
ggplot(cars_data) +
geom_density(aes(disp))

# 4.16
ggplot(cars_data) +
geom_density(aes(disp), fill = 'orange', alpha = .5)

# 4.17
# N/A

# 4.18
ggplot(cars_data) +
geom_density(aes(disp, group = cyl))

# 4.19
# N/A

# 4.20
ggplot() +
geom_pointrange(aes(x = 1:5, y = sample(1:5, 5), ymin = sample(-5:-1, 5), ymax = sample(6:10, 5)))

# 4.21
ggplot(cars_data) +
geom_qq(aes(sample = mpg)) +
geom_qq_line(aes(sample = mpg))

# 4.22
ggplot(cars_data) +
geom_qq(aes(sample = mpg), size = 5) +
geom_qq_line(aes(sample = mpg))


# 5.1
# N/A

# 5.2
# N/A

# 5.3
# N/A

# 5.4
# N/A

# 5.5
# N/A


# 6.1
ggplot() +
geom_function(fun = function(x) 3*x^2 + 2)

# 6.2
ggplot() +
geom_function(fun = function(x) pi*x^3)

# 6.3
ggplot() +
stat_function(fun = dnorm, args = list(mean = 8, sd = 5)) +
xlim(-2, 18)

# 6.4
ggplot() +
stat_function(fun = dpois, args = list(lambda = 3), geom = 'bar') +
xlim(0, 10)


# 7.1
# N/A

# 7.2
# N/A

# 7.3
# N/A

# 7.4
# N/A


# 8.1
# N/A

# 8.2
# N/A


# 9.1
# N/A

# 9.2
# N/A

# 9.3
# N/A

# 9.4
# N/A

# 9.5
# N/A