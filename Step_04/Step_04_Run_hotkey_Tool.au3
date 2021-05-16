
Global $Get_Count = 5
Global $Array_Data[$Get_Count][2]
Global $INI_Fileinfo = @ScriptDir & "\ShortKey_Info.ini"

HotKeySet("^+{F8}", "_Stop_")
Func _Stop_()
	Exit
EndFunc

_Main_()

Func _Main_()

	Check_Shortkey_File()

	Local $hotkeyset_Temp = ""

	For $aa = 1 to $Get_Count

		if 	$Array_Data[$aa-1][0] = "" Then

		Else

if $Array_Data[$aa-1][0] = $hotkeyset_Temp Then

ElseIf "^+{F8}"	 = $Array_Data[$aa-1][0] Then

ElseIf "+^{F8}"	 = $Array_Data[$aa-1][0] Then

Else

	$hotkeyset_Temp = $Array_Data[$aa-1][0]

	HotKeySet( $Array_Data[$aa-1][0] , "HotKeyPressed")

EndIf

		EndIf

	Next

	While 1

		Sleep(15000)

	WEnd

EndFunc

Func Check_Shortkey_File()

	if FileExists($INI_Fileinfo) Then

		For $aa = 1 to $Get_Count

			$Array_Data[$aa-1][0] = StringReplace( IniRead($INI_Fileinfo, "Info_"&$aa , "ShortKey_Info" , "") , " " , "")

			$Array_Data[$aa-1][1] = IniRead($INI_Fileinfo, "Info_"&$aa , "Run_Info" , "")

		Next

	Else

		IniWrite($INI_Fileinfo, "Info_1" , "ShortKey_Info" , "^e")
		IniWrite($INI_Fileinfo, "Info_1" , "Run_Info" , "^a")

		IniWrite($INI_Fileinfo, "Info_2" , "ShortKey_Info" , "^e")
		IniWrite($INI_Fileinfo, "Info_2" , "Run_Info" , "^c")

		IniWrite($INI_Fileinfo, "Info_3" , "ShortKey_Info" , "^e")
		IniWrite($INI_Fileinfo, "Info_3" , "Run_Info" , "^v")

		IniWrite($INI_Fileinfo, "Info_4" , "ShortKey_Info" , "^e")
		IniWrite($INI_Fileinfo, "Info_4" , "Run_Info" , "^v")

		IniWrite($INI_Fileinfo, "Info_5" , "ShortKey_Info" , "^e")
		IniWrite($INI_Fileinfo, "Info_5" , "Run_Info" , "^v")

		For $aa = 1 to $Get_Count

			$Array_Data[$aa-1][0] = StringReplace( IniRead($INI_Fileinfo, "Info_"&$aa , "ShortKey_Info" , "") , " " , "")

			$Array_Data[$aa-1][1] = IniRead($INI_Fileinfo, "Info_"&$aa , "Run_Info" , "")

		Next

	EndIf

EndFunc

Func HotKeyPressed( )

	$AAkkkk = @HotKeyPressed

	Local $ExeFile = False

	For $aa = 1 to $Get_Count

		if $Array_Data[$aa-1][0] = $AAkkkk Then

			if $Array_Data[$aa-1][1] <> "" Then

				if StringInStr(  $Array_Data[$aa-1][1] ,   ":\"  ) and StringInStr(  $Array_Data[$aa-1][1] ,   ".exe"  ) Then

					if FileExists( $Array_Data[$aa-1][1] ) Then

						$ExeFile = True

					Else

						MsgBox("","[ Notice ]", "The file path is incorrect." & @CRLF & $Array_Data[$aa-1][1]  )

					EndIf

				EndIf

				if $ExeFile Then

					ShellExecute( $Array_Data[$aa-1][1])

				Else

					If "^+{F8}"	 = $Array_Data[$aa-1][1] Then

					ElseIf "+^{F8}"	 = $Array_Data[$aa-1][1] Then

					Else

						Send($Array_Data[$aa-1][1])

					EndIf

				EndIf

			EndIf

			$ExeFile = False

			Sleep(300)

		EndIf

	Next

EndFunc

