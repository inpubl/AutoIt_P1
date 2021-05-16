#RequireAdmin
#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <Array.au3>

_Main_()

Func _Main_()

	Local $idButton1, $idButton2, $idButton3, $idButton4, $idButton5
	Local $hGUI

	$hGUI = GUICreate("Cache Delete", 300, 60)

	$idButton1 = GUICtrlCreateButton("1", 10, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, @ProgramFilesDir & "\Internet Explorer\iexplore.exe", 1)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton2 = GUICtrlCreateButton("2", 70, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "C:\Program Files\Google\Chrome\Application\chrome.exe", 1)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton3 = GUICtrlCreateButton("3", 130, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, @UserProfileDir & "\AppData\Local\Mozilla Firefox\firefox.exe", 1)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton4 = GUICtrlCreateButton("4", 190, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 11)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton5 = GUICtrlCreateButton("5", 250, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 144)
	GUICtrlSetState(-1, $GUI_ENABLE)

	GUISetState(@SW_SHOW, $hGUI)

	While 1

		Switch GUIGetMsg()

			Case $GUI_EVENT_CLOSE

				ExitLoop

			Case $idButton1

				Local $hGUI1 = GUICreate("Confirm", 300, 100)

				Local $idStartlabel = GUICtrlCreateLabel("Are you sure you want to clear the cache" & @CRLF & "(The browser will close)", 10, 10, 280, 50)

				Local $idYes = GUICtrlCreateButton("Yes", 60, 70, 85, 25)
				Local $idNo = GUICtrlCreateButton("No", 150, 70, 85, 25)

				GUISetState(@SW_SHOW, $hGUI1)

				While 1

					Switch GUIGetMsg()

						Case $GUI_EVENT_CLOSE, $idNo

							GUIDelete($hGUI1)

							ExitLoop

						Case $idYes

							GUIDelete($hGUI1)

							_Setting_()

							_IE_()

							MsgBox($MB_SYSTEMMODAL, "Cache Delete", "Cache deleted successfully")

							ExitLoop

					EndSwitch

				WEnd

			Case $idButton2

				Local $hGUI1 = GUICreate("Confirm", 300, 100)

				Local $idStartlabel = GUICtrlCreateLabel("Are you sure you want to clear the cache" & @CRLF & "(The browser will close)", 10, 10, 280, 50)

				Local $idYes = GUICtrlCreateButton("Yes", 60, 70, 85, 25)
				Local $idNo = GUICtrlCreateButton("No", 150, 70, 85, 25)

				GUISetState(@SW_SHOW, $hGUI1)

				While 1

					Switch GUIGetMsg()

						Case $GUI_EVENT_CLOSE, $idNo

							GUIDelete($hGUI1)

							ExitLoop

						Case $idYes

							GUIDelete($hGUI1)

						    Local $aFileList = _FileListToArray(@ScriptDir, "*.bat", 1)

						    Local $aFileName = _ArraySearch($aFileList, "Chrome.bat")

						    If @error Then

							  MsgBox($MB_SYSTEMMODAL, "Alert", "There is no file(Chrome.bat)")

						    Else

							  _Setting_()

							  _Chrome_()

							  MsgBox($MB_SYSTEMMODAL, "Cache Delete", "Cache deleted successfully")

						    EndIf

							ExitLoop

					EndSwitch

				WEnd

			Case $idButton3

				Local $hGUI1 = GUICreate("Confirm", 300, 100)

				Local $idStartlabel = GUICtrlCreateLabel("Are you sure you want to clear the cache" & @CRLF & "(The browser will close)", 10, 10, 280, 50)

				Local $idYes = GUICtrlCreateButton("Yes", 60, 70, 85, 25)
				Local $idNo = GUICtrlCreateButton("No", 150, 70, 85, 25)

				GUISetState(@SW_SHOW, $hGUI1)

				While 1

					Switch GUIGetMsg()

						Case $GUI_EVENT_CLOSE, $idNo

							GUIDelete($hGUI1)

							ExitLoop

						Case $idYes

							GUIDelete($hGUI1)

							_Setting_()

							Sleep(500)

							_FF_()

							Sleep(500)

							MsgBox($MB_SYSTEMMODAL, "Cache Delete", "Cache deleted successfully")

							ExitLoop

					EndSwitch

				WEnd

			Case $idButton4

				Local $hGUI1 = GUICreate("Confirm", 300, 100)

				Local $idStartlabel = GUICtrlCreateLabel("Are you sure you want to clear the cache" & @CRLF & "(The browser will close)", 10, 10, 280, 50)

				Local $idYes = GUICtrlCreateButton("Yes", 60, 70, 85, 25)
				Local $idNo = GUICtrlCreateButton("No", 150, 70, 85, 25)

				GUISetState(@SW_SHOW, $hGUI1)

				While 1

					Switch GUIGetMsg()

						Case $GUI_EVENT_CLOSE, $idNo

							GUIDelete($hGUI1)

							ExitLoop

						Case $idYes

							GUIDelete($hGUI1)

							_Setting_()

							Sleep(500)

							_DNS_()

							Sleep(500)

							MsgBox($MB_SYSTEMMODAL, "Cache Delete", "Cache deleted successfully")

							ExitLoop

					EndSwitch

				WEnd

			Case $idButton5

				Local $hGUI1 = GUICreate("Confirm", 300, 100)

				Local $idStartlabel = GUICtrlCreateLabel("Are you sure you want to clear the cache" & @CRLF & "(The browser will close)", 10, 10, 280, 50)

				Local $idYes = GUICtrlCreateButton("Yes", 60, 70, 85, 25)
				Local $idNo = GUICtrlCreateButton("No", 150, 70, 85, 25)

				GUISetState(@SW_SHOW, $hGUI1)

				While 1

					Switch GUIGetMsg()

						Case $GUI_EVENT_CLOSE, $idNo

							GUIDelete($hGUI1)

							ExitLoop

						Case $idYes

							GUIDelete($hGUI1)

						    Local $aFileList = _FileListToArray(@ScriptDir, "*.bat", 1)

						    Local $aFileName = _ArraySearch($aFileList, "Chrome.bat")

						    If @error Then

							  MsgBox($MB_SYSTEMMODAL, "Alert", "There is no file(Chrome.bat)")

						    Else

							  _Setting_()

							  Sleep(500)

							  _IE_()

							  Sleep(500)

							  _Chrome_()

							  Sleep(500)

							  _FF_()

							  Sleep(500)

							  _DNS_()

							  Sleep(500)

							  MsgBox($MB_SYSTEMMODAL, "Cache Delete", "Cache deleted successfully")

						    EndIf

					        ExitLoop

					EndSwitch

				WEnd

		EndSwitch

	WEnd

	GUIDelete()

EndFunc

Func _Setting_()

	While 1

		If ProcessExists("cmd.exe") Then

			ProcessClose ("cmd.exe")

		Else

			ExitLoop

		EndIf

	WEnd

	Sleep(500)

EndFunc

Func _IE_()

	Run(@ComSpec & " /c RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255")

	While 1

		If ProcessExists("cmd.exe") Then

			Sleep(500)

		Else

			ExitLoop

		EndIf

	WEnd

EndFunc

Func _Chrome_()

	Run(@ComSpec & " /c Chrome.bat")

	While 1

		If ProcessExists("cmd.exe") Then

			Sleep(500)

		Else

			ExitLoop

		EndIf

	WEnd

EndFunc

Func _FF_()

	Run(@ComSpec & " /c rd /s /q " & @UserProfileDir & "\AppData\Local\Mozilla\Firefox\Profiles")

	While 1

		If ProcessExists("cmd.exe") Then

			Sleep(500)

		Else

			ExitLoop

		EndIf

	WEnd

EndFunc

Func _DNS_()

	Run(@ComSpec & " /c ipconfig/flushdns")

	While 1

		If ProcessExists("cmd.exe") Then

			Sleep(500)

		Else

			ExitLoop

		EndIf

	WEnd

EndFunc