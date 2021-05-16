#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

_Main_()

Func _Main_()

	Local $idButton1, $idButton2, $idButton3, $idButton4, $idButton5
	Local $hGUI

	$hGUI = GUICreate("Favorite Bar", 300, 60)

	GUISetState(@SW_SHOW, $hGUI)

	$idButton1 = GUICtrlCreateButton("1", 10, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 5)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton2 = GUICtrlCreateButton("2", 70, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, @ProgramFilesDir & "\Internet Explorer\iexplore.exe", 1)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton3 = GUICtrlCreateButton("3", 130, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "C:\Program Files (x86)\AutoIt3\Au3Info.exe", 1)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton4 = GUICtrlCreateButton("4", 190, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 22)
	GUICtrlSetState(-1, $GUI_ENABLE)
	$idButton5 = GUICtrlCreateButton("5", 250, 10, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 33)
	GUICtrlSetState(-1, $GUI_DISABLE)

	While 1

		Switch GUIGetMsg()

			Case $GUI_EVENT_CLOSE

			   ExitLoop

			Case $idButton1

			   ;run("C:\Windows\explorer.exe")

			   run(@ComSpec & " /c " & "explorer.exe")

			Case $idButton2

			   ;run(@ProgramFilesDir & "\Internet Explorer\iexplore.exe")

			   ShellExecute("iexplore.exe", "http://www.naver.com")

			Case $idButton3

			   run("C:\Program Files (x86)\AutoIt3\Au3Info.exe")

			Case $idButton4

			   MsgBox($MB_SYSTEMMODAL, "Alert", "Hello Autoit")

			Case $idButton5

			   MsgBox($MB_SYSTEMMODAL, "Alert", "Hello Autoit")

		EndSwitch

	WEnd

	GUIDelete()

EndFunc ; _Main_()