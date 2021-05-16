#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>

Opt("TrayMenuMode", 3)

_Main_()

Func _Main_()

   Local $idButton1 = TrayCreateItem("File Explorer", -1, -1, $TRAY_ITEM_NORMAL)
   Local $idButton2 = TrayCreateItem("Internet Explorer", -1, -1, $TRAY_ITEM_NORMAL)
   Local $idButton3 = TrayCreateItem("AutoIt Info", -1, -1, $TRAY_ITEM_NORMAL)
   Local $idButton4 = TrayCreateItem("MsgBox1", -1, -1, $TRAY_ITEM_NORMAL)
   Local $idButton5 = TrayCreateItem("MsgBox2", -1, -1, $TRAY_ITEM_NORMAL)
   TrayCreateItem("") ; Create a separator line.
   Local $idExit = TrayCreateItem("Exit")
   TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

   While 1

	  Switch TrayGetMsg()

		 Case $idButton1

			run(@ComSpec & " /c " & "explorer.exe")

		 Case $idButton2

			ShellExecute("iexplore.exe", "http://www.naver.com")

		 Case $idButton3

			run("C:\Program Files (x86)\AutoIt3\Au3Info.exe")

		 Case $idButton4

			MsgBox($MB_SYSTEMMODAL, "Alert", "Hello Autoit")

		 Case $idButton5

			MsgBox($MB_SYSTEMMODAL, "Alert", "Hello Autoit")

		 Case $idExit ; Exit the loop.

			ExitLoop

	  EndSwitch

   WEnd

EndFunc ; _Main_()