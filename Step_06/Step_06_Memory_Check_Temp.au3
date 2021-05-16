#include <WinAPIProc.au3>


Global $CreateTime = DllStructCreate("dword;dword")
Global $ExitTime = DllStructCreate("dword;dword")
Global $KernelTime = DllStructCreate("dword;dword")
Global $UserTime = DllStructCreate("dword;dword")
Global $FileTime = DllStructCreate("dword;dword")
Global $SystemTime = DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
Global $IdleTime = DllStructCreate("dword;dword")
Global $sUserTime, $sKernelTime, $eUserTime, $eKernelTime

Global $Max_memory = 0 , $Max_memory_temp = 0



;~ 핸들 얻어오ㅡㄴ 방법 2가지
;~ 고정 값 얻어 오기
;~ 변형 값 얻어오기 일부 값 얻어오기


;~ 핸들에서 pid 얻어오는 방법
;~ pid 란 무엇인지 잠시
;~ 설정 창 기준 안내


;~ 내 메모리 얻어오기
;~ pid 기준 메몰 ㅣ얻어오기
;~ 메모리 얻어오기 2개의 버전




;~ $hWnd_Temp =  WinGetHandle("[REGEXPTITLE:(?i)(Geomagic Design X - );REGEXPCLASS:Afx]" )
$hWnd_Temp =  WinGetHandle("[TITLE:ㅅㄷㄴㅅㄷㄴㅅㄷㄴㅅㄷㄴㅅㄷㄴㅅㄷㄴㅅㄷㄴ.txt - Windows 메모장;CLASS:Notepad]" )

ConsoleWrite( $hWnd_Temp&@LF)
ConsoleWrite(Check_Memory($hWnd_Temp) &@LF)
_GetProcTime($hWnd_Temp)


#Include <WinAPIProc.au3>

;~ ...

;~ ...

;~ _WinAPI_EmptyWorkingSet()

;~ ...
;~ [출처] 골치아픈 메모리 누수문제 (Autoit 강좌 | AutoitScript 강좌) | 작성자 하두고

Global Const $PROCESS_QUERY_INFORMATION = 0x400
Global Const $PROCESS_VM_READ = 0x10

$iPID_temp = WinGetProcess($hWnd_Temp)
MsgBox(0,"",_ProcessGetMemoryUsage($iPID_temp))

    Local $aMemory = ProcessGetStats($iPID_temp)

    ; If $aMemory is an array then display the following details about the process.
    If IsArray($aMemory) Then
        MsgBox($MB_SYSTEMMODAL, "", "WorkingSetSize: " & $aMemory[0] & @CRLF & _
                "PeakWorkingSetSize: " & $aMemory[1])
    Else
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred.")
    EndIf

ProcessGetStats ( "process.exe")

Func _ProcessGetMemoryUsage($sProcess)
    ;get process ID
    $nPID = ProcessExists($sProcess)
    If $nPID = 0 Then Return -1
    ;get process handle, required for GetProcessMemoryInfo
    $aRet = DllCall("Kernel32.dll", "int", "OpenProcess", "dword", $PROCESS_QUERY_INFORMATION+$PROCESS_VM_READ, "dword", False, "dword", $nPID)

    If @error Or ($aRet[0] = 0) Then Return -1
    $hProc = $aRet[0]
    ;create PPROCESS_MEMORY_COUNTERS to receive data, required for GetProcessMemoryInfo
    $structPROCESS_MEMORY_COUNTERS = DllStructCreate("dword; dword; uint peakmemsize; uint memsize; uint; uint; uint; uint; uint; uint")
    $nSize = DllStructGetSize($structPROCESS_MEMORY_COUNTERS)
    ;call GetProcessMemoryInfo
    $aRet = DllCall("Psapi.dll", "int", "GetProcessMemoryInfo", _
                                        "hwnd", $hProc, "ptr", DllStructGetPtr($structPROCESS_MEMORY_COUNTERS), "dword", $nSize)
    ;close process handle
    DllCall("Kernel32.dll", "int", "CloseHandle", "hwnd", $hProc)
    ;return memory size in kb
    Return DllStructGetData($structPROCESS_MEMORY_COUNTERS, "memsize") / 1024
EndFunc


Func Check_Memory($hWnd)
	$iPID_temp = WinGetProcess($hWnd)
	ConsoleWrite( $iPID_temp &" =============== "&@LF)
	If $iPID_temp > -1 Then
				$Data = _WinAPI_GetProcessFileName($iPID_temp)
						$build_Temp = FileGetLongName($Data)
						if FileExists($build_Temp) Then
							$DX_Build	= FileGetVersion($build_Temp)
						EndIf
				$aMemory =  ProcessGetStats($iPID_temp)
				If IsArray($aMemory) Then
					$Max_memory =  (Round($aMemory[1] / 1024) )
				Else
					$Max_memory = 0
				EndIf
				if $Max_memory <> $Max_memory_temp Then
					$Max_memory_temp = $Max_memory
;~ 					ToolTip( " [ DX "&$DX_Build&" ] Max Memory : " & $Max_memory , @DesktopWidth - 400 , 5 )
				EndIf
	EndIf
	Return $Max_memory
EndFunc

Func _GetProcTime($ProcessHandle)
    $ret = DllCall("kernel32.dll", "int", "GetProcessTimes", "int", $ProcessHandle, "ptr", DllStructGetPtr($CreateTime), "ptr", DllStructGetPtr($ExitTime), "ptr", DllStructGetPtr($KernelTime), "ptr", DllStructGetPtr($UserTime))
    If $ret[0] = 0 Then
    ConsoleWrite("(" & @ScriptLineNumber & ") : = Error in GetProcessTimes call" & @CRLF)
    SetError(1, 0, $ret[0])
    EndIf
    $sKernelTime = DllStructGetData($KernelTime, 1)
    $sUserTime = DllStructGetData($UserTime, 1)
    $Process_CPU_Usage = Floor(($sKernelTime - $eKernelTime + $sUserTime - $eUserTime) / 100000 )
    If $Process_CPU_Usage > 100 Then $Process_CPU_Usage = "100"
    $eKernelTime = $sKernelTime
    $eUserTime = $sUserTime
    Return $sUserTime + $sKernelTime
EndFunc ;==>_GetProcTime
