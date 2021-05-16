#include <Array.au3>
#include <WinAPIShPath.au3>

$aCmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

_ArrayDisplay($aCmdLine, '_CommandLin_')