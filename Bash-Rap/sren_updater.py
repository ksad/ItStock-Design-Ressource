#!/usr/bin/env python
# -*- coding: utf-8 -*-

import xlrd
import xlutils.copy
import sys
import os
import datetime

#print (sys.argv)
filename=str(sys.argv[1])
date=sys.argv[2]
not_closed=int(sys.argv[3])
not_closed_renault=int(sys.argv[4])
resolved=int(sys.argv[5])
resolved_renault=int(sys.argv[6])
inprogress=int(sys.argv[7])
inprogress_renault=int(sys.argv[8])
inprogress_incident=int(sys.argv[9])
inprogress_support_request=int(sys.argv[10])
ar_inprogress=int(sys.argv[11])
ar_inprogress_renault=int(sys.argv[12])
ar_month=int(sys.argv[13])
fix_version1=int(sys.argv[14])
fix_version2=int(sys.argv[15])
created_month=int(sys.argv[16])
resolved_month=int(sys.argv[17])
resolved_blocker=int(sys.argv[18])
resolved_critical=int(sys.argv[19])
resolved_major=int(sys.argv[20])
resolved_minor=int(sys.argv[21])
year=str(sys.argv[22])
month=str(sys.argv[23])
outputfile=str(sys.argv[24])

inBook = xlrd.open_workbook(filename, formatting_info=True)
outBook = xlutils.copy.copy(inBook)

def _getOutCell(outSheet, colIndex, rowIndex):
    """ HACK: Extract the internal xlwt cell representation. """
    row = outSheet._Worksheet__rows.get(rowIndex)
    if not row: return None

    cell = row._Row__cells.get(colIndex)
    return cell

def setOutCell(outSheet, col, row, value):
    """ Change cell value without changing formatting. """
    # HACK to retain cell style.
    previousCell = _getOutCell(outSheet, col, row)
    # END HACK, PART I

    outSheet.write(row, col, value)

    # HACK, PART II
    if previousCell:
        newCell = _getOutCell(outSheet, col, row)
        if newCell:
            newCell.xf_idx = previousCell.xf_idx
    # END HACK

sheet = inBook.sheet_by_index(0)
outSheet = outBook.get_sheet(0)

# Update last week cells
setOutCell(outSheet, 2, 2, sheet.cell_value(rowx=2, colx=3))
setOutCell(outSheet, 2, 3, sheet.cell_value(rowx=3, colx=3))
setOutCell(outSheet, 2, 4, sheet.cell_value(rowx=4, colx=3))
setOutCell(outSheet, 2, 5, sheet.cell_value(rowx=5, colx=3))
setOutCell(outSheet, 2, 6, sheet.cell_value(rowx=6, colx=3))
setOutCell(outSheet, 2, 7, sheet.cell_value(rowx=7, colx=3))
setOutCell(outSheet, 2, 8, sheet.cell_value(rowx=8, colx=3))
setOutCell(outSheet, 2, 10, sheet.cell_value(rowx=10, colx=3))
setOutCell(outSheet, 2, 11, sheet.cell_value(rowx=11, colx=3))
setOutCell(outSheet, 2, 12, sheet.cell_value(rowx=12, colx=3))
setOutCell(outSheet, 2, 14, sheet.cell_value(rowx=14, colx=3))
setOutCell(outSheet, 2, 15, sheet.cell_value(rowx=15, colx=3))
setOutCell(outSheet, 2, 17, sheet.cell_value(rowx=17, colx=3))
setOutCell(outSheet, 2, 18, sheet.cell_value(rowx=18, colx=3))
setOutCell(outSheet, 2, 19, sheet.cell_value(rowx=19, colx=3))
setOutCell(outSheet, 2, 20, sheet.cell_value(rowx=20, colx=3))
setOutCell(outSheet, 2, 21, sheet.cell_value(rowx=21, colx=3))
setOutCell(outSheet, 2, 22, sheet.cell_value(rowx=22, colx=3))

# Col, Row
setOutCell(outSheet, 0, 2, 'Général SREN '.decode('utf8')+year)
setOutCell(outSheet, 3, 2, date)
setOutCell(outSheet, 3, 3, not_closed)
setOutCell(outSheet, 4, 3, not_closed_renault)
setOutCell(outSheet, 3, 4, resolved)
setOutCell(outSheet, 4, 4, resolved_renault)
setOutCell(outSheet, 3, 5, inprogress)
setOutCell(outSheet, 4, 5, inprogress_renault)
setOutCell(outSheet, 3, 6, inprogress_incident)
setOutCell(outSheet, 3, 7, inprogress_support_request)
setOutCell(outSheet, 3, 8, '')
setOutCell(outSheet, 3, 10, ar_inprogress)
setOutCell(outSheet, 4, 10, ar_inprogress_renault)
setOutCell(outSheet, 3, 11, ar_month)
setOutCell(outSheet, 3, 12, '')
setOutCell(outSheet, 3, 14, fix_version1)
setOutCell(outSheet, 3, 15, fix_version2)
setOutCell(outSheet, 0, 17, month+'\n(chiffres pour le mois courant)'.decode('utf8'))
setOutCell(outSheet, 3,17, created_month)
setOutCell(outSheet, 3, 18, resolved_month)
setOutCell(outSheet, 3, 19, resolved_blocker)
setOutCell(outSheet, 3, 20, resolved_critical)
setOutCell(outSheet, 3, 21, resolved_major)
setOutCell(outSheet, 3, 22, resolved_minor)

outBook.save(outputfile)
print 'Export file created : '+outputfile+' at '+os.getcwd()
