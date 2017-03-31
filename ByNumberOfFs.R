#ByNumberOfFs.R

#identify students by number of F's
Fcount = 2

d3 = read.csv(file.choose(), stringsAsFactors = F) #select the csv downloaded from the Percent Grades Report
studentFrame = data.frame(StudentNumber = unique(d3$St..))
studentFrame$Student = d3$Student[match(studentFrame$StudentNumber, d3$St..)]
d4 = gradeData$storedgrades
studentFrame$GradeLevel = d4$Grade_Level[match(studentFrame$StudentNumber, d4$`[1]Student_Number`)]


studentFrame$Fs = 0
for(i in 1:nrow(studentFrame)){
  studentFrame$Fs[i] = sum(d3$St.. == studentFrame$StudentNumber[i] & d3$Grade == "F")
}

summary(studentFrame)

output = studentFrame[studentFrame$Fs == Fcount,]

output = output[order(output$GradeLevel, output$Student),]


write.csv(x = output, file = paste0("Students_With_",Fcount, "_Fs.csv"))
