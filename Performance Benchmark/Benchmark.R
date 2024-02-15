set.seed(123)

y <- rbinom(10^5, 1, .45)
x1 <- rnorm(10^5)
x2 <- rnorm(10^5)
x3 <- rnorm(10^5)
x4 <- rnorm(10^5)
x5 <- rnorm(10^5)

dat <- data.frame(Y = y, X1 = x1, X2 = x2, X3 = x3, X4 = x4, X5 = x5)


### Logit Regression Permutation Hypothesis Test
t0 <- Sys.time()
replicate(10^3, coef(glm(Y ~ X1 + X2 + X3 + X4 + X5, data.frame(Y = y, X1 = sample(dat$X1, 10^5, replace = F), X2 = x2, X3 = x3, X4 = x4, X5 = x5), family = binomial(link = "logit")))[2])
t1 <- Sys.time()
t1 - t0 # 1.764469 mins

### 1. Generating New Variable of 100 Thousand Observations w/ for-loop
t0 <- Sys.time()
dat_store <- rnorm(nrow(dat))
for (i in 1:nrow(dat)){
  dat_store[i] <- dat$X1[i]^(9) + exp(dat$X2[i]) + cos(dat$X3[i]) + pnorm(dat$X4[i]) + sqrt(abs(.823*dat$X5[i]))
} 
t1 <- Sys.time()
t1 - t0 # 0.3119791 secs

### 2. Generating a Dataset of 10 Million Observations
t0 <- Sys.time()
dat2 <- data.frame(matrix(rnorm(9*10^7), nrow = 10^7, ncol = 9))
t1 <- Sys.time()
t1 - t0 # 3.244523 secs

### 4. Generating a New Variable of 10 Million Observations w/o for-loop
t0 <- Sys.time()
dat2$X10 <- ifelse(dat2$X1 > 0, "P", "N")
t1 <- Sys.time()
t1 - t0 # 1.180605 secs

### 5. Merging a Dataset of 10 Million Observations on 1 Key 
dat3 <- data.frame(X10 = c("P", "N"), X11 = c(723, 327))
t0 <- Sys.time()
merge(dat2, dat3, by = "X10", all.x = T)
t1 <- Sys.time()
t1 - t0 # 15.34361 secs

### 6. Merging a Dataset of 10 Million Observations on 2 Keys
dat2$X11 <- sample(c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "X", "W", "Y", "Z"), 10^7, replace = T)
dat4 <- data.frame(X11 = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "X", "W", "Y", "Z"), X10 = sample(c("P", "N"), 25, replace = T), X12 = rnorm(25))
t0 <- Sys.time()
merge(dat2, dat4, by = c("X10", "X11"), all.x = T)
t1 <- Sys.time()
t1 - t0 # 27.90119 secs