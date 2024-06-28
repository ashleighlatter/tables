library(shiny)
library(rhandsontable)

# Load data
houseplants <- data.frame(
  Plant_Name = c("ZZ Plant", "Rubber Plant", "Monstera Deliciosa", "Boston Fern", "Peace Lily", "Fiddle Leaf Fig"),
  Purchase_Date = c("2023-11-01", "2024-05-15", "2021-03-20", "2022-12-25", "2022-06-10", "2023-07-22"),
  Light_Requirement = factor(c("Low", "Medium", "Medium", "Medium", "Low", "High"), levels = c("Low", "Medium", "High")),
  Minimum_Temperature = c(18.0, 15.0, 20.0, 16.0, 16.5, 18.5),
  Max_Height_cm = as.integer(c(100, 300, 200, 75, 60, 240)),
  Flowering_Indoors = c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE)
)

ui <- fluidPage(
  h3("Houseplant Collection"),
  rHandsontableOutput("houseplant_table"), # display table
  br(),
  downloadButton(
    outputId = "download_button",
    label = "Download", 
    icon = icon("download")
  )
)

server <- function(input, output) {
  
  # generate table
  output$houseplant_table <- renderRHandsontable(
    rhandsontable(
      houseplants,
      rowHeaders = NULL,
      colHeaders = c("Plant", "Purchase Date", "Light", "Min Temp (C)", "Max Height (cm)", "Indoor Flowering")
    ) %>% 
      hot_col("Purchase Date", type = "date", dateFormat = "YYYY-MM-DD") %>% 
      hot_validate_numeric(cols = "Max Height (cm)", min = 1, max = 300) %>% 
      hot_cell(row = 3, col = 1, comment = "Also known as the 'Swiss Cheese Plant'") %>% 
      hot_table(highlightRow = TRUE, highlightCol = TRUE) %>% 
      hot_cols(fixedColumnsLeft = 1, manualColumnMove = TRUE, manualColumnResize = TRUE)
  )
  
  output$download_button <- downloadHandler(
    filename = "houseplant_data.csv",
    content = function(file) {
      write.csv(hot_to_r(input$houseplant_table), file)
    }
  )
}

shinyApp(ui, server)
