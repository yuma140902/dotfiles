wsShell = WScript.createObject("WScript.Shell");
retCode = wsShell.Run("pwsh -File \"" + WScript.Arguments.Item(0)+"\" "+WScript.Arguments.Item(1),0,true);
WScript.Quit(retCode);