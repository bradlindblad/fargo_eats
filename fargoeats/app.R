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
    
    h4("A basic webapp to help you decide where to eat in Fargo, ND."),
    
    br(),
    br(),
    br(),
    br(),
    

    h6("Written by Brad Lindblad. Fargo, ND. Written in programming language R
         (R Core Team (2018). R: A language and environment for statistical computing. R Foundation for Statistical
          Computing, Vienna, Austria. URL https://www.R-project.org/) version 3.4.4 (2018-03-15)."),
    
    a("bradley.lindblad@gmail.com", href = "mailto:bradley.lindblad@gmail.com")
  ),
  
  
  ## B O D Y
  dashboardBody(
    
    # 1st Row
    fluidRow(
      
      box(
        
        h6("When you can't decide where to eat in Fargo"),
        br(),
        h6("Click the box to pick which kind of food you want, then hit the button below until you
           find a restaurant you like"),
        width = 5
      )
    ),
    
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

