# python3 genDumbData.py "outputfile" "entries per table"

import sys
import xlrd
import re
import random

filename = sys.argv[1]
entries = int(sys.argv[2])
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

primaryKeys = {}
for table in schema:
    for attribute in schema[table]:
        if schema[table][attribute][0] == True:
            regexresult = re.search('[.\d]+$', schema[table][attribute][3])
            if regexresult != None:
                primaryKeys[attribute] =  regexresult.group()

pks = {}
for key in primaryKeys:
    temp = []
    for i in range(entries):
        temp.append(random.randint(0, int(primaryKeys[key])))
    pks[key] = temp

for table in schema:
    print("\n")
    for i in range(entries):
        print(str("INSERT INTO "+table+" ("), end='')
        count = 0
        for attribute in schema[table]:
            count += 1
            if attribute in pks.keys():
                print((str(pks[attribute][random.randint(0, len(pks[attribute])-1)])).rjust(14, ' '), end='')
            else: 
                regexresult = re.search('[.\d]+$', schema[table][attribute][3])
                if regexresult != None:
                    try:
                        int(regexresult.group())
                    except ValueError:
                        rng = round(random.uniform(0, float(regexresult.group())),2)
                    else:
                        rng = random.randint(0, int(regexresult.group()))
                    print(str(rng).rjust(14, ' '), end='')
                else:
                    # YYYYMMDDhhmmss
                    print(random.randint(2018, 2020), end='')
                    print(random.randint(10, 12), end='')
                    print(random.randint(10, 28), end='')
                    print(random.randint(10, 60), end='')
                    print(random.randint(10, 60), end='')
            if count < len(schema[table]):
                print(", ", end='')
        print(");")
