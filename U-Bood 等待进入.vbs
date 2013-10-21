#$language = "VBScript"
#$interface = "1.0"

crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main
	'等待出现标记符号
	If crt.screen.WaitForString("I will autobooting in 1 seconds",30) Then
		'输入tpl激活uboot
		crt.Screen.Send "tpl" & chr(13)
		'完成了
		msgbox "已经进入了uboot!至少已经按下了进入的玩意!"
	else
		msgbox "在30秒钟等待里没有发现可以按下的时刻!"
	End If

End Sub
