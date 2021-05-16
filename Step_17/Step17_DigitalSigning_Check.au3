#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Global $Sign_exe_folder_info =  "C:\sign_file\"
Global $Sign_pfx_file_name =  "C:\sign_file\CHAIN_com.pfx"
Global $Sign_PW = "password"
Global $INI_Fileinfo = @ScriptDir & "\sign_Info.ini"

_Main_()

Func _Main_()

	if not FileExists($INI_Fileinfo) Then
		IniWrite($INI_Fileinfo, "sign_Info" , "Sign_exe_folder_info" , $Sign_exe_folder_info)
		IniWrite($INI_Fileinfo, "sign_Info" , "Sign_pfx_file_name" , $Sign_pfx_file_name)
		IniWrite($INI_Fileinfo, "sign_Info" , "Sign_PW" , $Sign_PW)
		MsgBox("", "sign_Info.ini" , "sign_Info.ini 파일 정보를 확인해주세요.")
		Exit

	Else
		Local $Sign_exe_folder_info_Temp = IniRead($INI_Fileinfo, "sign_Info" , "Sign_exe_folder_info" , "")
		if $Sign_exe_folder_info_Temp <> "" Then
			$Sign_exe_folder_info = $Sign_exe_folder_info_Temp
		EndIf

		Local $Sign_pfx_file_name_Temp = IniRead($INI_Fileinfo, "sign_Info" , "Sign_pfx_file_name" , "")
		if $Sign_pfx_file_name_Temp <> "" Then
			$Sign_pfx_file_name = $Sign_pfx_file_name_Temp
		EndIf

		Local $Sign_PW_Temp = IniRead($INI_Fileinfo, "sign_Info" , "Sign_PW" , "")
		if $Sign_PW_Temp <> "" Then
			$Sign_PW = $Sign_PW_Temp
		EndIf
	EndIf
	Local $Total_count = 0
	Local $Pass_count = 0
	Local $Sample_list = _FileListToArrayRec(@ScriptDir ,  "*.EXE" ,  $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT)
	if UBound($Sample_list ) = 1 Then
		MsgBox("","","폴더에 EXE 파일이 없습니다. " , 3)
		Exit
	EndIf
	for $ser = 1 to $Sample_list[0]
		$File_name = @ScriptDir &"\"& $Sample_list[$ser]
		if Not _SignerInfo_($File_name) Then
			$Total_count += 1
			if Signing_CMD($File_name) Then $Pass_count += 1
		EndIf
	Next
	MsgBox("","결과" , $Pass_count &" / " & $Total_count , 5)
EndFunc


Func Signing_CMD($File_name)
	Local $avArray[3]
	$avArray[0] = "http://timestamp.comodoca.com/authenticode"
	$avArray[1] = "http://timestamp.globalsign.com/scripts/timstamp.dll"
	$avArray[2] = "http://timestamp.verisign.com/scripts/timstamp.dll"
	Local $result = False
	For $II = 0 to UBound($avArray) -1
		$Run_cmd = 'signtool.exe sign /f ' & $Sign_pfx_file_name&' /p ' & $Sign_PW & ' /t ' & $avArray[$II] &  ' "' & $File_name & '"'
		RunWait(@ComSpec & ' /c '&  $Run_cmd , $Sign_exe_folder_info , @SW_HIDE)
		Sleep(100)
		if _SignerInfo_($File_name) Then
 			Return True
		EndIf
	Next
EndFunc

Func _SignerInfo_($sFile)
    If Not FileExists($sFile) Then Return False
    Local $CERT_QUERY_OBJECT_FILE = 0x1
    Local $CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED = 10
    Local $CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED = 2 ^ $CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED
    Local $CERT_QUERY_FORMAT_BINARY = 0x1
    Local $CERT_QUERY_FORMAT_FLAG_BINARY = 2 ^ $CERT_QUERY_FORMAT_BINARY
    Local $aCall = DllCall("Crypt32.dll", "bool", "CryptQueryObject", _
            "dword", $CERT_QUERY_OBJECT_FILE, "wstr", $sFile, _
            "dword", $CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED, _
            "dword", $CERT_QUERY_FORMAT_FLAG_BINARY, _
            "dword", 0, "dword*", 0, "dword*", 0, "dword*", 0, "handle*", 0, "handle*", 0, "ptr", 0)
    If Not $aCall[10] Then Return False
	Return True
EndFunc