include("Practice Questions/L3 - Practice.jl")

## 1.1
dat = DataFrame(v1 = rand(Normal(0, 1), 100), v2 = rand(Uniform(-1, 1), 100), v3 = rand(Poisson(5), 100))

## 1.2
rename!(dat, [:stdnorm, :uniform, :pois5])
names(dat)

## 1.3
dat_truncated = dat[1:25, :]
# Alternatively:
first(dat, 25)

## 1.4
dat_truncated2 = dat[:, [:stdnorm, :uniform]]

## 1.5
describe(dat)
describe(dat_truncated)
describe(dat_truncated2)


## 2.1
sort(horsekick, [:Y], rev = true)[1:15, :]

## 2.2
sort(horsekick, [:Y, :Year], rev = [true, false])[1:15, :]

## 2.3
sort(select(horsekick, [:Y, :Corp]), :Y, rev = true)[1:15, :]

## 2.4
select(horsekick, Cols(x -> startswith(x, "Y")))


## 3.1
subset(horsekick, :Y => ByRow(x -> x != 0))

## 3.2
sort(subset(horsekick, :Year => ByRow(x -> x == 80)), rev = true)

## 3.3
horsekick_withdeaths = subset(horsekick, :Y => ByRow(x -> x != 0))
subset(horsekick_withdeaths, :Corp => ByRow(x -> x == "XIV"))
# Alternatively:
subset(horsekick, [:Y, :Corp] => ByRow((x, y) -> x != 0 && y == "XIV"))

## 3.4
transform(horsekick, :Year => ByRow(x -> x + 1800))

## 3.5
horsekick_X = subset(horsekick, :Corp => ByRow(x -> x == "X"))
transform(horsekick_X, :Y => ByRow(x -> x + 2), renamecols = false)
# Alternatively:
transform(horsekick, [:Y, :Corp] => ByRow((x, y) -> y == "X" ? x = x + 2 : x))


## 4.1
horsekick_grouped = groupby(horsekick, :Corp)

## 4.2
horsekick_grouped[2]

## 4.3
horsekick_grouped_2 = groupby(horsekick, :Year)
horsekick_grouped_sum_2 = combine(horsekick_grouped_2, :Y => sum)
sort(horsekick_grouped_sum_2, :Y_sum, rev = true)

## 4.4
horsekick_grouped_3 = groupby(horsekick, :Corp)
horsekick_grouped_sum_3 = combine(horsekick_grouped_3, :Y => sum)
sort(horsekick_grouped_sum_3, :Y_sum, rev = true)