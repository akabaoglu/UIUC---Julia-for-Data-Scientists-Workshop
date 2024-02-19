library(tidyverse)

# 1.1
set.seed(123)

# 1.2
var1 <- rnorm(100, 0, 1)

# 1.3
var2 <- rpois(100, 5)

# 1.4
var3 <- runif(100, -10, 10)

# 1.5
df <- data.frame(Y = var1, X1 = var2, X2 = var3)

# 1.6
# N/A

# 1.7
# N/A

# 1.8
# N/A

# 1.9
# N/A

# 1.10
df$Y

# 1.11
df[, c("X1", "X2")]

# 1.12
df[1:15, c("X1", "X2")]

# 1.13
df$X3 <- 1:100

# 1.14
summary(df)

# 1.15
head(df)

# 1.16
head(df, 5)

# 1.17
tail(df)

# 1.18
tail(df, 5)

# 1.19
nrow(df)

# 1.20
ncol(df)


# 2.1
arrange(df, X1)

# 2.2
arrange(df, desc(X1))

# 2.3
arrange(df, X1, X2)

# 2.4
arrange(df, desc(X1), X2)

# 2.5
# N/A


# 3.1
select(df, Y, X1, X2)

# 3.2
select(df, -X3)

# 3.3
select(df, X1:X3)

# 3.4
select(df, starts_with("X"))

# 3.5
select(df, ends_with("2"))

# 3.6
select(df, contains("X"))

# 3.7
select(df, -contains("X"))

# 3.8
# N/A


# 4.1
filter(df, Y > 0)

# 4.2
filter(df, Y > 0)

# 4.3
filter(df, Y > 0 | X1 < 5)

# 4.4
filter(df, X1 %in% c(1, 3, 6))

# 4.5
# N/A


# 5.1
mutate(df, sqrt(X1))

# 5.2
mutate(df, sqrt(X1))

# 5.3
mutate(df, X1_new = X1 + 2)

# 5.4
mutate(df, X1_X2_function = 2*X1 + 3*X2)

# 5.5
# N/A


# 6.1
df_grouped <- group_by(df, X1)

# 6.2
# N/A

# 6.3
summarize(df_grouped, Mean_Y = mean(Y))

# 6.4
summarize(df_grouped, mean(Y))

# 6.5
summarize(df_grouped, var(Y))

# 6.6
summarize(df_grouped, mean(Y) - min(Y))

# 6.7
summarize(df_grouped, across(c(Y, X2), mean))

# 6.8
summarize(df_grouped, across(c(Y, X2), mean, .names = "{.col}_new"))

# 6.9
# N/A

# 6.10
summarise(df_grouped, head(Y, 3))

# 6.11
summarise(df_grouped, tail(Y, 5))


# 7.1
df2 <- select(midwest, 1:6)

# 7.2
df2 <- filter(df2, state == "IL")

# 7.3
df2_stacked <- pivot_longer(df2, c(area, poptotal, popdensity))

# 7.4
filter(df2_stacked, county == "ADAMS") 

# 7.5
pivot_wider(df2_stacked, names_from = name,  values_from = value)


# 8.1
df3 <- data.frame(KEY = c("A", "B", "C", "D", "E"), V1 = rnorm(5))

# 8.2
df4 <- data.frame(KEY = sample(c("A", "B", "C", "D", "E", "F"), 100, replace = T), V2 = rnorm(100))

# 8.3
left_join(df3, df4, by = "KEY")

# 8.4
right_join(df3, df4, by = "KEY")

# 8.5
inner_join(df3, df4, by = "KEY")

# 8.6
# N/A

# 8.7
df5 <- data.frame(KEY1 = c("A", "B", "C", "D", "E"), V1 = rnorm(5))

# 8.8
df6 <- data.frame(KEY2 = sample(c("A", "B", "C", "D", "E", "F"), 100, replace = T), V2 = rnorm(100))

# 8.9
df7 = right_join(df5, df6, by = c("KEY1" = "KEY2"))


# 9.1
drop_na(df7)

# 9.2
replace_na(df7, list(V1 = -99))

# 9.3
mean(df7$V1, na.rm = T)