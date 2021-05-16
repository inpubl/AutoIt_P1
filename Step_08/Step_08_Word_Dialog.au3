Local $Basic_Window_Info= "[TITLE:Save As;CLASS:#32770]"
Local $Diagle_hWnd = WinGetHandle($Basic_Window_Info)
WinActivate($Diagle_hWnd)
Local $Basic_Control_info= "[CLASS:Edit;INSTANCE:1]"
Local $Edit_hWnd = ControlGetHandle($Diagle_hWnd, "", $Basic_Control_info )
Local $Edit_Button_pos = WinGetPos($Edit_hWnd)
Local $left_value = $Edit_Button_pos[0] + $Edit_Button_pos[2]/2
Local $top_value = $Edit_Button_pos[1] + $Edit_Button_pos[3]/2
MouseClick( "left" , $left_value , $top_value )
sleep(500)
Send("^a")
sleep(500)
Send("{del}")
sleep(500)
Send("TestTest")
sleep(500)
Local $Basic_Control_info= "[CLASS:Button;INSTANCE:8]"
Local $Edit_hWnd = ControlGetHandle($Diagle_hWnd, "", $Basic_Control_info )
Local $Edit_Button_pos = WinGetPos($Edit_hWnd)
Local $left_value = $Edit_Button_pos[0] + $Edit_Button_pos[2]/2
Local $top_value = $Edit_Button_pos[1] + $Edit_Button_pos[3]/2
MouseClick( "left" , $left_value , $top_value )