wsShell = WScript.createObject("WScript.Shell");
retCode = wsShell.Run("pwsh -File \"" + WScript.Arguments.Item(0)+"\"",0,true);
WScript.Quit(retCode);