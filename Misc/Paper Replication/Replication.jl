using DataFrames, Plots, CSV, ExcelReaders, RData, StatsPlots, Statistics, StatsBase, GLM, RegressionTables, Distributions, StatsFuns, LaTeXStrings

nmc = CSV.read("Misc/Paper Replication/Data/NMC-60-abridged.csv", DataFrame)
select!(nmc, [2, 3, 10])

mid_targets = CSV.read("Misc/Paper Replication/Data/dyadic_mid_4.02.csv", DataFrame)
select!(mid_targets, [:statea, :namea, :stateb, :nameb, :strtyr, :orignatb, :hihostb])
subset!(mid_targets, [:orignatb, :hihostb] => ByRow((x, y) -> x == 1 && y > 3))
select!(mid_targets, [1, 2, 5])
unique!(mid_targets)
mid_targets.mid_target = ones(nrow(mid_targets))

alliance = CSV.read("Misc/Paper Replication/Data/alliance_v4.1_by_directed_yearly.csv", DataFrame)

cow_trade = CSV.read("Misc/Paper Replication/Data/cow_trade_dyad.csv", DataFrame)
select!(cow_trade, [1, 2, 3, 6, 7])

polity_v = DataFrame(readxlsheet("Misc/Paper Replication/Data/p5v2018.xls", "p5v2018", skipstartrows = 1), :auto)
select!(polity_v, [3, 6, 11])
rename!(polity_v, ["ccode", "year", "polity"])

dfAgree = load("Misc/Paper Replication/Data/AgreementScores.Rdata")["dfAgree"]

cap_dist = CSV.read("Misc/Paper Replication/Data/capdist.csv", DataFrame)


### Data Cleaning
dat = subset(alliance, :defense => ByRow(x -> x == 1))
select!(dat, [2, 3, 4, 5, 18])
subset!(dat, :ccode2 => ByRow(x -> !(x in [2, 200, 220, 710, 365])))
unique!(dat)
leftjoin!(dat, nmc, on = [:ccode1 => :ccode, :year])
leftjoin!(dat, nmc, on = [:ccode2 => :ccode, :year], makeunique = true)
rename!(dat, Dict(:cinc => "cinc1", :cinc_1 => "cinc2"))
leftjoin!(dat, select(mid_targets, Not(2)), on = [:year => :strtyr, :ccode2 => :statea])
transform!(dat, :mid_target => ByRow(x -> ismissing(x) ? 0 : 1), renamecols = false)
leftjoin!(dat, cow_trade, on = [:ccode1, :ccode2, :year])
transform!(dat, [:flow1, :flow2] .=> ByRow(x -> if ismissing(x); return missing; elseif x == -9; return missing; else return x end), renamecols = false)
transform!(dat, [:flow1, :flow2] => ByRow((x, y) -> x + y) => :tradevol)
leftjoin!(dat, polity_v, on = [:ccode1 => :ccode, :year])
leftjoin!(dat, polity_v, on = [:ccode2 => :ccode, :year], makeunique = true)
rename!(dat, Dict(:polity => "polity1", :polity_1 => "polity2"))
transform!(dat, [:polity1, :polity2] => ByRow((x, y) -> coalesce(x, 0) >= 6 && coalesce(y, 0) >= 6 ? 1 : 0) => :dem_dyad)
leftjoin!(dat, select(dfAgree, 2:5), on = ["ccode1", "ccode2", "year"])
rename!(dat, Dict(:agree => "un_vote"))
transform!(dat, :cinc1 => ByRow(x -> log(x)), renamecols = false)
transform!(dat, :tradevol => ByRow(x -> log(x)) => :log_trade)
transform!(dat, :log_trade => ByRow(x ->  ismissing(x) ? missing : x == -Inf ? -15 : x), renamecols = false)
dat.mid_target_l1 = map(x -> length(x) == 0 ? missing : x[1], map((x, y, z) -> subset(dat, [:ccode1, :ccode2, :year] => ByRow((a, b, c) -> a == x && b == y && c == z - 1)).mid_target, dat.ccode1, dat.ccode2, dat.year))
leftjoin!(dat, unique(select(cap_dist, [1, 3, 5])), on = [:ccode1 => :numa, :ccode2 => :numb])
transform!(dat, :kmdist => ByRow(x -> ismissing(x) ? missing : x > 0 ? log(x) : 3.37) => :log_dist)
select!(dat, [:ccode1, :state_name1, :ccode2, :state_name2, :year, :cinc1, :mid_target, :dem_dyad, :un_vote, :log_trade, :log_dist, :mid_target_l1])
dropmissing!(dat)


### Descriptive Visualizations
## Continuous Variables
p_cinc1 = density(dat.cinc1, fillrange = 0, c = :tomato1, xlabel = "Patron's CINC Score", label = :none)
density!(dat.cinc1, c = :black, label = :none)

p_tvol = density(dat.log_trade, fillrange = 0, c = :tomato1, xlabel = "Trade Volume (logged)", label = :none)
density!(dat.log_trade, c = :black, label = :none)

