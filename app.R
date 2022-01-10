library(shiny)
library(rsconnect)
source("ETL.R")

ui <- fluidPage(
  selectInput("country_ind", label = "Country", choices = gdp$Country),
  numericInput("less_country", "Keep the Country which GDP less than", 20000000000000),
  textOutput("total_country"),
  tableOutput("table")
  
)

server <- function(input, output, session) {
  output$table <- renderTable({
    if (input$country_ind=='All') dataset<-filter(gdp,Country!='All' & GDP_nominal<input$less_country)
    else dataset <- filter(gdp,Country==input$country_ind & GDP_nominal_2017<input$less_country)
    dataset <- select(dataset,Number,Country,GDP_nominal_2017,GDP_growth,Pop,GDP_per_capita,Share)
    dataset
  })
  output$total_country <- renderText({
    if (input$country_ind=='All') dataset<-filter(gdp,Country!='All' & GDP_nominal<input$less_country)
    else dataset <- filter(gdp,Country==input$country_ind & GDP_nominal_2017<input$less_country)
    dataset <- select(dataset,Number,Country,GDP_nominal_2017,GDP_growth,Pop,GDP_per_capita,Share)
    paste('There are',nrow(dataset),'countries selected')
    })
}

shinyApp(ui, server)
