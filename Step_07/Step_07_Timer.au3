#include <WinAPIProc.au3>
HotKeySet("{F3}", "exit_tool")
func exit_tool()
	Exit
EndFunc
Global $Process_1 , $Process_2 , $Process_3

Global $INI_Fileinfo = @ScriptDir & "\Data_Info.ini"
if not FileExists($INI_Fileinfo) Then
	IniWrite($INI_Fileinfo, "Date_Info" , "Run_Info" , "00_00")
EndIf

_Main_()

Func _Run_process()
	$Process_1 = run("Notepad.exe")
	Sleep(1500)
	$Process_2 = run("C:\Program Files (x86)\AutoIt3\Au3Info.exe")
	Sleep(1500)
	$Process_3 = ShellExecute("iexplore.exe", "http://www.naver.com")
EndFunc

func _Main_()
	Local $Run_Status = False
	Local $WAY_Temp = ""
	Local $Time = 9
	Local $Min = 1
	While 1
		if $Run_Status Then
			if $Time <= Number(@HOUR) and $Min < Number(@MIN) Then
				_Run_process()
				Sleep(3000)
				ProcessClose($Process_1)
				ProcessClose($Process_2)
				ProcessClose($Process_3)
				$Run_Status = False
			EndIf
		EndIf
		if $WAY_Temp <> @WDAY  and @WDAY > 2  Then
			$Date_Temp = IniRead($INI_Fileinfo, "Date_Info" , "Run_Info" , "")
			$Date_date = @MON &"_"& @MDAY
			if $Date_Temp <> $Date_date Then
				IniWrite($INI_Fileinfo, "Date_Info" , "Run_Info" , $Date_date)
				$Run_Status = True
				$WAY_Temp = @WDAY
			EndIf
		EndIf
		sleep(5000)
		_WinAPI_EmptyWorkingSet()
	WEnd
EndFunc