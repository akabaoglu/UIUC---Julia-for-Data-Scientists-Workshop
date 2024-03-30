############################################
#####        Abdullah Kabaoglu         #####
##### U. of Illinois Urbana-Champaign  #####
##### Date Created:     26.03.2024     #####
##### Last Revision:    30.03.2024     #####
############################################

### 0. IMPORTING PACKAGES 
using DataFrames, Plots, CSV, ExcelReaders, RData, StatsPlots, Statistics, StatsBase, GLM, RegressionTables, Distributions, StatsFuns, LaTeXStrings # Importing necessary packages for data manipulation and visualization

### 1. LOADING DATA
nmc = CSV.read("Misc/Paper Replication/Data/NMC-60-abridged.csv", DataFrame) # Reading a CSV file into a DataFrame
select!(nmc, [2, 3, 10]) # Keeping only the 2nd, 3rd, and 10th columns

mid_targets = CSV.read("Misc/Paper Replication/Data/dyadic_mid_4.02.csv", DataFrame) # Reading another CSV file into a DataFrame
select!(mid_targets, [:statea, :namea, :stateb, :nameb, :strtyr, :orignatb, :hihostb]) # Select specific columns by name
subset!(mid_targets, [:orignatb, :hihostb] => ByRow((x, y) -> x == 1 && y > 3)) # Filter rows where orignatb is 1 and hihostb > 3
select!(mid_targets, [1, 2, 5]) # Keep only the 1st, 2nd, and 5th columns
unique!(mid_targets) # Remove duplicate rows
mid_targets.mid_target = ones(nrow(mid_targets)) # Add a new column 'mid_target' filled with 1s

alliance = CSV.read("Misc/Paper Replication/Data/alliance_v4.1_by_directed_yearly.csv", DataFrame) # Reading a CSV file into a DataFrame without further modification

cow_trade = CSV.read("Misc/Paper Replication/Data/cow_trade_dyad.csv", DataFrame) # Reading a CSV file
select!(cow_trade, [1, 2, 3, 6, 7]) # Keeping only certain columns by index

polity_v = DataFrame(readxlsheet("Misc/Paper Replication/Data/p5v2018.xls", "p5v2018", skipstartrows = 1), :auto) # Reading data from an Excel sheet
select!(polity_v, [3, 6, 11]) # Select specific columns by index
rename!(polity_v, ["ccode", "year", "polity"]) # Rename columns to 'ccode', 'year', and 'polity'

dfAgree = load("Misc/Paper Replication/Data/AgreementScores.Rdata")["dfAgree"] # Loading a dataset from an RData file and extracting 'dfAgree' from the loaded data

cap_dist = CSV.read("Misc/Paper Replication/Data/capdist.csv", DataFrame) # Reading a CSV file into a DataFrame without further modification


### 2. DATA CLEANING
# Filtering the 'alliance' DataFrame for rows where the `defense` column equals 1
dat = subset(alliance, :defense => ByRow(x -> x == 1))

# Keeping only selected columns by their indices
select!(dat, [2, 3, 4, 5, 18])

# Filtering out rows based on the `ccode2` column values, removing specific country codes
subset!(dat, :ccode2 => ByRow(x -> !(x in [2, 200, 220, 710, 365])))

# Removing duplicate rows to ensure uniqueness
unique!(dat)

# Performing left joins to merge `dat` DataFrame with `nmc` DataFrame based on common `ccode` and `year` columns
leftjoin!(dat, nmc, on = [:ccode1 => :ccode, :year])
leftjoin!(dat, nmc, on = [:ccode2 => :ccode, :year], makeunique = true)

# Renaming columns to avoid confusion after merging DataFrames with similar column names
rename!(dat, Dict(:cinc => "cinc1", :cinc_1 => "cinc2"))

# Joining 'dat' DataFrame with a modified version of 'mid_targets', excluding a specific column
leftjoin!(dat, select(mid_targets, Not(2)), on = [:year => :strtyr, :ccode2 => :statea])

# Transforming `mid_target` column to replace missing values with 0
transform!(dat, :mid_target => ByRow(x -> ismissing(x) ? 0 : 1), renamecols = false)

# Joining `dat` with `cow_trade` DataFrame and handling missing or special values (-9) in `flow1` and `flow2`
leftjoin!(dat, cow_trade, on = [:ccode1, :ccode2, :year])
transform!(dat, [:flow1, :flow2] .=> ByRow(x -> if ismissing(x); return missing; elseif x == -9; return missing; else return x end), renamecols = false)

# Creating a new column `tradevol` as the sum of `flow1` and `flow2`, handling missing values accordingly
transform!(dat, [:flow1, :flow2] => ByRow((x, y) -> x + y) => :tradevol)

