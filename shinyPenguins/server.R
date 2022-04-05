#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(palmerpenguins)
library(tidyverse)

# Define server logic required to predict Species
shinyServer(function(input, output) {
    data(penguins)
    
    df <- penguins %>%
        drop_na()
    
    library(tidymodels)
    
    penguin_rec <-
        recipe(species ~ ., data = df) %>%
        step_dummy(all_nominal_predictors()) %>%
        step_normalize(all_numeric_predictors()) %>%
        step_zv() %>%
        prep()
    
    rf_spec <-
        rand_forest() %>%
        set_mode("classification") %>%
        set_engine("ranger")
    
    tree_spec <-
        decision_tree() %>%
        set_mode("classification") %>%
        set_engine("rpart")
    
    rf_wf <-
        workflow() %>%
        add_recipe(penguin_rec) %>%
        add_model(rf_spec)
    
    tree_wf <-
        workflow() %>%
        add_recipe(penguin_rec) %>%
        add_model(tree_spec)
set.seed(4422)
    rf_fit <- rf_wf %>% fit(df)
    tree_fit <- tree_wf %>% fit(df)
    
    rfpred <-
        reactive({
            islandInput <- input$radioIsland
            bill_lengthInput <- input$sliderbill_length
            bill_depthInput <- input$sliderbill_depth
            flipper_lengthInput <- input$sliderflipper_length
            body_massInput <- input$sliderbody_mass
            sexInput <- input$radioSex
            yearInput <- input$slideryear
            newdata <-  data.frame(
                island = islandInput,
                bill_length_mm = bill_lengthInput,
                bill_depth_mm = bill_depthInput,
                flipper_length_mm = flipper_lengthInput,
                body_mass_g = body_massInput,
                sex = sexInput,
                year = yearInput
            )
            as.character(predict(rf_fit, newdata) %>% pull())
            
        })
    treepred <-
        reactive({
            islandInput <- input$radioIsland
            bill_lengthInput <- input$sliderbill_length
            bill_depthInput <- input$sliderbill_depth
            flipper_lengthInput <- input$sliderflipper_length
            body_massInput <- input$sliderbody_mass
            sexInput <- input$radioSex
            yearInput <- input$slideryear
            newdata <-  data.frame(
                island = islandInput,
                bill_length_mm = bill_lengthInput,
                bill_depth_mm = bill_depthInput,
                flipper_length_mm = flipper_lengthInput,
                body_mass_g = body_massInput,
                sex = sexInput,
                year = yearInput
            )
            as.character(predict(tree_fit, newdata) %>% pull())
            
        })
    output$pred2 <- renderText({
        treepred()
    })
    
    output$pred1 <- renderText({
        rfpred()
    })
})