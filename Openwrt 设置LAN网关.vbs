#$language = "VBScript"
#$interface = "1.0"

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false
' todo：如果提醒没有网线，分开来提醒

' 网关设置到192.168.2.1
const work_off = "uci set network.lan.ipaddr=192.168.2.1 && uci commit && /etc/init.d/network restart"

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
		If crt.screen.WaitForString("link dow", 2) <> True Then
			crt.Screen.Send "echo -e ""\nFaild to do My job:(\n""" '这看起来不太妙
			MsgBox "Faild to do My job:("
			Exit Sub
		End If
		MsgBox "The Lan Gate Way is [192.168.2.1],Now you can set your pc to fit it:)"
End Sub
