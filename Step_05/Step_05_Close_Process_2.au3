Local $File_info =  "Test_File.exe"
Local $Classdata = "Notepad"
Local $hWnd = WinGetHandle("[CLASS:"&$Classdata&"]")
;~ MsgBox("","",$hWnd)
WinMove($hWnd, "", 50, 50 )
Sleep(3000)
;~ WinKill($hWnd, "")
WinClose($hWnd, "")