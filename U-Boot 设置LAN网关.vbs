#$language = "VBScript"
#$interface = "1.0"

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false


' 这是主要事件在这里
Sub Main
		'引导输入啥的
		crt.Screen.Send vbCr
		'等待鼠标？
		'crt.Screen.WaitForCursor
		'发送关键内容
		crt.Screen.Send "setenv serverip 192.168.2.100"
		' 发送出去回车键信号
		crt.Screen.Send vbCr
		'发送关键内容
		crt.Screen.Send "setenv ipaddr 192.168.2.1"
		' 发送出去回车键信号
		crt.Screen.Send vbCr
		' 等待两秒就够了

End Sub
