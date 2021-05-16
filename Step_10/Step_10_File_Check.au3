#RequireAdmin
#include <MsgBoxConstants.au3>
#include <IE.au3>
#include <String.au3>
#include <Array.au3>
#include <File.au3>
#include <InetConstants.au3>

Global $sLocalFileNum, $oIE, $sWebFileNum
Global $sUrl = "https://ohsoft.net/kor/ocam/download.php?cate=1002"

_Main_()

Func _Main_()

	_Setting_()

	Sleep(500)

	Local $aFileList = _FileListToArray(@ScriptDir, "*.exe", 1)

	Local $aFileName = _ArraySearch($aFileList, "oCam", 0, 0, 0, 3)

	If @error Then

		MsgBox($MB_SYSTEMMODAL, "Alert", "There is no file")

	Else

		Local $aFileName = _ArrayToString($aFileList)

		Local $sFileNum = _StringBetween($aFileName, "oCam_v", ".exe")

		$sLocalFileNum = $sFileNum[0]

		_CheckWebFile_()

		Sleep(500)

		_Setting_()

		Sleep(500)

	EndIf

EndFunc

Func _Setting_()

	While 1

		If ProcessExists("iexplore.exe") Then

			ProcessClose ("iexplore.exe")

		Else

			ExitLoop

		EndIf

	WEnd

EndFunc

Func _CheckWebFile_()

	$oIE = _IECreate($sUrl)

	Local $sHTML = _IEDocReadHTML($oIE)

	Local $sFileNum = _StringBetween($sHTML, "oCam_v", ".exe")

    $sWebFileNum = $sFileNum[0]

	While 1

		If $sLocalFileNum == $sWebFileNum Then

			MsgBox($MB_SYSTEMMODAL, "Build Check", "The file version is the same.")

			ExitLoop

		Else

			MsgBox($MB_SYSTEMMODAL, "Build Check", "The file version is different.")

			_Setting_()

			Sleep(500)

			_WebFileDownload_()

			Sleep(500)

			_Setting_()

			ExitLoop

		EndIf

	WEnd

EndFunc

Func _WebFileDownload_()

	$oIE = _IECreate($sUrl)

	Local $sHTML = _IEDocReadHTML($oIE)

	Local $sWebFileUrl = _StringBetween($sHTML, "https://raw.githubusercontent.com/ohsoft/archive/master/ocam/", '.exe"')

	$sWebFileUrl = $sWebFileUrl[0]

	Local $hDownload = InetGet("https://raw.githubusercontent.com/ohsoft/archive/master/ocam/" & $sWebFileUrl & ".exe", @ScriptDir & "/oCam_v" & $sWebFileNum & ".exe", 1, 1)

	Do

		Sleep(250)

	Until InetGetInfo($hDownload, 2)

EndFunc