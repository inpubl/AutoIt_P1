#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Global $Sample_List

_Main_()

Func _Main_()

	Local $Select_Folder = FileSelectFolder("Select Folder" , @ScriptDir)

	If @error Then

        MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

    Else

        $Sample_List = _FileListToArrayRec($Select_Folder ,  "*.au3" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)

		_Export_()

    EndIf

EndFunc

Func _Export_()

	Local $Excel = ObjCreate("Excel.Application")

	$Excel.Visible = 1

	$Excel.workbooks.add

	With $Excel.activesheet

		For $i = 1 To $i + 1

			If $i = 1 Then

				.cells(1, 1).value = "No."
				.cells(1, 2).value = "File"

			Else

				For $j = 1 To $Sample_List[$j]

				   .cells($j + 1, 1).value = $j
				   .cells($j + 1, 2).value = $Sample_List[$j]

				Next

			EndIf

		Next

	EndWith

EndFunc