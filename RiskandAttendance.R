#RiskandAttendance.R

View(gradeData$student.df)

str(students)
students$attendanceRisk = 
  10 * (students$`Absence Unexcused` + students$`ISS Absent unexcused`) + 
  5 * students$`Tardy Unexcused` + 
  4 * (students$`Absence Excused` + students$`ISS Absent Excused`) + 
  1 * (students$`ISS Tardy Excused` + students$`Tardy Excused`)

hist(students$attendanceRisk)

students$attendanceRiskz = (students$attendanceRisk - mean(students$attendanceRisk))/ sd(students$attendanceRisk)
                            
students$attendanceRiskCategory = floor(students$attendanceRiskz)

summary(students$attendanceRiskCategory)
table(students$attendanceRiskCategory)

students$gradeRiskLevel = gradeData$student.df$TotalRisk[match(x = students$studentNumber, gradeData$student.df$id)]

students = students[!is.na(students$gradeRiskLevel),]

table(students[,c("gradeRiskLevel", "attendanceRiskCategory")])

sum(students$attendanceRiskCategory > 1)


students$attendanceRiskLabel = factor(x = "Low", levels = c("Low", "Moderate", "High"), labels = c("Low", "Moderate", "High"))
students$attendanceRiskLabel[students$attendanceRiskCategory > -1] = "Moderate"
students$attendanceRiskLabel[students$attendanceRiskCategory > 1] = "High"

students$gradeRiskLabel = factor(x = "Low", levels = c("Low", "Moderate", "High"), labels = c("Low", "Moderate", "High"))
students$gradeRiskLabel[students$gradeRiskLevel > 3] = "Moderate"
students$gradeRiskLabel[students$gradeRiskLevel > 6] = "High"



table(students[,c("attendanceRiskLabel", "gradeRiskLabel")])

