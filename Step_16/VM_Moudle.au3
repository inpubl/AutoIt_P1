#include <Date.au3>
#include <Array.au3>
#include <Misc.au3>
#include <GUIConstants.au3>
#include <GuiComboBoxEx.au3>
#include <GuiRichEdit.au3>

Global $Chat_Data[7]
Global $tagCOPYDATASTRUCT = 'ulong_ptr dwData; dword cbData; ptr lpData'
Global $sServerTitle = 'Chat_Server'
Global $sClientTitle = 'Chat_Client'
Global $MSG_Count =0
Global $hWnd , $g_idMemo
Func MemoWrite($sMessage) ;;
	Local $sMessage_value = "===================[ "&$MSG_Count&" ]===================" &@CRLF &$sMessage ; 들어오는 데이터
	_GUICtrlRichEdit_AppendText($g_idMemo,   $sMessage_value&@CR) ;; 메세지 삽입
	$MSG_Count += 1
EndFunc
Func SendCOPYDATA($hReciever, $hSender, $iMsg, $sMsg , $EX_handle = 0 )
	Local $tcdData = DllStructCreate('byte cdData[' & BinaryLen(StringToBinary($sMsg & Chr(0), $iMsg)) & ']')
	DllStructSetData($tcdData, 'cdData', StringToBinary($sMsg, $iMsg))

	Local $tCOPYDATASTRUCT = DllStructCreate($tagCOPYDATASTRUCT)
	DllStructSetData($tCOPYDATASTRUCT, 'dwData', $iMsg)
	DllStructSetData($tCOPYDATASTRUCT, 'cbData', DllStructGetSize($tcdData))
	DllStructSetData($tCOPYDATASTRUCT, 'lpData', DllStructGetPtr($tcdData))
	Local $lParam = DllStructGetPtr($tCOPYDATASTRUCT)

	_SendMessage($hReciever, _
			$WM_COPYDATA, _
			$hSender, _
			$lParam)
	Return Not @error
EndFunc
Func WM_COPYDATA($hWnd, $iMsg, $wParam, $lParam)

	T_moudle($hWnd, $iMsg, $wParam, $lParam)

;~ 	SendCOPYDATA($hWndReciever, $Chat_Data[2], $iMsg, $Chat_Data[6] )

	$Message_Value=  '시간 : ' & $Chat_Data[0]  & @CRLF & _
					 '발신 : [ ' & $Chat_Data[1] & " ]"&@CRLF & _
					 '종류 : ' & $Chat_Data[3] & @CRLF & _
					 '내용 : ' & $Chat_Data[4] & @CRLF

	MemoWrite($Message_Value)

EndFunc

func T_moudle($hWnd, $iMsg, $wParam, $lParam)

	Local $tCOPYDATASTRUCT = DllStructCreate($tagCOPYDATASTRUCT, $lParam)
	Local $dwData = DllStructGetData($tCOPYDATASTRUCT, 'dwData')
	Local $cbData = DllStructGetData($tCOPYDATASTRUCT, 'cbData')
	Local $lpData = DllStructGetData($tCOPYDATASTRUCT, 'lpData')
	Local $tcdData = DllStructCreate('byte cdData[' & $cbData & ']', $lpData)
	Local $cdData = DllStructGetData($tcdData, 'cdData')

	Local $sMsg = StringTrimRight(BinaryToString($cdData, $dwData), 1)

	Local $Text_Kind = "Text"
	Local $Text_Value

	if StringInStr( $sMsg ,  "Text|" ) Then
		$Text_Kind = "Text"
		$Text_Value = StringReplace( $sMsg , "Text|" , "")
	ElseIf StringInStr( $sMsg ,  "emoticon|" ) Then
		$Text_Kind = "emoticon"
		$Text_Value = StringReplace( $sMsg , "emoticon|" , "")
	ElseIf StringInStr( $sMsg ,  "Voice_call|" ) Then
		$Text_Kind = "Voice_call"
		$Text_Value=    '     ========================================= ' & @CRLF & _
						'               시간 : ' &  _Now()  & @CRLF & _
						'               그룹음성통화가 시작되었습니다.' & @CRLF& @CRLF

	EndIf

	$Chat_Data[0] = _Now()
	$Chat_Data[1] = WinGetTitle($wParam)
	$Chat_Data[2] = $wParam
	$Chat_Data[3] = $Text_Kind
	$Chat_Data[4] = $Text_Value
	$Chat_Data[5] = $cbData & ' Byte'
	$Chat_Data[6] = $sMsg

EndFunc