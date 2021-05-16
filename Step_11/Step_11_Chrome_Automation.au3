#include "wd_core.au3"
_WD_Option('Driver', 'chromedriver.exe')
_WD_Option('Port', 9515)
Local $sDesiredCapabilities = '{"capabilities": {"alwaysMatch": {"unhandledPromptBehavior": "ignore", "goog:chromeOptions": {"w3c": true, "excludeSwitches": ["enable-automation"], "useAutomationExtension": false, "prefs": {"credentials_enable_service": false}, "args": ["start-maximized"] }}}}'
_WD_Startup()
Local $sSession = _WD_CreateSession($sDesiredCapabilities)
Local $WebPage = "https://naver.com"
_WD_Navigate($sSession, $WebPage )
;~ Sleep(1500)
Local $sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//body")
Local $Text_Value = _WD_ElementAction($sSession, $sElement, "text")
;~ MsgBox("", "", $Text_Value , 2 )
$oResult = _WD_ElementAction($sSession, $sElement, 'Attribute', 'text')
MsgBox(0, "Show Result", $oResult)
;~ _ArrayDisplay($oResult) ;I was not sure if this would return an array or a string.

$Chrome_info = "[CLASS:Chrome_WidgetWin_1;TITLE:NAVER - Google Chrome]"
WinClose($Chrome_info, "")
;~ $WebDriver_info = "[CLASS:ConsoleWindowClass;TITLE:C:\RPA_Autoit\Step_11\chromedriver.exe]"
;~ WinClose($WebDriver_info, "")
_WD_Shutdown()