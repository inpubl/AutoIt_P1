#include <ScreenCapture.au3>
#include <Misc.au3>
Func _Time_Stamp_()
	Return 	@YEAR & @MON & @MDAY &"_"&@HOUR  & @MIN  & @SEC
EndFunc

Global $ScreenShot_img_folder = @ScriptDir &"\ScreenShot_Data\"&_Time_Stamp_()
Global $hWnd
if _Singleton(@ScriptName,1) = 0 Then Exit

Func exit_tool()
	exit
EndFunc

HotKeySet("{F2}", "exit_tool")

func img_filename()
	Return 	$ScreenShot_img_folder & "\Image_"& _Time_Stamp_()&".jpg"
EndFunc

if not FileExists($ScreenShot_img_folder) Then
	DirCreate($ScreenShot_img_folder)
EndIf

HotKeySet("{F3}", "capture_1_monitor")
HotKeySet("{F4}", "capture_2_monitor")
HotKeySet("{F5}", "capture_full_monitor")

HotKeySet("{F7}", "set_handle")
HotKeySet("{F8}", "capture_handle")

HotKeySet("{F9}", "reset_save_folder")


While 1
	Sleep(5500)
WEnd

Func capture_handle()
	_ScreenCapture_CaptureWnd(img_filename() , $hWnd )
EndFunc

Func set_handle()
	$hWnd = WinGetHandle("[ACTIVE]")
EndFunc

Func capture_full_monitor()
	$Pos = WinGetPos("Program Manager")
	_ScreenCapture_Capture( img_filename() ,0, 0,  $Pos[2],  + $Pos[3] , False)
EndFunc

Func capture_2_monitor()
	$Pos = WinGetPos("Program Manager")
	_ScreenCapture_Capture( img_filename() , @DesktopWidth + 1 , 0 , $Pos[2] ,@DesktopHeight  , False)
EndFunc

Func capture_1_monitor()
    _ScreenCapture_Capture( img_filename() , 0 , 0 , @DesktopWidth , @DesktopHeight  , False)
EndFunc

Func reset_save_folder()
	DirMove($ScreenShot_img_folder ,@ScriptDir &"\ScreenShot_Data\Backup" , 1)
	$ScreenShot_img_folder = @ScriptDir &"\ScreenShot_Data\"&_Time_Stamp_()
	if Not FileExists($ScreenShot_img_folder) Then
		DirCreate($ScreenShot_img_folder)
	EndIf
EndFunc