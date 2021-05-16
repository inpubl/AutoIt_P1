;~ #include <Array.au3>
;~ #include <WinAPIShPath.au3>
;~ $aCmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)
;~ _ArrayDisplay($aCmdLine, '_CommandLin_')
#include <ProcessConstants.au3>
#include <WinAPIHObj.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#RequireAdmin
#NoTrayIcon


;~ Local $iPID = Run(@ScriptDir&"\Test_File.exe" , "aa", @SW_SHOW)
Local $iPID =  ShellExecute(@ScriptDir&"\Test_File.exe" , "aa bb")
Sleep(1500)
#Include <WinAPI.au3>

;~ Dim $PROCESS_ALL_ACCESS = 0x000F0000 + 0x00100000
;~ $Processhandle = _WinAPI_OpenProcess($PROCESS_ALL_ACCESS, 0, $iPID )

Local $hProcess
If Number(_WinAPI_GetVersion()) >= 6.0 Then
    $hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_LIMITED_INFORMATION, 0, $iPID)
Else
    $hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_INFORMATION, 0, $iPID)
EndIf

ConsoleWrite($hProcess&@LF)

;~ If ($Processhandle) Then MsgBox(0,"",$Processhandle)

WinMove($hProcess, "", 100, 100 )

MsgBox("","","")

exit



;~ ShellExecute(@ScriptDir&"\Test_File.exe" , "aa bb")

;~ $Filename = "D:\Autoit\2018\Image_Extracter\sceret_heart_box.xrl"
;~ $hwnd = WinGetHandle("Geomagic Design X - "&$Filename&" - [NOT FOR RESALE]")
;~ $aPos = WinGetPos($hwnd)

;~ run 실행 후 종료하기

;~ RunWait  실행 후 종료하기



;~ ShellExecute 실행 후 종료하기

;~ 도스 실행 명령어로 실행하기






;~ DX_Close_Moudle()

$kill_process = 'RapidformMain.exe'
Do
	ProcessClose($kill_process)
Until Not ProcessExists($kill_process)


$kill_process = "test_while.exe"
Local $diPID = Run(@ComSpec & " /c " & $kill_process , @ScriptDir , @SW_HIDE)

;~ $ttere = WinGetHandle("test_while.exe")


ConsoleWrite($diPID&@LF)
ProcessClose($kill_process)

;~ Do
;~ 	ProcessClose($kill_process)
;~ 	WinKill($Processhandle)
;~ Until Not ProcessExists($kill_process)




;~ Func DX_Close_Moudle()
;~ 	 MouseClick("left" , $aPos[0]+( $aPos[2]/2) , 10 )
;~  Local $start_time_u = TimerInit() ;

;~ ====================================================================================== ;; 동작 시간 측정
;~  Local $Play_time = Round((TimerDiff($start_time_u) / 1000), 2)

;~ send("!{f4}")
;~ Sleep(1000)
;~ $hwnd_dialogue = WinGetHandle("[CLASS:#32770;TITLE:Geomagic Design X]")
;~ if WinExists($hwnd_dialogue) Then
;~  	ControlClick($hwnd_dialogue, "", "Button2")
;~ 	sleep(1500)
;~ Else
;~ EndIf
;~ While 1
;~     If WinExists($hWnd) Then
;~     Else
;~ 		sleep(100)
;~ 		ExitLoop
;~     EndIf
;~ 	$Play_time = Round((TimerDiff($start_time_u) / 1000), 2)
;~ 	if $Play_time > 20 Then
;~ 		WinKill($hWnd, "")
;~ 		ExitLoop
;~ 	Else
;~ 	EndIf

;~ sleep(10)
;~ WEnd

;~ EndFunc