#$language = "VBScript"
#$interface = "1.0"
'这里是自动安装SCSI驱动的玩意

crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main
	crt.Screen.Send "opkg update;opkg install kmod-scsi-core" & chr(13)
End Sub
