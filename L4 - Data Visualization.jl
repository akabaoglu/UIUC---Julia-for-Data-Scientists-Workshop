############################################
#####        Abdullah Kabaoglu         #####
##### U. of Illinois Urbana-Champaign  #####
##### Date Created:     03.30.2024     #####
##### Last Revision:    04.05.2024     #####
############################################

### 0. IMPORTING PACKAGES, ETC.
using Plots, StatsPlots, DataFrames, Distributions, RDatasets, StatsBase, Random, LaTeXStrings # Importing necessary packages for visualization

Random.seed!(12345)

### 1. BASIC LINE PLOT & SCATTER PLOT (requires Plots.jl)
v1 = rand(25) # (1.1)

plot(eachindex(v1), v1) # Basic line plot of values in vector v1 against their indices (1.2)

scatter(eachindex(v1), v1) # Basic scatter plot of values in vector v1 against their indices (1.3)


### 2. CUSTOMIZING SCATTER PLOT (requires Plots.jl)
scatter(eachindex(v1), v1, c = :red) # Coloring the markers red (2.1)

scatter(eachindex(v1), v1, c = :red, ms = 6) # Increasing marker size (ms) to 4 (2.2)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2) # Setting marker stroke width (msw) to 2 (2.3)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots") # Adding a label for the legend (2.4)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label") # Adding labels for the x and y axes (2.5)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT") # Adding a title to the plot (2.6)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 1:25) # Customizing x-ticks to be at intervals of 1 from 1 to 25 (2.7)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1) # Customizing y-ticks to be at intervals of 0.1 from 0 to 1 (2.8)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1) # Setting x-axis limits from -5 to 30 (2.9)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), ylim = (-1, 2), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1) # Setting y-axis limits from -1 to 2 (2.10)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), ylim = (-1, 2), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1, markershape = :star) # Changing marker symbol to star. Other options are : `:none`, `:auto`, `:circle`, `:rect`, `:star5`, `:diamond`, `:hexagon`, `:cross`, `:xcross`, `:utriangle`, `:dtriangle`, `:rtriangle`, `:ltriangle`, `:pentagon`, `:heptagon`, `:octagon`, `:star4`, `:star6`, `:star7`, `:star8`, `:vline`, `:hline`, `:+`, `:x` (2.11)

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), ylim = (-1, 2), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1, markershape = :star, framestyle = :box) # Changing the frame style from `:axes` (the default style) into `box`. Other options are: `:semi`, `:origin`, `:zerolines`, `:grid`, `:none` (2.12)

plot(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1) # Switching back to a line plot with the same customizations as the final scatter plot for comparison (2.13)

plot(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1, linestyle = :dash) # Changing line style to dash. Other options are: `:auto`, `:solid`, `:dot`, `:dashdot`, `:dashdotdot`. (2.14)

plot(eachindex(v1), v1, c = :red, ms = 4, msw = 2, xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), ylim = (-1, 2), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1, label = :none) # Removing a particular label from the legend (2.15)

plot(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (-5, 30), ylim = (-1, 2), title = "SOME PLOT", xticks = 1:25, yticks = 0:.1:1, legend = :none) # Removing not only a particular label, but the entire legend (2.16)


### 3. PLOT OVERLAY (requires Plots.jl)
plot(eachindex(v1), v1, c = :red, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 1:50, yticks = 0:.1:1)
scatter!(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines") # Overlaying scatterplot over line plot. (3.1)


### 4. DESCRIPTIVE PLOTS (requires StatsPlots.jl)
cars_data = RDatasets.dataset("ggplot2", "mpg") # Loading the "mpg" dataset from the "ggplot2" package (4.1)

## 4.1 Bar Plots 
bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = :Magenta) # Basic bar plot showing the count of cars by number of cylinders, colored in magenta (4.2)

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange]) # The same bar plot with each bar colored differently (4.3)

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange], bar_width = 1) # Adjusting bar width to 1 for more distinct bars (4.4)

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange], bar_width = 1, lw = 0) # Removing the line width (lw) for the bars for a cleaner look (4.5)

## 4.2 Histograms
histogram(cars_data.Cty) # Basic histogram of city mileage (4.6)

histogram(cars_data.Cty, c = :cyan, bar_width = 1, lw = 0) # Customizing histogram appearance with cyan color, bar width, and removing line width (4.7)

histogram2d(cars_data.Cty, cars_data.Hwy) # 2D histogram of city vs. highway mileage (4.8)

groupedhist(cars_data.Displ, group = cars_data.Drv) # Grouped histogram of displacement by drive type (4.9)

## 4.3 Boxplots, Dotplots, and Violin Plots
boxplot(cars_data.Cyl, cars_data.Displ) # Boxplot of displacement by the number of cylinders (4.10)

dotplot(cars_data.Cyl, cars_data.Displ) # Dotplot of displacement by the number of cylinders (4.11)

