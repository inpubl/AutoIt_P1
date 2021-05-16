#include <VM_Moudle.au3>

If _Singleton('WM_COPYDATA', 1) = 0 Then
	MsgBox(262160, '알림', '서버 프로그램이 이미 실행중입니다.')
	Exit
EndIf

_Server_Main_()

Func _Server_Main_()
	$hWnd = GUICreate($sServerTitle, 320, 372, 60, 0, -1, $WS_EX_TOPMOST)
	GUISetState()
	WinSetTitle($hWnd, '', $sServerTitle )
	GUIRegisterMsg($WM_COPYDATA, 'WM_COPYDATA')
	$g_idMemo = _GUICtrlRichEdit_Create($hWnd,"", 10, 10, 300,   352,  BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL),$WS_EX_TRANSPARENT)
	_GUICtrlRichEdit_SetReadOnly($g_idMemo)
	GUISetBkColor(0xFFFFFF, $hWnd)
	While 1
		$Msg = GUIGetMsg()
		Switch $Msg
			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch
	WEnd
EndFunc
