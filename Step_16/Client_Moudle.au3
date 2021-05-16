#include <VM_Moudle.au3>

_Client_Main_()

Func _Client_Main_()

	$hWnd = GUICreate($sServerTitle, 320, 372, 500, 0, -1, $WS_EX_TOPMOST)
	$g_idMemo = _GUICtrlRichEdit_Create($hWnd,"", 10, 10, 300,   322,  BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL),$WS_EX_TRANSPARENT)
	_GUICtrlRichEdit_SetReadOnly($g_idMemo)

	$idSend_A = GUICtrlCreateButton('◎', 5 , 350, 35, 20)
	$idSend_B = GUICtrlCreateButton('☏', 45, 350, 35, 20)
	$idctData = GUICtrlCreateInput('', 84, 351, 195, 18)
	GUISetCursor($idctData)
	$idSend = GUICtrlCreateButton('◁', 281, 350, 35, 20)

	WinSetTitle($hWnd, '', $sClientTitle )
;~ 	GUIRegisterMsg($WM_COPYDATA, 'WM_COPYDATA')
	GUISetBkColor(0xFFFFFF, $hWnd) ;; 배경색 조절
	GUISetState(@SW_SHOW)
	While 1
		$Msg = GUIGetMsg()
		Switch $Msg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $idSend_A
				$Text_Kind = "emoticon"
				$Text_Value = "^_^"
				$Message_Value=  '                           Time : ' &  _Now()  & @CRLF & _
								 '                           Kind : ' & $Text_Kind  & @CRLF & _
								 '                           Memo : '& $Text_Value &  @CRLF
				MemoWrite($Message_Value)
				$hWndReciever = WinGetHandle($sServerTitle)
				$sMsg = $Text_Kind &"|"&$Text_Value
				If (Not @error) And $sMsg Then SendCOPYDATA($hWndReciever, $hWnd, "ANSI", $sMsg)
				GUICtrlSetData($idctData, '')
			Case $idSend_B
				$Text_Kind = "Voice_call"
				$Message_Value=  '     ========================================= ' & @CRLF & _
								 '               Time : ' &  _Now()  & @CRLF & _
								 '               그룹음성통화가 시작되었습니다.' & @CRLF& @CRLF
				MemoWrite($Message_Value)
				$hWndReciever = WinGetHandle($sServerTitle)
				$sMsg = $Text_Kind &"|Voice"
				If (Not @error) And $sMsg Then SendCOPYDATA($hWndReciever, $hWnd, "ANSI", $sMsg)
				GUICtrlSetData($idctData, '')

			Case $idctData, $idSend
				$sMsg = StringStripWS(GUICtrlRead($idctData), $STR_STRIPLEADING + $STR_STRIPTRAILING)
				if $sMsg = "" Then
				Else
					Local $Text_Kind = "Text"
					Local $Text_Value = $sMsg ;;; StringTrimRight(BinaryToString($cdData, $dwData), 1)
					if StringInStr( $Text_Value ,  "Text|" ) Then
						$Text_Kind = "Text"
						$Text_Value = StringReplace( $Text_Value , "Text|" , "")
					ElseIf StringInStr( $Text_Value ,  "Img|" ) Then
						$Text_Kind = "Img"
						$Text_Value = StringReplace( $Text_Value , "Img|" , "")
					ElseIf StringInStr( $Text_Value ,  "mp3|" ) Then
						$Text_Kind = "mp3"
						$Text_Value = StringReplace( $Text_Value , "mp3|" , "")
					Else
						$Text_Kind = "Text"
					EndIf
					$Message_Value=  '                           Time : ' &  _Now()  & @CRLF & _
									 '                           Kind : ' & $Text_Kind  & @CRLF & _
									 '                           Memo : ' & $Text_Value & @CRLF
					MemoWrite($Message_Value)
					$sMsg = $Text_Kind &"|"&$Text_Value
					$hWndReciever = WinGetHandle($sServerTitle)
					If (Not @error) And $sMsg Then SendCOPYDATA($hWndReciever, $hWnd, "ANSI", $sMsg)
					GUICtrlSetData($idctData, '')
				EndIf
		EndSwitch
	WEnd
EndFunc