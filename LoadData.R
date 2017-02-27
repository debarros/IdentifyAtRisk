#LoadData.R

LoadData = function(filename){
  storedgrades = read.xlsx(xlsxFile = filename, sheet = "Stored") #load stored grades
  currentgrades = read.xlsx(xlsxFile = filename, sheet = "Current") #load current grades
  
  #Clean data
  storedgrades$Percent[is.na(storedgrades$Grade)] = NA
  storedgrades$code = paste0(storedgrades$`[1]Student_Number`, storedgrades$Course_Name, storedgrades$StoreCode)
  
  #check data
  if (length(unique(storedgrades$code)) !=  nrow(storedgrades)){
    print("Hold up, there's a problem.")
  }
  
  #build and return the grade data object
  gradeData = list("storedgrades" = storedgrades, "currentgrades" = currentgrades)
  return(gradeData)
}