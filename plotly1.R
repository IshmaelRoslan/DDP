library(plotly)
data("mtcars")

plot_ly(
        mtcars,
        x = mtcars$wt,
        y = mtcars$mpg,
        mode = "markers",
        color = as.factor(mtcars$cyl),
        size = mtcars$hp
)

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
