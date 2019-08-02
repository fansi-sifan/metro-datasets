#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
load("../co_all.rda")
load("../cbsa_all.rda")
load("../list_co_all.rda")
load("../list_cbsa_all.rda")

load("../../metro.data/data/county_cbsa_st.rda")

# temp = list.files(path = "../", pattern = ".rda", recursive = T)

# list_cbsa_all <- gsub("\\/(.*)\\.rda","",temp[grep("cbsa_",temp)])
# list_co_all <- gsub("\\/co_(.*)\\.rda","",temp[grep("county_|co_",temp)])


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("metro data warehouse"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput(
          'e0', "0. Select geography:", choices = c("county","metro")
        ) ,
        selectizeInput(
          'places', "1. Search and select the places:", choices = county_cbsa_st$co_name, multiple = TRUE
        ),
        selectizeInput(
          'datasets', "2. Search and select the datasets:", choices = names(list_co_all), multiple = TRUE
        ),
        actionButton("update", "Show data")
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("table")
        )
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output,session) {
  
  info <- eventReactive(input$update,{

    codes <- (county_cbsa_st%>%filter(co_name %in% input$places))$stco_code
    columns <- unlist(list_co_all[input$datasets], use.names = F)
    
    df <- co_all %>%
      filter(stco_code %in% codes)%>%
      select(columns)

    # updateSelectizeInput(session, 'places', "1. Search and select the places:", choices = county_cbsa_st$co_name, multiple = TRUE)
    # updateSelectizeInput(session, 'datasets', "2. Search and select the datasets:", choices = names(list_co_all), multiple = TRUE)

  })
  # 
  # output$content <- renderTable(
  #   df <- co_all %>%
  #     filter(co_name %in% places)%>%
  #     select(list_co_all[[unlist(input$datasets)]]),
  #   head(df)
  # )
  
  output$table <- DT::renderDataTable({
    df <- info()
    
    DT::datatable(
      df, 
      options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
      
    )})
}

# Run the application 
shinyApp(ui = ui, server = server)