# Performing additional left joins with `polity_v` DataFrame to merge political data
leftjoin!(dat, polity_v, on = [:ccode1 => :ccode, :year])
leftjoin!(dat, polity_v, on = [:ccode2 => :ccode, :year], makeunique = true)
rename!(dat, Dict(:polity => "polity1", :polity_1 => "polity2"))

# Calculating `dem_dyad` to indicate democratic dyads based on `polity1` and `polity2` values
transform!(dat, [:polity1, :polity2] => ByRow((x, y) -> coalesce(x, 0) >= 6 && coalesce(y, 0) >= 6 ? 1 : 0) => :dem_dyad)

# Merging UN voting agreement scores from `dfAgree` and renaming the merged column
leftjoin!(dat, select(dfAgree, 2:5), on = ["ccode1", "ccode2", "year"])
rename!(dat, Dict(:agree => "un_vote"))

# Transforming `cinc1` and `tradevol` through logarithmic transformation and handling special cases
transform!(dat, :cinc1 => ByRow(x -> log(x)), renamecols = false)
transform!(dat, :tradevol => ByRow(x -> log(x)) => :log_trade)
transform!(dat, :log_trade => ByRow(x ->  ismissing(x) ? missing : x == -Inf ? -15 : x), renamecols = false)

# Generating a lagged version of `mid_target` by comparing year-1 records
dat.mid_target_l1 = map(x -> length(x) == 0 ? missing : x[1], map((x, y, z) -> subset(dat, [:ccode1, :ccode2, :year] => ByRow((a, b, c) -> a == x && b == y && c == z - 1)).mid_target, dat.ccode1, dat.ccode2, dat.year))

# Joining distance data from `cap_dist` and applying log transformation to `kmdist`
leftjoin!(dat, unique(select(cap_dist, [1, 3, 5])), on = [:ccode1 => :numa, :ccode2 => :numb])
transform!(dat, :kmdist => ByRow(x -> ismissing(x) ? missing : x > 0 ? log(x) : 3.37) => :log_dist)

# Selecting a subset of columns for the final DataFrame
select!(dat, [:ccode1, :state_name1, :ccode2, :state_name2, :year, :cinc1, :mid_target, :dem_dyad, :un_vote, :log_trade, :log_dist, :mid_target_l1])

# Removing rows with any missing values in the selected columns
dropmissing!(dat)


### 3. DESCRIPTIVE VISUALIZATIONS
## 3.1 Continuous Variables
p_cinc1 = density(dat.cinc1, fillrange = 0, c = :tomato1, xlabel = "Patron's CINC Score", label = :none) # Creating a density plot for `cinc1` with specific aesthetics
density!(dat.cinc1, c = :black, label = :none) # Overlaying the same data with a black line to emphasize the density

p_tvol = density(dat.log_trade, fillrange = 0, c = :tomato1, xlabel = "Trade Volume (logged)", label = :none) # Creating a density plot for `log_trade` (logged trade volume)
density!(dat.log_trade, c = :black, label = :none) # Overlaying the same data with a black line for visual emphasis

p_unvote = density(dat.un_vote, fillrange = 0, c = :tomato1, xlabel = "UN Voting Alignment", label = :none) # Generating a density plot for `un_vote` (UN voting alignment scores)
density!(dat.un_vote, c = :black, label = :none) # Overlaying with a black line to highlight the density curve

p_dist = density(dat.log_dist, fillrange = 0, c = :tomato1, xlabel = "Distance (logged)", label = :none) # Creating a density plot for `log_dist` (logged distance between countries)
density!(dat.log_dist, c = :black, label = :none) # Overlaying with a black line for visual emphasis

plot(p_cinc1, p_tvol, p_unvote, p_dist, layout = (2, 2)) # Combining the four density plots into a single figure with a 2x2 layout


## 3.2 Binary Variables
p_mid = bar(["Success", "Failure"], counts(dat.mid_target), c = :tomato1, xlabel = "Extended Deterrence Status", label = :none) # Generating a bar plot for `mid_target` variable, showing counts of Success (1) vs Failure (0)

p_dem = bar(["No", "Yes"], counts(dat.dem_dyad), c = :tomato1, xlabel = "Democratic Dyad", label = :none) # Creating a bar plot for `dem_dyad`, representing counts of democratic dyads (Yes) vs non-democratic dyads (No)

plot(p_dem, p_mid) # Combining the 'p_dem' and 'p_mid' plots into a single figure


### 4. ANALYSIS
logit_int = glm(@formula(mid_target ~ cinc1*log_dist + dem_dyad + un_vote + log_trade  + mid_target_l1), dat,  Binomial(), LogitLink()) # Fitting a logistic regression model with interaction between `cinc1` and `log_dist`

logit_noint = glm(@formula(mid_target ~ cinc1 + log_dist + dem_dyad + un_vote + log_trade  + mid_target_l1), dat,  Binomial(), LogitLink()) # Fitting another logistic regression model without the interaction term

