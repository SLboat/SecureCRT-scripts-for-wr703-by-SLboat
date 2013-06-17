#$language = "VBScript"
#$interface = "1.0"

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false

' 最基本的关闭只需要：echo 0 > /sys/devices/virtual/gpio/gpio8/value
const work_off = "echo 0 > /sys/devices/virtual/gpio/gpio8/value; echo -e ""\n Sucess off the USB - SLboat \n"""

' 这是主要事件在这里
Sub Main
		'引导输入啥的
		crt.Screen.Send vbCr
		'等待鼠标？
		'crt.Screen.WaitForCursor
		'发送关键内容
		crt.Screen.Send work_off
		' 发送出去回车键信号
		crt.Screen.Send vbCr
		' 等待两秒就够了
		If crt.screen.WaitForString("Sucess off the USB", 2) <> True Then
			crt.Screen.Send "Faild to do My job:("
			MsgBox "Faild to do My job:("
			Exit Sub
		End If
End Sub
