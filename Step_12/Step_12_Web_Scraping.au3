Local $input_data = "»ç°ú"
Local $dBinary = StringToBinary($input_data, 4)
Local $TRIM_dBinary =StringTrimLeft($dBinary, 2)
Local $Binary_LEN = StringLen($TRIM_dBinary)
Local $text_Count = $Binary_LEN/2
Local $Next_data = 1
Local $Search_data=''
For $i = 1 to $text_Count
	$Y = StringMid($TRIM_dBinary, $Next_data, 2)
	$Search_data &="%"&$Y
	$Next_data += 2
Next
#include <IE.au3>
Local $Search_contents = $Search_data
Local $Page_No = 0
Local $Main_Site = "https://www.clien.net/service/search?q="&$Search_contents&"&sort=recency&p="&$Page_No&"&boardCd=&isBoard=false"
Local $oIE = _IECreate ($Main_Site )
Local $Maxpgae = 5
Local $File_name = @ScriptDir & "\web_data_"&@HOUR  &"_"& @MIN  &"_"& @SEC&".dat"
for $Page_No = 0 to $Maxpgae
	$Main_Site =  "https://www.clien.net/service/search?q="&$Search_contents&"&sort=recency&p="&$Page_No&"&boardCd=&isBoard=false"
	_IENavigate($oIE, $Main_Site)
	_IELoadWait($oIE)
;~ 	Sleep(3000)
	Local $tags = $oIE.document.GetElementsByTagName("a")
	If Not @error Then
		For $tag in $tags
			$class_value = $tag.GetAttribute("class")
			If string($class_value) = "subject_fixed" Then
				ConsoleWrite( string( $class_value) & " : " &  $tag.outerText  & @LF)
				IniWrite($File_name, "Page_"&$Page_No, "Title", $tag.outerText )
			EndIf
		Next
	EndIf
Next