# Create an empty data frame to store combined data
master_data <- data.frame()

# Define the start and end dates
start_date <- as.Date("2023-03-01")
end_date <- as.Date("2024-03-31")

# Loop through each date
for (date in seq(start_date, end_date, by = "day")) {
  # Convert date to yyyymmdd format
  folder_date <- format(as.Date(date), "%Y%m%d")
  
  # Construct the folder path
  folder_path <- paste("C:/Users/rscript/sample", folder_date, sep = "/")
  
  # Check if folder exists
  if (file.exists(folder_path)) {
    # Read the TCTOOL.csv file
    file_path <- paste(folder_path, "TCTOOL.csv", sep = "/")
    if (file.exists(file_path)) {
      data <- read.csv(file_path)
      # Filter rows with bin numbers starting with 5897 or 591
      data <- data[grep("^5897|^591", data$bin), ]
      # Append date column
      data$date <- as.Date(folder_date, "%Y%m%d")
      # Append data to master_data
      master_data <- rbind(master_data, data)
    } else {
      print(paste("TCTOOL.csv file not found in", folder_date))
    }
  } else {
    print(paste("Folder not found for date", folder_date))
  }
}

# Write master_data to a single CSV file
write.csv(master_data, "C:/Users/rscript/master_data.csv", row.names = FALSE)
