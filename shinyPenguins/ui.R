library(shiny)

# Define UI for application that predicts Penguin Species
shinyUI(fluidPage(
    # Application title
    titlePanel("Predicting Palmer Penguin Species"),
    
    # Sidebar with a inputs for new data.
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                "radioIsland",
                "On which island was the penguin found?",
                c(
                    "Biscoe" = "Biscoe",
                    "Dream" = "Dream",
                    "Torgersen" = "Torgersen"
                )
            ),
            radioButtons(
                "radioSex",
                "What is the gender of the penguin?",
                c("Male" = "male", "Female" = "female")
            ),
            sliderInput(
                "sliderbill_length",
                "Bill Length (mm)",
                min = 30,
                max = 60,
                value = 44.50,
                step = 0.01
            ),
            sliderInput(
                "sliderbill_depth",
                "Bill Depth (mm)",
                min = 12,
                max = 22,
                value = 17,
                step = 0.01
            ),
            sliderInput(
                "sliderflipper_length",
                "Flipper Length (mm)",
                min = 170,
                max = 240,
                value = 200,
                step = 1
            ),
            sliderInput(
                "sliderbody_mass",
                "Body Mass (g)",
                min = 2600,
                max = 6400,
                value = 4050,
                step = 5
            ),
            sliderInput(
                "slideryear",
                "Year",
                min = 2007,
                max = 2009,
                value = 2008,
                step = 1
            ),
            # Add a submit button so that the reactive expressions are delayed.
            submitButton("Submit")
        ),
        
        # A Tabset panel containing Instructions and a tab for predictions.
        mainPanel(tabsetPanel(
            type = "tabs",
            
            tabPanel("Instructions",
                     h4("This app fits a random forest (ranger) model and a decision tree (rpart)
                        model on the Palmer Penguins dataset. Use the interface in the sidebar to
                        select attributes of the penguin and press submit. Click on the predicitons
                        tab to see the prediction for each model.")),
            tabPanel(
                "Predictions",
                h3("Predicted Species from Random Forest Model:"),
                textOutput("pred1"),
                h3("Predicted Species from Decision Tree Model:"),
                textOutput("pred2")
            )
        ))
    )
))
