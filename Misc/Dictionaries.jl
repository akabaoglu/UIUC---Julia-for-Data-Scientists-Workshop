using DataFrames, Distributions, Random

Random.seed!(123)

df = DataFrame(Var1 = sample(1:10, 10^2))

d1 = Dict(1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "E", 6 => "F", 7 => "G", 8 => "H", 9 => "I", 10 => "J")

d1[1]
d1[6]
d1[10]

transform(df, :Var1 => ByRow(x -> d1[x]))