regtable(logit_int, logit_noint; renderSettings = asciiOutput()) # Displaying the regression table for both models in ASCII format
regtable(logit_int, logit_noint; renderSettings = latexOutput()) # Displaying the regression table for both models in LaTeX format


### 5. AUXILIARY PLOTS 
## 5.1 Coefficient Plot
# Defining names for the coefficients for clarity in the plot
coef_names = ["(Intercept)", "Patron's CINC ", "Log Distance", "Democratic Dyad", "UN Vote Alignment", "Log Trade", "MID Status Lagged", "Patron's CINC*Log Distance"]

# Extracting coefficient estimates from both models
coef_est_noint = coef(logit_noint)
coef_est_int = coef(logit_int)

# Plotting coefficients with standard errors for the interactive model
scatter(coef_est_int, collect(1:8) .- .05, xerror = stderror(logit_int).*quantile(Normal(), .975), ms = 2, msw = 1, markerstrokecolor=:auto, markercolor = :navyblue, c = :navyblue, linecolor = :navyblue, label = "Non-interactive Model")

# Adding coefficients with standard errors for the non-interactive model
scatter!(coef_est_noint, collect(1:7) .+ .05 , xerror = stderror(logit_noint).*quantile(Normal(), .975), ms = 2, msw = 1, markerstrokecolor=:auto, markercolor = :firebrick2, c = :firebrick2, linecolor = :firebrick2, label = "Interactive Model")

# Customizing y-ticks to display coefficient names
yticks!(1:8, [L"\beta_{Intercept}", L"\beta_{CINC}", L"\beta_{Log\ Distance}", L"\beta_{Democratic\ Dyad}", L"\beta_{UN\ Voting\ Alignment}", L"\beta_{Log\ Trade}", L"\beta_{MID\ Lag\ 1}", L"\beta_{CINC×Log\ Distance}"])

# Adding a title to the plot
title!("Coefficient Plot")


## 5.2 Marginal Effect Plot 
# Calculating predicted values for a range of CINC scores using the non-interactive model
pred_vals_cinc1 = [ones(100) range(quantile(dat.cinc1, .025), quantile(dat.cinc1, .975), 100) repeat([mean(dat.log_dist)], 100) repeat([mean(dat.dem_dyad)], 100) repeat([mean(dat.un_vote)], 100) repeat([mean(dat.log_trade)], 100) repeat([median(dat.mid_target_l1)], 100)] * coef(logit_noint)

# Plotting the marginal effect of CINC scores on the probability of being targeted in a MID
pmarg1 = plot(range(quantile(dat.cinc1, .025), quantile(dat.cinc1, .975), 100), logistic.(pred_vals_cinc1), ylim = (0, .15), xlabel = "Patron's CINC Score", ylabel = "Probability of being Targeted in MID", c = :tomato2, legend = :none)

# Repeating the process for Log Distance
pred_vals_logdist = [ones(100) repeat([mean(dat.cinc1)], 100) range(quantile(dat.log_dist, .025), quantile(dat.log_dist, .975), 100) repeat([mean(dat.dem_dyad)], 100) repeat([mean(dat.un_vote)], 100) repeat([mean(dat.log_trade)], 100) repeat([median(dat.mid_target_l1)], 100)] * coef(logit_noint)

pmarg2 = plot(range(quantile(dat.log_dist, .025), quantile(dat.log_dist, .975), 100), logistic.(pred_vals_logdist), ylim = (0, .15), xlabel = "Distance b/w Allies", ylabel = "Probability of being Targeted in MID", c = :tomato2, legend = :none)


## 5.3 Interaction Diagnostics
# Obtaining the variance-covariance matrix of the coefficients from the interactive model
vcov(logit_int)

# Extracting coefficient estimates from the interactive model for interaction diagnostics
coef(logit_int)

# Defining a range for Log Distance and calculating the derivative of Y with respect to X (dy/dx) for interaction
z0 = range(minimum(dat.log_dist), maximum(dat.log_dist), 100)
dy_dx = coef(logit_int)[2] .+ (coef(logit_int)[8] .* z0)

# Calculating the standard error for dy/dx
se_dy_dx = sqrt.(vcov(logit_int)[2, 2] .+ ((z0 .^ 2) .* vcov(logit_int)[8, 8]) .+ (2 .* z0 .* vcov(logit_int)[8, 2]))

# Calculating the 95% confidence interval for dy/dx
c_int_95 = se_dy_dx .* quantile(Normal(), .975)

# Plotting the interaction effect with confidence ribbon
plot(z0, dy_dx, ribbon = (c_int_95), c = :tomato2, label = :none, xlabel = "Log Distance", ylabel = L"\beta_{CINC}")