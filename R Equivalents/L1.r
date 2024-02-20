# 1.1
install.packages('tidyverse')

# 1.2
library(tidyverse)

# 2.1
x <- 1

# 2.2
class(x)

# 2.3
y <- 1.2

# 2.4
class(y)

# 2.5
z <- "Joe"

# 2.6
class(z)

# 2.7
t1 <- c(1, 2, 3)

# 2.8
class(t1)

# 2.9
t2 <- c(1, "a", 1.2)

# 2.10
k1 <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), 3, 3, byrow = T)

# 2.11
k2 <- matrix(c(1, 2, 3, "k", "l", "m"), 2, 3, byrow = T)

# 2.12
l1 <- 1:100

# 2.13
l2 <- seq(1, 5, by = .25)

# 2.14
# N/A

# 2.15
m1 <- 1
m2 <- 7.0

# 2.16
# N/A

# 2.17
# N/A

# 3.1
1 + 2

# 3.2
6 - .9

# 3.3
8 * 9

# 3.4
# N/A

# 3.5
9 / 2

# 3.6
19 %% 5

# 3.7
23^3

# 3.8
sqrt(12)

# 3.9
# N/A

# 3.10
log(3)

# 3.11
log10(3)

# 3.12
log(3, 23)

# 3.13
exp(4)

# 3.14
val <- 123

# 3.15
# N/A

# 3.16
# N/A

# 3.17
# N/A

# 3.18
# N/A

# 3.19
mat <- matrix(c(6, 7, 8, 9, 2, 3, 12, 8, 9), 3, 3, byrow = T)

# 3.20
mat2 <- matrix(c(1, 2, 3, 2, 3, 4, 3, 4, 5), 3, 3, byrow = F)

# 3.21
# N/A

# 3.22
# N/A

# 3.23 and 3.24
t(mat)

# 3.25
mat + mat

# 3.26
mat3 <- c(9, 2, 3)

# 3.27
mat %*% mat3

# 3.28
mat * 2

# 3.29
solve(mat)

# 3.30
dim(mat)

# 4.1
v1 <- c(1, 2, 3)

# 4.2
v2 <- c(2, 3, 4)

# 4.3
v3 <- c(3, 4, 5)

# 4.4
v3[2]

# 4.5
v3[1:3]

# 4.6
v3[c(1, 3)]

# 4.7
mat[1, 2]

# 4.8
mat[1:2, 3]

# 4.9
mat[1:3, c(1, 3)]

# 4.10
mat[1,]

# 4.11
mat[, 3]

# 4.12
# N/A

# 4.13
# N/A

# 4.14
s = "Jason"

# 4.15
# N/A

# 4.16
# N/A

# 4.17
# N/A

# 5.1
a <- -1.28323

# 5.2
round(a)

# 5.3
ceiling(a)

# 5.4
floor(a)

# 5.5
a2 <- 7

# 5.6
# N/A

# 5.7
# N/A

# 5.8
b <- c(9, 3, 1, 1, -3)

# 5.9
sum(b)

# 5.10
prod(b)

# 5.11
length(b)

# 5.12
# N/A

# 5.13
# N/A

# 5.14
# N/A

# 5.15
# N/A

# 5.16
which(b == 1)

# 5.17
unique(b)

# 5.18
sort(b)

# 5.19
rev(b)

# 5.20
rep(b, 10)

# 5.21
max(b)

# 5.22
min(b)

# 5.23
which.max(b)

# 5.24
which.min(b)

# 5.25
b <- append(b, 2)

# 5.26
b <- append(2, b)

# 5.27
b <- b[-length(b)]

# 5.28
b <- b[-1]

# 5.29
b <- b[-3]

# 5.30
b2 <- c(8, 2, 3, 1, 4)

# 5.31
union(b, b2)

# 5.32
intersect(b, b2)

# 5.33
setdiff(b, b2)

# 5.34
union(1:10, 5:15)

# 5.35
setdiff(1:10, 5:15)

# 5.36
c <- matrix(c(1, 2, 3, 4, 5, 6), 2, 3, byrow =  T)

# 5.37
# N/A

# 5.38
# N/A

# 5.39
# N/A

# 6.1
2 > 6

# 6.2
3 >= -2

# 6.3
all.equal(2, 2)

# 6.4
2 == 2

# 6.5
2 > 6 || 6 > 2

# 6.6
2 > 6 && 6 > 2

# 6.7
!(2 > 6)

# 6.8
1 %in% c(1, 2, 3)

# 6.9
3 %in% c(2, 8, 9, 23)

# 7.1
add2 <- function(input){
    output <- input + 2
    return(output)
    end}

# 7.2
add2(3)

# 7.3
add2(23)

# 7.4
complex_function <- function(input1, input2, input3){
    output <- 6*input1^2 + 12*input2 + 92*input3 - (987*input1*input2*input3)^(1/3)
    return(output)
}

# 7.5
complex_function(2, 45, 87)

# 7.6
vals <- seq(983, 9962, by = 73)

# 7.7
store1 <- c(runif(length(vals)))

# 7.8
for (i in 1:124){
    store1[i] <- add2(vals[i])
}

# 7.9
# N/A

# 7.10
# N/A

# 7.11
sapply(vals, add2)

# 7.12
mapply(complex_function, 1:100, 1:100, 1:100)

# 7.13
# N/A

# 7.14
# N/A

# 7.15
# N/A

# 7.16
# N/A

# 7.17
# N/A

# 7.18
t0 <- Sys.time()
for (i in 1:10^6){
    i^2 + 3*i + 7
}
t1 <- Sys.time()
t1 - t0

# 7.19
set.seed(123)