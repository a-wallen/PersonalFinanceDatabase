# run
# python3 generate.py "attribute name" "entries"

import sys
import xlrd
import re
import random

filename = sys.argv[1]
sys.stdout = open(filename, 'w')
index = 0
found = False
attributeList = []

loc = ("datadictionary.xlsx")

wb = xlrd.open_workbook(loc)
sheet = wb.sheet_by_index(0)

schema = {}
table = {}
tablename = ''

print("USE jw_group05_db;\n")

for index in range(2, sheet.nrows):
    isPrimary = False
    foreignReference = ''
    row = sheet.row_values(index)
    if row[0] != '':
        schema[tablename] = table
        tablename = row[0]
        table = {}
        if tablename == 'DONE':
            break
    if row[7] == 'Y':
        isPrimary = True
    if row[8] == 'Y':
        foreignReference = row[9]
    table[row[1]] = (isPrimary, foreignReference, row[3], row[5], row[6])
schema.pop('', None)

for table in schema:
    print("CREATE TABLE IF NOT EXISTS "+table+" (")
    for key in schema[table]:
        print(str(key).rjust(25, ' '), end='')
        print(str(schema[table][key][2]).rjust(25, ' '), end='')
        if schema[table][key][4] == 'Y':
            print(str("NOT NULL").rjust(10, ' '), end='')
        print(',')
    # this segement specifies primary key
    # how to handle two primary keys
    primaryKeys = []
    for key in schema[table]:
        if schema[table][key][0] == True:
            primaryKeys.append(key)
    foreignKeys = []
    for key in schema[table]:
        if schema[table][key][1] != '':
            foreignKeys.append((schema[table][key][1], key))
    print(str("PRIMARY KEY (").rjust(49, ' '), end='')
    for i in range(len(primaryKeys)):
        print(str(primaryKeys[i]), end ='')
        if i < len(primaryKeys)-1:
            print(", ", end='')
    if len(foreignKeys) > 0:
        print("),")
    else:
        print(")")
    for i in range(len(foreignKeys)):
        #print(str("key: "+key+" references: "+schema[table][key][1]))
        print(str('FOREIGN KEY ('+foreignKeys[i][1]+')').rjust(61, ' '))
        print(str('REFERENCES '+foreignKeys[i][0]+'('+foreignKeys[i][1]+')').rjust(61, ' '), end='')
        if i < len(foreignKeys)-1:
            print(',')
        else:
            print()

    print(");\n")

# if index == sheet.nrows-1:
#     sys.exit(0)

# while index <  sheet.nrows:
#     regexresult = re.search('[.\d]+$', row[5])
#     if regexresult != None:
#         try:
#             attributeList.append(int(regexresult.group()))
#         except:
#             attributeList.append(float(regexresult.group()))
#     index += 1 
#     row = sheet.row_values(index)
#     if row[0] != '':
#         break

# insertValues = []
# for insert in range(inserts):
#     insertValues = []
#     for i in range(len(attributeList)):
#         if type(attributeList[i]) == int:
#             rng = random.randint(0, int(attributeList[i]))
#         else:
#             rng = round(random.uniform(0, float(attributeList[i])), 2)
#         insertValues.append(rng)
#     print("INSERT INTO", tablename, '(', end='')
#     for j in range(len(attributeList)):
#         if(j < len(attributeList)-1):
#             print(str(insertValues[j]).rjust(len(str(attributeList[i])))+", ", end='')
#         else:
#             print(str(insertValues[j]).rjust(len(str(attributeList[i]))), end='')
#     print(')')

