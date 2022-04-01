library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Plot Random Numbers"),
    sidebarPanel(
        numericInput(
            'numeric',
            'How Many Random Numbers Should be Plotted?',
            value = 1000,
            min = 0,
            max = 1000,
            step = 1
        ),
        sliderInput(
            "sliderX",
            "Pick Minimum and Maximum X Values",
            value = c(-50, 50),
            min  = -100,
            max = 100,
        ),
        sliderInput(
            "sliderY",
            "Pick Minimum and Maximum Y Values",-100,
            100,
            value = c(-50, 50)
        ),
        checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
        checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
        checkboxInput("show_title", "Show/Hide Title", value = TRUE),
        
    ),
    mainPanel(h3("Graph of Random Points"),
              plotOutput("plot1"))
))
