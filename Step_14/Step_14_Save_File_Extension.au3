#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Global $Sample_List
Global $sFilePath

_Main_()

Func _Main_()

	Local $Select_Folder = FileSelectFolder("Select Folder" , @ScriptDir)

	If @error Then

        MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

    Else

        $Sample_List = _FileListToArrayRec($Select_Folder ,  "*.hwp" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)

		_Export_()

		ShellExecute($sFilePath)

    EndIf

EndFunc

Func _Export_()

	$sFilePath = @ScriptDir & "\File_Extension.txt"

	_FileWriteFromArray($sFilePath, $Sample_List, 1)

EndFunc