#MainScript.R

#Generate risk scores for students
#This is limited to students who are failing at least 3 classes, and who are not in 12th grade

#A student's risk score is calculated as the sum of the risk scores for his individual classes
# Passing - 0 risk pts
# Failing by <10 pts - 1 risk pt
# Failing by 10-20 pts - 2 risk pts
# Failing by >20 pts - 3 risk pts

#The grades on which the student's risk scores are based are estimated using the stored grades from prior terms and the current grades from the current term
#The stored grades table should be exported (from DDE in PowerSchool) for the current year and put in the Stored tab of the 'at risk grade data.xlsx' file
#To fill in the Current tab of the 'at risk grade data.xlsx' file, export the csv from the Percent Grades Report (under custom reports in PowerSchool)

#Load functions
source("functions.R")

#set the quarter
CurrentQuarter = "Q3" 

#Load data
gradeData = LoadData("J:/IdentifyAtRisk/at risk grade data.xlsx") #if the data is stored somewhere else, change the filename here

#Estimate course grades
gradeData = EstimateGrades(gradeData, CurrentQuarter)

#Get the grading scales, calculate risk scores, and create the student risk table
#This may launch a browser window for you to sign into google
gradeData = AssessRisk(gradeData, minFcount = 0, DropSeniors = F)

#output the risk table to "J:/IdentifyAtRisk/StudentRiskTable.xlsx"
CreateOutput(gradeData)

#Output a table with all the students with a particular number of F's
ByNumberOfFs(gradeData, Fcount = 3)
  

str(gradeData)

