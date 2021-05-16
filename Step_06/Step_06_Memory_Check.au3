Local $hWnd =  WinGetHandle("[TITLE:test.txt - Notepad;CLASS:Notepad]" )
Local $iPID = WinGetProcess($hWnd)
HotKeySet("{F3}", "stop")
Func stop()
	Exit
EndFunc
#include <WinAPIProc.au3>
Local $Log_File , $aMemory , $Time_Value
While 1
	$Log_File = @ScriptDir & "\" & @YEAR & @MON & @MDAY & "_" & @HOUR & ".log"
	$aMemory = ProcessGetStats( $iPID )
	If IsArray($aMemory) Then
		ToolTip( "WorkingSetSize: " & $aMemory[0] & @CRLF & _
				"PeakWorkingSetSize: " & $aMemory[1] , 100 , 0 )
		$Time_Value = @HOUR & "_" & @MIN & "_" & @SEC
		IniWrite($Log_File, $Time_Value , "WorkingSetSize" , $aMemory[0])
		IniWrite($Log_File, $Time_Value , "PeakWorkingSetSize" , $aMemory[1])
	Else
		ToolTip( "An error occurred.", 100 , 0 )
	EndIf
	Sleep(5000)
	_WinAPI_EmptyWorkingSet()
WEnd