p_unvote = density(dat.un_vote, fillrange = 0, c = :tomato1, xlabel = "UN Voting Alignment", label = :none)
density!(dat.un_vote, c = :black, label = :none)

p_dist = density(dat.log_dist, fillrange = 0, c = :tomato1, xlabel = "Distance (logged)", label = :none)
density!(dat.log_dist, c = :black, label = :none)

plot(p_cinc1, p_tvol, p_unvote, p_dist, layout = (2, 2))

## Binary Variables
p_mid = bar(["Success", "Failure"], counts(dat.mid_target), c = :tomato1, xlabel = "Extended Deterrence Status", label = :none)

p_dem = bar(["No", "Yes"], counts(dat.dem_dyad), c = :tomato1, xlabel = "Democratic Dyad", label = :none)

plot(p_dem, p_mid)


### Analysis
logit_int = glm(@formula(mid_target ~ cinc1*log_dist + dem_dyad + un_vote + log_trade  + mid_target_l1), dat,  Binomial(), LogitLink())

logit_noint = glm(@formula(mid_target ~ cinc1 + log_dist + dem_dyad + un_vote + log_trade  + mid_target_l1), dat,  Binomial(), LogitLink())

regtable(logit_int, logit_noint; renderSettings = asciiOutput())
regtable(logit_int, logit_noint; renderSettings = latexOutput())


### Auxilary Plots
## Coefficient Plot
coef_names = ["(Intercept)", "Patron's CINC ", "Log Distance", "Democratic Dyad", "UN Vote Alignment", "Log Trade", "MID Status Lagged", "Patron's CINC*Log Distance"]
coef_est_noint = coef(logit_noint)
coef_est_int = coef(logit_int)

scatter(coef_est_int, collect(1:8) .- .05, xerror = stderror(logit_int).*quantile(Normal(), .975), ms = 2, msw = 1, markerstrokecolor=:auto, markercolor = :navyblue, c = :navyblue, linecolor = :navyblue, label = "Non-interactive Model")
scatter!(coef_est_noint, collect(1:7) .+ .05 , xerror = stderror(logit_noint).*quantile(Normal(), .975), ms = 2, msw = 1, markerstrokecolor=:auto, markercolor = :firebrick2, c = :firebrick2, linecolor = :firebrick2, label = "Interactive Model")
yticks!(1:8, [L"\beta_{Intercept}", L"\beta_{CINC}", L"\beta_{Log\ Distance}", L"\beta_{Democratic\ Dyad}", L"\beta_{UN\ Voting\ Alignment}", L"\beta_{Log\ Trade}", L"\beta_{MID\ Lag\ 1}", L"\beta_{CINC×Log\ Distance}"])
title!("Coefficient Plot")

## Marginal Effect Plot 
pred_vals_cinc1 = [ones(100) range(quantile(dat.cinc1, .025), quantile(dat.cinc1, .975), 100) repeat([mean(dat.log_dist)], 100) repeat([mean(dat.dem_dyad)], 100) repeat([mean(dat.un_vote)], 100) repeat([mean(dat.log_trade)], 100) repeat([median(dat.mid_target_l1)], 100)] * coef(logit_noint)

pmarg1 = plot(range(quantile(dat.cinc1, .025), quantile(dat.cinc1, .975), 100), logistic.(pred_vals_cinc1), ylim = (0, .15), xlabel = "Patron's CINC Score", ylabel = "Probability of being Targeted in MID", c = :tomato2, legend = :none)

pred_vals_logdist = [ones(100) repeat([mean(dat.cinc1)], 100) range(quantile(dat.log_dist, .025), quantile(dat.log_dist, .975), 100) repeat([mean(dat.dem_dyad)], 100) repeat([mean(dat.un_vote)], 100) repeat([mean(dat.log_trade)], 100) repeat([median(dat.mid_target_l1)], 100)] * coef(logit_noint)

pmarg2 = plot(range(quantile(dat.log_dist, .025), quantile(dat.log_dist, .975), 100), logistic.(pred_vals_logdist), ylim = (0, .15), xlabel = "Distance b/w Allies", ylabel = "Probability of being Targeted in MID", c = :tomato2, legend = :none)

## Interaction Diagnostics
vcov(logit_int)
coef(logit_int)

z0 = range(minimum(dat.log_dist), maximum(dat.log_dist), 100)
dy_dx = coef(logit_int)[2] .+ (coef(logit_int)[8] .* z0)
se_dy_dx = sqrt.(vcov(logit_int)[2, 2] .+ ((z0 .^ 2) .* vcov(logit_int)[8, 8]) .+ (2 .* z0 .* vcov(logit_int)[8, 2]))

c_int_95 = se_dy_dx .* quantile(Normal(), .975)

plot(z0, dy_dx, ribbon = (c_int_95), c = :tomato2, label = :none, xlabel = "Log Distance", ylabel = L"\beta_{CINC}")