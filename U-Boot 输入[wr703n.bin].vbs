#$language = "VBScript"
#$interface = "1.0"

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false

Const bin_filename = "wr703.bin" '固件文件名称

'如有必要，你可能需要先设置网关点

' 这是主要事件在这里
Sub Main
		'引导输入啥的-在这里是坏主意，会记住上次任务
		'crt.Screen.Send vbCr
		'发送关键内容
		crt.Screen.Send "tftp 0x81000000 wr703n.bin"
		' 发送出去回车键信号
		crt.Screen.Send vbCr
		' 等待些许就够了，大概会需要10秒？
		If crt.screen.WaitForString("hex)", 10) <> True Then
			MsgBox "Faild get from tftpd:("
			Exit Sub
		End If
		crt.Sleep 1000 '稍等一些时候
		' 擦除16M，这里会非常长
		crt.Screen.Send "erase 0x9f020000 +0xfc0000" & Chr(13)
		If Not crt.screen.WaitForString("Erased 252 sectors",150) Then
			MsgBox "Erased sectors seems faild:("
			Exit Sub
		End If 
		crt.Sleep 1000 '稍等一些时候
		' 复制16M
		crt.Screen.Send "cp.b 0x81020000 0x9f020000 0x7c0000" & Chr(13)
		If Not crt.screen.WaitForString("done",20) Then
			MsgBox "Trying copy to flash is faild:("
			Exit Sub
			' 一起完成了
		End If 
End Sub
