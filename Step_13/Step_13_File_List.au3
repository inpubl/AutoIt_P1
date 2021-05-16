#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Global $sFileFolder
Global $sFilelistName
Global $sFilelist

_Main_()

Func _Main_()

	$sFileFolder = FileSelectFolder("Select a folder", "")

	If @error Then

        MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

    Else

        _FileListName_()

		RunWait(@ComSpec & " /c dir /b *.hwp *.doc *.docx *.xls *.xlsx *.ppt *.pptx > " & '"' & $sFilelist & '"', $sFileFolder, @SW_HIDE)

		_FileCompare_()

    EndIf

EndFunc

Func _FileListName_()

	Local $iVar = StringSplit($sFileFolder, "\", 0)

	Local $sDir = $iVar[$iVar[0]]

	$sFilelistName = $sDir & ".txt"

	$sFilelist = @ScriptDir & "\" & $sFilelistName

EndFunc

Func _FileCompare_()

	Local $sFilePath = @ScriptDir & "\history\" & $sFilelistName

	Local $hFileOpen = FileOpen($sFilePath, $FO_READ)

    Local $sReadOldFile = FileRead($hFileOpen)

    FileClose($hFileOpen)

	Local $hFileOpen = FileOpen($sFilelist, $FO_READ)

    Local $sReadNewFile = FileRead($hFileOpen)

    FileClose($hFileOpen)

	If $sReadOldFile == $sReadNewFile Then

		MsgBox($MB_SYSTEMMODAL, "File Compare", "The file is the same.")

	Else

		MsgBox($MB_SYSTEMMODAL, "File Compare", "The file is different.")

	EndIf

EndFunc