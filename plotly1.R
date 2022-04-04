library(plotly)
data("mtcars")

plot_ly(
        mtcars,
        x = ~wt,
        y = ~mpg,
        type="scatter",
        mode = "markers",
        color = ~as.factor(cyl),
        size = mtcars$hp,
        hoverinfo = "text",
        text = ~paste("Weight: ", wt, "tons", "<br>Miles per Gallon: ", mpg)
)

#Alternatively
p <- ggplot(aes(x = wt,
                y = mpg,
                color = as.factor(cyl),
                text = paste("Weight: ", wt, "tons",
                              "<br>Miles per Gallon: ", mpg,
                              "<br>Cylinders: ", cyl)), data = mtcars) +
        geom_point(alpha = 0.5) +
        scale_color_discrete(name = "Cylinders") +
        labs(x = "Weight (tons)",
             y = "Fuel Economy (miles per gallon)")
ggplotly(p)

plot_ly(
        mtcars,
        x = mtcars$wt,
        y = mtcars$mpg,
        mode = "markers",
        color = mtcars$disp
)

set.seed(2020-06-07)
temp <- rnorm(100,30,5)
pressure <- rnorm(100)
dtime <- (1:100)
plot_ly(
        x = temp,
        y= pressure,
        z = dtime,
        type = "scatter3d",
        mode = "markers",
        color = temp
)
rm(temp,pressure,dtime)

library(plotly)
library(tidyverse)
data("EuStockMarkets")

stocks <- as.data.frame(EuStockMarkets) %>%
        pivot_longer(DAX:FTSE, names_to = "index",values_to = "price") %>%
        mutate(time = rep(time(EuStockMarkets),4),
               index = factor(index))

plot_ly(stocks, x = stocks$time, y= stocks$price, color= stocks$index)
