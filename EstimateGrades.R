#EstimateGrades.R

EstimateGrades = function(gradeData, CurrentQuarter){
  storedgrades = gradeData$storedgrades
  currentgrades = gradeData$currentgrades
  
  if(CurrentQuarter == "Q3"){
    Terms = c("Q1", "Q2", "E1","Q3")
    
    colnames(currentgrades)[5] = "Q3Percent"
    
    currentgrades$Q1Percent = storedgrades$Percent[match(x = paste0(currentgrades$`St.#`, currentgrades$Course, "Q1"), table = storedgrades$code)]
    currentgrades$Q2Percent = storedgrades$Percent[match(x = paste0(currentgrades$`St.#`, currentgrades$Course, "Q2"), table = storedgrades$code)]
    currentgrades$E1Percent = storedgrades$Percent[match(x = paste0(currentgrades$`St.#`, currentgrades$Course, "E1"), table = storedgrades$code)]
    
    currentgrades$type = is.na(currentgrades$Q1Percent) + 2*is.na(currentgrades$Q2Percent) + 4*is.na(currentgrades$E1Percent)
    
    
    #All grades
    currentgrades$estimate = (16*currentgrades$Q1Percent + 16*currentgrades$Q2Percent + 8*currentgrades$E1Percent + 20*currentgrades$Q3Percent)/60
    
    #Q3 only
    currentgrades$estimate[currentgrades$type == 7] = currentgrades$Q3Percent[currentgrades$type == 7]
    
    #Missing Q1
    currentgrades$estimate[currentgrades$type == 1] = (16*currentgrades$Q2Percent[currentgrades$type == 1] + 8*currentgrades$E1Percent[currentgrades$type == 1] + 20*currentgrades$Q3Percent[currentgrades$type == 1])/44
    
    #Missing E1
    currentgrades$estimate[currentgrades$type == 4] = (16*currentgrades$Q2Percent[currentgrades$type == 4] + 20*currentgrades$Q3Percent[currentgrades$type == 4])/52
    
    #Missing Q1 and E1
    currentgrades$estimate[currentgrades$type == 5] = (16*currentgrades$Q2Percent[currentgrades$type == 5] + 20*currentgrades$Q2Percent[currentgrades$type == 5])/36
  } else {
    print("Grading has only been set up for Q3")
  }
  
  
  gradeData = list("storedgrades" = storedgrades, "currentgrades" = currentgrades)
  return(gradeData)
}