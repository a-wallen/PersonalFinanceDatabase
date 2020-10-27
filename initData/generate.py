# run
# python3 generate.py "attribute name" "entries"

import sys
import xlrd
import re
import random

tablename = sys.argv[1]
inserts = int(sys.argv[2])
filename = sys.argv[3]
sys.stdout = open(filename, 'w')
index = 0
found = False
attributeList = []

loc = ("datadictionary.xlsx")

wb = xlrd.open_workbook(loc)
sheet = wb.sheet_by_index(0)

for index in range(2, sheet.nrows):
    row = sheet.row_values(index)
    if row[0] == tablename:
        break

if index == sheet.nrows-1:
    sys.exit(0)

while index <  sheet.nrows:
    regexresult = re.search('[.\d]+$', row[5])
    if regexresult != None:
        try:
            attributeList.append(int(regexresult.group()))
        except:
            attributeList.append(float(regexresult.group()))
    index += 1 
    row = sheet.row_values(index)
    if row[0] != '':
        break

insertValues = []
for insert in range(inserts):
    insertValues = []
    for i in range(len(attributeList)):
        if type(attributeList[i]) == int:
            rng = random.randint(0, int(attributeList[i]))
        else:
            rng = round(random.uniform(0, float(attributeList[i])), 2)
        insertValues.append(rng)
    print("INSERT INTO", tablename, '(', end='')
    for j in range(len(attributeList)):
        if(j < len(attributeList)-1):
            print(str(insertValues[j]).rjust(len(str(attributeList[i])))+", ", end='')
        else:
            print(str(insertValues[j]).rjust(len(str(attributeList[i]))), end='')
    print(')')

