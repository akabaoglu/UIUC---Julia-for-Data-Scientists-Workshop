############################################
#####        Abdullah Kabaoglu         #####
##### U. of Illinois Urbana-Champaign  #####
##### Date Created:     03.30.2024     #####
##### Last Revision:    03.31.2024     #####
############################################

### 0. IMPORTING PACKAGES 
using Plots, StatsPlots, DataFrames, Distributions, RDatasets, StatsBase # Importing necessary packages for data manipulation and visualization


### 1. BASIC LINE PLOT & SCATTER PLOT
plot(eachindex(v1), v1) # Basic line plot of values in vector v1 against their indices

scatter(eachindex(v1), v1) # Basic scatter plot of values in vector v1 against their indices


### 2. CUSTOMIZING SCATTER PLOT
scatter(eachindex(v1), v1, c = :red) # Coloring the markers red

scatter(eachindex(v1), v1, c = :red, ms = 4) # Increasing marker size (ms) to 4

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2) # Setting marker stroke width (msw) to 2

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots") # Adding a label for the legend

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label") # Adding labels for the x and y axes

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT") # Adding a title to the plot

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 10:10:100) # Customizing x-ticks to be at intervals of 10 from 10 to 100

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1) # Customizing y-ticks to be at intervals of 0.1 from 0 to 1

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1) # Renaming label to "Lines", which should ideally be "Dots" since it's a scatter plot

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (0, 120), title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1) # Setting x-axis limits from 0 to 120

scatter(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (0, 120), ylim = (-1, 2), title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1) # Setting y-axis limits from -1 to 2

plot(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines", xlab = "X Label", ylab = "Y Label", xlim = (0, 120), ylim = (-1, 2), title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1) # Switching back to a line plot with the same customizations as the final scatter plot for comparison

### 3. PLOT OVERLAY
plot(eachindex(v1), v1, c = :red, label = "Dots", xlab = "X Label", ylab = "Y Label", title = "SOME PLOT", xticks = 10:10:100, yticks = 0:.1:1)
scatter!(eachindex(v1), v1, c = :red, ms = 4, msw = 2, label = "Lines") # Overlaying scatterplot over line plot.


### 4. DESCRIPTIVE PLOTS

## 4.1 Bar Plots 
cars_data = RDatasets.dataset("ggplot2", "mpg") # Loading the "mpg" dataset from the "ggplot2" package

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = :Magenta) # Basic bar plot showing the count of cars by number of cylinders, colored in magenta

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange]) # The same bar plot with each bar colored differently

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange], bar_width = 1) # Adjusting bar width to 1 for more distinct bars

bar(4:8, counts(cars_data.Cyl), legend = :none, xlab = "# of Cylinders", ylab = "Counts", c = [:red, :yellow, :blue, :green, :orange], bar_width = 1, lw = 0) # Removing the line width (lw) for the bars for a cleaner look

## 4.2 Histograms
histogram(cars_data.Cty) # Basic histogram of city mileage

histogram(cars_data.Cty, c = :cyan, bar_width = 1, lw = 0) # Customizing histogram appearance with cyan color, bar width, and removing line width

histogram2d(cars_data.Cty, cars_data.Hwy) # 2D histogram of city vs. highway mileage

groupedhist(cars_data.Displ, group = cars_data.Drv) # Grouped histogram of displacement by drive type

## 4.3 Boxplots, Dotplots, and Violin Plots
boxplot(cars_data.Cyl, cars_data.Displ) # Boxplot of displacement by the number of cylinders

dotplot(cars_data.Cyl, cars_data.Displ) # Dotplot of displacement by the number of cylinders

# Violin plots of displacement by the number of cylinders, with different orientations
violin(cars_data.Cyl, cars_data.Displ)
violin(cars_data.Cyl, cars_data.Displ, side = :right)
violin(cars_data.Cyl, cars_data.Displ, side = :left)

## 4.4 Density Plots
density(cars_data.Displ) # Basic density plot of displacement

# Density plot with partial fill
density(cars_data.Displ, fill = (0, .5, :orange))
density(cars_data.Displ, fill = (1, .5, :orange))

density(cars_data.Displ, groups = cars_data.Cyl) # Density plot of displacement grouped by the number of cylinders

density(cars_data.Displ, groups = (cars_data.Year, cars_data.Drv)) # Density plot grouped by year and drive type

## 4.5 Error Line and QQ-Norm Plot
errorline(1:5, sample(1:5, 5), yerror = rand(5), secondarycolor=:matched) # Error line plot with random y-errors

qqnorm(cars_data.Cty, ms = 3, msw = .5) # QQ-Norm plot for city mileage with customized marker size and stroke width


### 5. PLOTTING FUNCTIONS

## 5.1 Mathematical Functions
plot(x -> 3x^2 + 2) # Plotting a quadratic anonymous function

plot(x -> pi*x^3) # Plotting a cubic anonymous function 

## 5.2 Probability Distributions
plot(Normal(8, 5)) # Plotting a Normal distribution

plot(Poisson(3)) # Plotting a Poisson distribution

plot(NegativeBinomial(3)) # Plotting a Negative Binomial distribution

plot(Gamma(3)) # Plotting a Gamma distribution

plot(Chisq(5)) # Plotting a Chi-squared distribution