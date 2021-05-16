#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>

_Main_()

Func _Main_( $count = 5 )
	Local $aArray_1D[$Count]
	Local $Average_value = 0

	for $ii = 0 to $Count - 1
		Local $start_time = TimerInit()
		Local $iPID = Run("notepad.exe", "", @SW_SHOWMAXIMIZED)
		WinWait("[CLASS:Notepad]", "", 10)
		$aArray_1D[$ii] = Round((TimerDiff($start_time) / 1000), 2)
		$Average_value += $aArray_1D[$ii]

		Sleep(2000)
		ProcessClose($iPID)
	Next
;~ 	_ArrayDisplay($aArray_1D )
;~ 	MsgBox("",$Count &" 회  실행 평균 값 ",Round(( $Average_value/$Count ), 2) & " Sec"  )


	Local $oExcel = _Excel_Open()
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
 	Local $oWorkbook = _Excel_BookNew($oExcel)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

 	_Excel_RangeWrite($oWorkbook, Default, "No", "A1")
	_Excel_RangeWrite($oWorkbook, Default, "Time(Sec)", "B1")

	for $ii = 0 to $Count - 1
		_Excel_RangeWrite($oWorkbook, Default, $ii + 1, "A"& ($ii+2))
		_Excel_RangeWrite($oWorkbook, Default, $aArray_1D[$ii] , "B"&($ii+2))
	Next

 	_Excel_RangeWrite($oWorkbook, Default, "Average (Sec)", "D1")
	_Excel_RangeWrite($oWorkbook, Default, Round(( $Average_value/$Count ), 2) , "E1")

	If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Exit SetError(1, 0, 0)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error writing to cell 'A1'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_BookSaveAs($oWorkbook, @ScriptDir & "\_Excel.xls", Default, True)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


EndFunc