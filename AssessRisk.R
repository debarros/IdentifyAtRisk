#AssessRisk.R

AssessRisk = function (gradeData, minFcount = 2, DropSeniors = T){
  storedgrades = gradeData$storedgrades
  currentgrades = gradeData$currentgrades
  
  # Get the course-subject alignments #
  # Sign in to google
  gs_auth() #this will launch a browser so you can sign into your account
  CourseSubject = gs_url("https://docs.google.com/a/greentechhigh.org/spreadsheets/d/17QhVYZkjbx34M6wBvtHUYa_XrRUlRbOtuOsQ4P5l-nk/edit?usp=sharing")
  alignment = gs_read(ss = CourseSubject)
  alignment$Course[alignment$Course == "AP Global History I"][1] = "AP Global History I "
  
  #What is the grading scale for the course?
  currentgrades$scale = alignment$`Grade Scale`[match(x = currentgrades$Course, table = alignment$Course)]
  currentgrades$scale[currentgrades$Course == "Literature 9 Lab"] = "9"
  currentgrades$Estimate2 = currentgrades$estimate + 3*(currentgrades$scale == "9")
  currentgrades$RiskScore = (currentgrades$Estimate2 < 50) + (currentgrades$Estimate2 < 60) + (currentgrades$Estimate2 < 70)
  
  #Create the student data frame
  student.df = data.frame(id = unique(currentgrades$`St.#`))
  student.df$name = currentgrades$Student[match(student.df$id, currentgrades$`St.#`)]
  student.df$GradeLevel = storedgrades$Grade_Level[match(student.df$id, storedgrades$`[1]Student_Number`)]
  student.df$TotalRisk = 0
  student.df$TotalFs = 0
  
  for(i in 1:nrow(student.df)){
    student.df$TotalRisk[i] = sum(currentgrades$RiskScore[currentgrades$`St.#` == student.df$id[i]])
    student.df$TotalFs[i] = sum(currentgrades$RiskScore > 0 & currentgrades$`St.#` == student.df$id[i])
  }
  
  #limit to grades 9-11?
  if(DropSeniors){
    student.df2 = student.df[student.df$GradeLevel < 12,]
  }  else {
    student.df2 = student.df
  }
  student.df2 = student.df2[student.df2$TotalFs >= minFcount,c(2,1,3,5,4)]  #limit to students who are failing at least minFcount classes
  student.df2 = student.df2[order(student.df2$TotalRisk),]
  
  
  gradeData = list("storedgrades" = storedgrades, "currentgrades" = currentgrades, "student.df" = student.df2)
  return(gradeData)
}