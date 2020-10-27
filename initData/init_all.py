import sys
import os
import xlrd

numlines = int(sys.argv[1])

loc = ("datadictionary.xlsx")

wb = xlrd.open_workbook(loc)
sheet = wb.sheet_by_index(0)

for index in range(2, sheet.nrows):
    row = sheet.row_values(index)
    if row[0] != '':
        os.system("generate.py "+row[0]+" "+str(numlines)+" scripts/"+row[0]+".txt")
    