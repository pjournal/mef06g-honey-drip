library(shiny)
library(data.table)
library(shinyWidgets)
library(DT)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggrepel) 

results <- readRDS("House_sales_to_foreigners_by_province.rds")

ui <- fluidPage(
  
  # Application title
  titlePanel(
    h1("House sales to foreigners by province", align="center")
  ),
  
  fluidRow(
    column(3,
           pickerInput("provinceInput", "Province", choices=unique(results$Province), options = list(`actions-box` = TRUE), selected=NULL, multiple=TRUE)
    ),
    column(9, 
           DT::dataTableOutput('table')))
  
)

server <- function(input, output) {
  
  mydata <- reactive({
    if (is.null(input$provinceInput)) {df <- results
    } else df <- results[results$Province %in% input$provinceInput,]
    df
  })
  
  output$table <- DT::renderDataTable(
    datatable(mydata())
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)
