#RequireAdmin
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>

_Main_()

Func _Main_()

	Local $aFileList = _FileListToArray(@ScriptDir, "*.EXE", 1)

	Local $aFileName = _ArraySearch($aFileList, "BDCAMSETUP_KOR.EXE")

	If @error Then

		MsgBox($MB_SYSTEMMODAL, "Alert", "There is no file(BDCAMSETUP_KOR.EXE)")

	Else

		Run(@ScriptDir & "\BDCAMSETUP_KOR.EXE")

		Sleep(1000)

		While 1

			If ProcessExists("BDCAMSETUP_KOR.EXE") Then

				ExitLoop

			EndIf

		WEnd

		While 1

			Local $sText = WinGetText("[ACTIVE]")

			If StringInStr($sText, "반디캠 설치를 시작합니다.") Then

				Local $hWnd = WinGetHandle("[ACTIVE]")

				ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")

				ExitLoop

			EndIf

		WEnd

		Sleep(1000)

		While 1

			Local $sText = WinGetText("[ACTIVE]")

			If StringInStr($sText, "사용권 계약") Then

				Local $hWnd = WinGetHandle("[ACTIVE]")

				ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")

				ExitLoop

			EndIf

		WEnd

		Sleep(1000)

		While 1

			Local $sText = WinGetText("[ACTIVE]")

			If StringInStr($sText, "구성 요소 선택") Then

				Local $hWnd = WinGetHandle("[ACTIVE]")

				ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")

				ExitLoop

			EndIf

		WEnd

		Sleep(1000)

		While 1

			Local $sText = WinGetText("[ACTIVE]")

			If StringInStr($sText, "설치 위치 선택") Then

				Local $hWnd = WinGetHandle("[ACTIVE]")

				ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")

				ExitLoop

			EndIf

		WEnd

		Sleep(1000)

		While 1

			Local $sText = WinGetText("[ACTIVE]")

			If StringInStr($sText, "반디캠 설치 완료") Then

				Local $hWnd = WinGetHandle("[ACTIVE]")

				ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")

				ExitLoop

			EndIf

			Sleep(500)

		WEnd

		Sleep(1000)

	EndIf

EndFunc ;_Main_()


