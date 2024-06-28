library(rhandsontable)

# Sample dataset
houseplants <- data.frame(
  Plant_Name = c("ZZ Plant", "Rubber Plant", "Monstera Deliciosa", "Boston Fern", "Peace Lily", "Fiddle Leaf Fig"),
  Purchase_Date = c("2023-11-01", "2024-05-15", "2021-03-20", "2022-12-25", "2022-06-10", "2023-07-22"),
  Light_Requirement = factor(c("Low", "Medium", "Medium", "Medium", "Low", "High"), levels = c("Low", "Medium", "High")),
  Minimum_Temperature = c(18.0, 15.0, 20.0, 16.0, 16.5, 18.5),
  Max_Height_cm = as.integer(c(100, 300, 200, 75, 60, 240)),
  Flowering_Indoors = c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE)
)

# Simple table
rhandsontable(houseplants) %>% 
  # Specify date format
  hot_col("Purchase_Date", type = "date", dateFormat = "YYYY-MM-DD")

# Read only
rhandsontable(houseplants) %>% 
  hot_cell(row = 3, col = 3, readOnly = TRUE)

rhandsontable(houseplants) %>% 
  hot_col(col = "Minimum_Temperature", readOnly = TRUE)

rhandsontable(houseplants) %>% 
  hot_col(col = c("Minimum_Temperature", "Max_Height_cm"), readOnly = TRUE)

rhandsontable(houseplants) %>% 
  hot_row(row = 3, readOnly = TRUE)

# Comments
rhandsontable(houseplants) %>% 
  hot_cell(row = 3, col = 1, comment = "Also known as the 'Swiss Cheese Plant'")

# Highlight row and column
rhandsontable(houseplants) %>% 
  hot_table(highlightRow = TRUE, highlightCol = TRUE)

# Freeze rows and columns
rhandsontable(houseplants) %>% 
  hot_cols(fixedColumnsLeft = 1) %>% 
  hot_rows(fixedRowsTop = 1)

# Move and resize columns
rhandsontable(houseplants) %>% 
  hot_cols(manualColumnMove = TRUE, manualColumnResize = TRUE)

# Numeric data validation
rhandsontable(houseplants) %>% 
  hot_validate_numeric(cols = "Max_Height_cm", min = 1, max = 300)

# Remove row names
rhandsontable(houseplants, rowHeaders = NULL)

# Edit column names
rhandsontable(
  houseplants, 
  colHeaders = c("Plant", "Purchase Date", "Light", "Min Temp (C)", "Max Height (cm)", "Indoor Flowering"))
