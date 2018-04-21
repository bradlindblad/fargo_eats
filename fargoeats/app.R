library(shinydashboard)
library(shiny)
library(tidyverse)

#####################
##### D A T A #######
#####################

# Pull in restaurant data from local .R file
restaurant.data <- read.csv("restaurant_data.csv",
                            header = T)

#####################
####### F N S #######
#####################

# Pull random name restaurant from selected Type
get.restaurant <- function(x){
  
  data <-dplyr::filter(restaurant.data, Type == x) %>%
          dplyr::sample_n(size = 1,
                    replace = F)
  data <- as.character(data[1,1])
  data
  
}


#####################
####### U I #########
#####################

ui <- dashboardPage(
  
  
  ## H E A D E R
  dashboardHeader(title = "FARGO EATS"),
  
  
  ## S I D E B A R
  dashboardSidebar(
    
    h4("An interactive dashboard tool for examining trends in Fargo crime. This tool plots the locations of calls made
         to Fargo police dispatch in 2017."),
    
    br(),
    br(),
    br(),
    br(),
    
    h6("Data: http://fargond.gov/city-government/departments \n /police/police-records-data/dispatch-logs"),
    
    h6("Written by Brad Lindblad. Fargo, ND. Written in programming language R
         (R Development Core Team, 2015. Vienna, Austria. www.r-project.org) version 3.4.4 (2018-03-15)."),
    a("bradley.lindblad@gmail.com", href="mailto:bradley.lindblad@gmail.com")
  ),
  
  
  ## B O D Y
  dashboardBody(
    
    # 1st Row
    fluidRow(
      
      box(
        
        # Radio selector to select restaurant type
        radioButtons(inputId = "choose.Type",
                    label = "Choose What Kind of Food You Want",
                    choices = unique(restaurant.data$Type),
                    selected = "All",
                    inline = F,
                    width = "100%"),
        # Button to execute
        actionButton(inputId = "button.click",
                     icon = icon("utensils"),
                     label = "Get Random Restaurant"),
        
        width = 5
      )
    ),
    
    # 2nd Row
    fluidRow(
      
      box(
        
        textOutput(outputId = "final"),
        
        width = 5
        
      )


      
    )
  )
)

##################
## S E R V E R ###
##################


server <- function(input, output) {
  
  output$final <- renderText({
    
    input$button.click
    
    this <- get.restaurant(input$choose.Type)
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

