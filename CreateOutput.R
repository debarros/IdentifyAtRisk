#CreateOutput.R

CreateOutput = function(gradeData){
  student.df2 = gradeData$student.df
  wb = createWorkbook()
  addWorksheet(wb, sheetName = "RiskScores")
  freezePane(wb, "RiskScores", firstActiveRow = 2, firstActiveCol = 2)
  setColWidths(wb, "RiskScores", cols = 1:5, widths = "auto", ignoreMergedCells = FALSE)
  addStyle(wb, "RiskScores", createStyle(textDecoration = "bold"), rows = 1, cols = 1:5, gridExpand = T, stack = T)
  writeData(wb, "RiskScores", student.df2)
  saveWorkbook(wb = wb, file = "StudentRiskTable.xlsx",overwrite = T)
}