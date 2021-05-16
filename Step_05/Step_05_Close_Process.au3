Local $File_info =  "Test_File.exe"

Local $iPID = ShellExecute(@ScriptDir & "\" & $File_info , "aa bb")

ProcessWaitClose($iPID , 3 )

ProcessClose($iPID)

Do
	ProcessClose($iPID)
	Sleep(3000)
Until Not ProcessExists($iPID)