# Violin plots of displacement by the number of cylinders, with different orientations
violin(cars_data.Cyl, cars_data.Displ) # (4.12)
violin(cars_data.Cyl, cars_data.Displ, side = :right) # (4.13)
violin(cars_data.Cyl, cars_data.Displ, side = :left) # (4.14)

## 4.4 Density Plots
density(cars_data.Displ) # Basic density plot of displacement (4.15)

# Density plot with partial fill
density(cars_data.Displ, fill = (0, .5, :orange)) # (4.16)
density(cars_data.Displ, fill = (1, .5, :orange)) # (4.17)

density(cars_data.Displ, groups = cars_data.Cyl) # Density plot of displacement grouped by the number of cylinders (4.18)

density(cars_data.Displ, groups = (cars_data.Year, cars_data.Drv)) # Density plot grouped by year and drive type (4.19)

## 4.5 Error Line and QQ-Norm Plot
errorline(1:5, sample(1:5, 5), yerror = rand(5), secondarycolor = :matched) # Error line plot with random y-errors (4.20)

qqnorm(cars_data.Cty, ms = 3, msw = .5) # QQ-Norm plot for city mileage with customized marker size and stroke width (4.21)


### 5. THE `@df` MACRO (requires StatsPlots.jl)
scatter(cars_data.Cty, cars_data.Hwy) # Plotting city mileage (Cty) against highway mileage (Hwy) using a scatter plot (5.1)

@df cars_data scatter(:Cty, :Hwy) # Creating the same scatter plot using the @df macro to reference columns by their symbols (5.2)

@df cars_data histogram(:Cty) # Plotting a histogram of the city mileage (Cty) column (5.3)

@df cars_data boxplot(:Class, :Displ) # Creating a boxplot of engine displacement (Displ) grouped by car class (Class) (5.4)


### 6. PLOTTING FUNCTIONS (requires StatsPlots.jl)

## 6.1 Mathematical Functions
plot(x -> 3x^2 + 2) # Plotting a quadratic anonymous function (6.1)

plot(x -> pi*x^3) # Plotting a cubic anonymous function (6.2)

## 6.2 Probability Distributions (requires Distributions)
plot(Normal(8, 5)) # Plotting a Normal distribution (6.3)

plot(Poisson(3)) # Plotting a Poisson distribution (6.4)


### 7. PLOT LAYOUTS (requires Plots.jl)
# Generating density plots for several columns in the 'cars_data' DataFrame:
p1, p2, p3, p4 = density.([cars_data.Displ, cars_data.Cyl, cars_data.Cty, cars_data.Hwy]) # (7.1)
# This line uses broadcasting (denoted by the dot before the parentheses) to apply the `density` function to an array of columns (`Displ`, `Cyl`, `Cty`, `Hwy`) from the `cars_data` DataFrame. The result is four density plots stored in `p1`, `p2`, `p3`, and `p4`, corresponding to the engine displacement, number of cylinders, city mileage, and highway mileage, respectively.

plot(p1, p2, p3, p4, layout = (2, 2)) # Arranging the density plots in a 2x2 grid (7.2)

plot(p1, p2, p3, p4, layout = (1, 4)) # Arranging the density plots in a 1x4 grid (horizontal layout) (7.3)

plot(p1, p2, p3, p4, layout = (4, 1)) # Arranging the density plots in a 4x1 grid (vertical layout) (7.4)


### 8. ADDING LaTeX STYLES ON PLOTS (requires LaTeXStrings.jl)
plot(x -> (1 + x)/(x^2 + 4), xlim = (-10, 10), xlabel = L"x", ylabel = L"\frac{1 + x}{x^2 + 4}") # Plotting a rational function with specified x-axis limits and LaTeX labels (8.1)

plot(x -> sqrt(x*pi), xlim = (0, 10), xlabel = L"x", label = L"\sqrt{x\times\pi}") # Plotting a square root function that multiplies x by pi 
plot!(x -> (exp(x))^(1/5), xlim = (0, 10), xlabel = L"x", label = L"\sqrt[5]{e^x}") # Adding an exponential function to the existing plot (8.2)


### 9. THREE DIMENSIONAL PLOTS
obs = eachrow(rand(MvNormal([0, 0, 0], [1 .4 .6; .4 1 .5; .6 .5 1]), 100)) # (9.1)

scatter(obs[1], obs[2], obs[3]) # (9.2)

scatter(obs[1], obs[2], obs[3], camera = (225, 315)) # (9.3)

plot(obs[1], obs[2], obs[3], camera = (225, 315)) # (9.4)

scatter(obs[1], obs[2], obs[3], camera = (225, 315), ms = 2)
plot!(obs[1], obs[2], obs[3], camera = (225, 315), xlabel = "x", ylabel = "y", zlabel = "z") # (9.5)