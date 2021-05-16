#include <Array.au3>
#include <File.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

Global $FileOpenDialog
Global $Excel_Read
Global $Excel_BookOpen_New
Global $String

_Main_()

Func _Main_()

	Local $Title = "Select a File"

	$FileOpenDialog = FileOpenDialog($Title, @ScriptDir & "\", "Excel (*.xls;*.xlsx)", $FD_FILEMUSTEXIST)

	If @error Then

        MsgBox($MB_SYSTEMMODAL, "", "No file was selected.")

    Else

        _Excel_Read_()

		Sleep(1000)

		Local $Excel_Open_New = _Excel_Open()

		$Excel_BookOpen_New = _Excel_BookNew($Excel_Open_New, 2)

		For $i=0 To 4 Step $i+1

			MsgBox($MB_SYSTEMMODAL, "Alert", $Excel_Read[$i])

			$String = $Excel_Read[$i]

			_Excel_Action_()

			Sleep(1000)

		Next

    EndIf

EndFunc

Func _Excel_Read_()

	Local $Excel_Open = _Excel_Open()

	Local $Excel_BookOpen = _Excel_BookOpen($Excel_Open, $FileOpenDialog)

	If @error Then

		MsgBox($MB_SYSTEMMODAL, "Alert", "Error opening workbook")

		_Excel_Close($Excel_Open)

		Exit

	EndIf

	$Excel_Read = _Excel_RangeRead($Excel_BookOpen, Default, $Excel_BookOpen.ActiveSheet.Usedrange.Columns("A:A"), 2)

	_Excel_Close($Excel_Open)

EndFunc

Func _Excel_Action_()

	If StringLeft(StringLower($String), 4) = "Bold" Then

		Send("!{H}{1}")

	ElseIf StringLeft(StringLower($String), 6) = "Figure" Then

		Send("!{N}{S}{H}")

		Send("{DOWN}")

		Send("{DOWN}")

		Send("{DOWN}")

		Send("{ENTER}")

	ElseIf StringLeft(StringLower($String), 5) = "Image" Then

		Send("!{N}{P}")

		Send("{ENTER}")

		Sleep(1000)

		Send("C:\RPA_Autoit\Step_18\autoit_image.jpg")

		Send("{ENTER}")

	ElseIf StringLeft(StringLower($String), 4) = "Chat" Then

		Send("!{N}{R}")

		Send("{RIGHT}")

		Send("{ENTER}")

	Else

		_Excel_RangeWrite($Excel_BookOpen_New, $Excel_BookOpen_New.ActiveSheet, $String)

	EndIf

EndFunc