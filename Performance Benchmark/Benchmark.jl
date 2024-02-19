using DataFrames, GLM, Distributions, Random

Random.seed!(123)

y = rand(Binomial(1, .45), 10^5)
x = eachcol(rand(Normal(), 10^5, 5))
dat = DataFrame(Y = y, X1 = x[1], X2 = x[2], X3 = x[3], X4 = x[4], X5 = x[5])


### 1. Logit Regression Permutation Hypothesis Test
glm(@formula(Y ~ X1 + X2 + X3 + X4 + X5), dat, Binomial(), LogitLink())

@time [let dat_temp = DataFrame(Y = y, X1 = sample(x[1], 10^5, replace = false), X2 = x[2], X3 = x[3], X4 = x[4], X5 = x[5]); coef(glm(@formula(Y ~ X1 + X2 + X3 + X4 + X5), dat_temp, Binomial(), LogitLink()))[2] end for _ in 1:10^3] # 25.661255 seconds

### 2. Generating New Variable of 100 Thousand Observations w/ for-loop
@time begin 
    dat_store = Array{Float64}(undef, nrow(dat))
    for i in 1:nrow(dat)
    dat_store[i] = dat.X1[i]^(9) + exp(dat.X2[i]) + cos(dat.X3[i]) + pdf(Normal(), dat.X4[i]) + sqrt(abs(.823dat.X5[i]))
    end
end # 0.140013 seconds

### 3. Generating a Dataset of 10 Million Observations
@time dat2 = DataFrame(rand(Normal(), 10^7, 9), :auto) # 0.450528 seconds

### 4. Generating a New Variable of 10 Million Observations w/o for-loop
@time transform!(dat2, :x1 => ByRow(x -> x > 0 ? "P" : "N") => :x10) # 0.086699 seconds

### 5. Merging a Dataset of 10 Million Observations on 1 Key 
dat3 = DataFrame(x10 = ["P", "N"], x11 = [723, 327])
@time leftjoin(dat2, dat3, on = :x10) # 1.363134 seconds

### 6. Merging a Dataset of 10 Million Observations on 2 Keys
dat2.x11 = rand(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "X", "W", "Y", "Z"], 10^7)
dat4 = DataFrame(x11 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "X", "W", "Y", "Z"], x10 = rand(["P", "N"], 25), x12 = rand(25))
@time leftjoin(dat2, dat4, on = [:x10, :x11]) # 1.540814 seconds

### 7. Applying a function with multiple inputs to a dataset of 10 million values
@time map((x, y, z) -> x^2 + 2*y + exp(z), dat2.x1, dat2.x2, dat2.x3) # 0.303075 seconds

### 8. Monte Carlo Sensitivity Analysis
using Distributions, DataFrames, GLM
@time begin
function sens(q, r)
    vals = rand(MvNormal([0, 0, 0], [1 q r; q 1 .2; r .2 1]), 10^3)'
    df = DataFrame(X1 = vals[:, 1], X2 = vals[:, 2], Y = vals[:, 3])
    m = lm(@formula(Y ~ X1 + X2), df)
    return coeftable(m).cols[4][3]
end
ran = sqrt.(0:.025:.5)
p_means = [mean([sens(a, b) for _ in 1:25]) for a in ran, b in ran]
end # 1.348262 seconds