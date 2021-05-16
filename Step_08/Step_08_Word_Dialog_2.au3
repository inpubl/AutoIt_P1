Local $Word_Window_Info= "[TITLE:TestTest.docx - Word;CLASS:OpusApp]"
Local $Word_hWnd = WinGetHandle($Word_Window_Info)
WinActivate($Word_hWnd)
Sleep(1500)
Send("{F12}")
Sleep(1500)
Local $Basic_Window_Info= "[TITLE:Save As;CLASS:#32770]"
Local $Diagle_hWnd = WinGetHandle($Basic_Window_Info)
ControlSetText($Diagle_hWnd, "", "Edit1", "TestTest")
Sleep(1500)
ControlClick($Diagle_hWnd, "", "Button9")