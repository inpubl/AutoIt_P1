#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

_Main_()

Func _Main_()

	Local $Select_Folder = FileSelectFolder("Select Folder" , @ScriptDir)

	If @error Then

        MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

    Else

        Local $Sample_List = _FileListToArrayRec($Select_Folder ,  "*.hwp" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)
		_ArrayDisplay($Sample_List, "hwp")

		Local $Sample_List = _FileListToArrayRec($Select_Folder ,  "*.au3" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)
		_ArrayDisplay($Sample_List, "au3")

		Local $Sample_List = _FileListToArrayRec($Select_Folder ,  "*.txt" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)
		_ArrayDisplay($Sample_List, "txt")

    EndIf

EndFunc