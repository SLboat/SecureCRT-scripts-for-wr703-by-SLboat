#$language = "VBScript"
#$interface = "1.0"

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false

' 最基本的关闭只需要：echo 0 > /sys/devices/virtual/gpio/gpio8/value
const work_off = "uci set luci.main.lang=zh_cn;uci commit;echo -e ""\nnow you language will be:""$(uci get luci.main.lang)""\n"""

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
		If crt.screen.WaitForString("zh_cn", 2) <> True Then
			MsgBox "Faild to set to zh_cn:("
			Exit Sub
		End If
		crt.Screen.Send "echo -e ""\nnow you have the zh_cn for you openwrt system\n""" & vbcrlf
End Sub
