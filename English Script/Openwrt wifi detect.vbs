#$language = "VBScript"
#$interface = "1.0"
' this script redetect the wifi config(like new mac adderss change)

crt.Screen.Synchronous = false

Sub Main
	crt.Screen.Send Chr(13)
	'start work
	crt.Screen.Send "rm -f /etc/config/wireless; wifi detect > /etc/config/wireless" & chr(13)
	crt.Screen.WaitForString ":/"
	crt.Screen.Send "uci set wireless.radio0.disabled=0; uci commit" & chr(13)
	crt.Screen.WaitForString ":/"
	crt.Screen.Send "wifi on" & chr(13)
	If Not crt.screen.WaitForString("entered forwarding state",5) Then
		MsgBox "seems not going well..."
		Exit sub
	End If 
End Sub
