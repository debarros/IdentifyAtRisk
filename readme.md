## Identify At Risk Students ##
This is a short program that uses data exported from PowerSchool to identify students who are at risk of failing for the year.

This is limited to students who are failing at least 3 classes, and who are not in 12th grade

A student's risk score is calculated as the sum of the risk scores for his individual classes
- Passing - 0 risk pts
- Failing by <10 pts - 1 risk pt
- Failing by 10-20 pts - 2 risk pts
- Failing by >20 pts - 3 risk pts

The grades on which the student's risk scores are based are estimated using Q1, Q2, and E1 stored grades and Q3 current grades.  
The stored grades table should be exported (from DDE in PowerSchool) for the current year and put in the Stored tab of the 'at risk grade data.xlsx' file.  
To fill in the Current tab of the 'at risk grade data.xlsx' file, export the csv from the Percent Grades Report (under custom reports in PowerSchool).  
