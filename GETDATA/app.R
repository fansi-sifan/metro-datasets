#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# TO DO
# ( ) SWITCH BETWEEN COUNTY/CBSA
# ( ) DOWNLOAD DATASETS

library(dplyr)
library(shiny)
load("../co_all.rda")
load("../cbsa_all.rda")
load("../list_all_co.rda")
load("../list_all_cbsa.rda")

load("../xwalk/county_cbsa_st.rda")

# temp = list.files(path = "../", pattern = ".rda", recursive = T)

# list_cbsa_all <- gsub("\\/(.*)\\.rda","",temp[grep("cbsa_",temp)])
# list_co_all <- gsub("\\/co_(.*)\\.rda","",temp[grep("county_|co_",temp)])


# Define UI for application that draws a histogram
ui <- navbarPage(
  "Metro Data Warehouse",
  tabPanel(
    "County",

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectizeInput(
          "co_places", "1. Search and select the places:",
          choices = county_cbsa_st$co_name, multiple = TRUE
        ),
        selectizeInput(
          "co_datasets", "2. Search and select the datasets:",
          choices = names(list_all_co), multiple = TRUE
        ),
        actionButton("update_co", "Show county data")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("table_co")
      )
    )
  ),
  tabPanel(
    "Metro",
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectizeInput(
          "cbsa_places", "1. Search and select the places:",
          choices = county_cbsa_st$cbsa_name, multiple = TRUE
        ),
        selectizeInput(
          "cbsa_datasets", "2. Search and select the datasets:",
          choices = names(list_all_cbsa), multiple = TRUE
        ),
        actionButton("update_cbsa", "Show metro data")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("table_cbsa")
      )
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  info_co <- eventReactive(input$update_co, {
    co_codes <- (county_cbsa_st %>% filter(co_name %in% input$co_places))$stco_code
    co_columns <- unlist(list_all_co[input$co_datasets], use.names = F)
    co_df <- co_all %>%
      filter(stco_code %in% co_codes) %>%
      select(co_columns)%>%
      unique()

  })
  
  info_cbsa <- eventReactive(input$update_cbsa, {
    cbsa_codes <- (county_cbsa_st %>% filter(cbsa_name %in% input$cbsa_places))$cbsa_code
    cbsa_columns <- unlist(list_all_cbsa[input$cbsa_datasets], use.names = F)
    cbsa_df <- cbsa_all %>%
      filter(cbsa_code %in% cbsa_codes) %>%
      select(cbsa_columns) %>%
      unique()
    
  })

  output$table_co <- DT::renderDataTable({
    co_df <- info_co()

    DT::datatable(
      co_df,
      options = list(
        lengthMenu = list(c(5, 15, -1), c("5", "15", "All")),
        pageLength = 15
      )
    )
  })
  
  output$table_cbsa <- DT::renderDataTable({
    cbsa_df <- info_cbsa()
    
    DT::datatable(
      cbsa_df,
      options = list(
        lengthMenu = list(c(5, 15, -1), c("5", "15", "All")),
        pageLength = 15
      )
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
