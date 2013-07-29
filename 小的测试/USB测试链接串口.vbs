#$language = "VBScript"
#$interface = "1.0"
'连接串口，试图找到一个
'todo:长时间没有鼠标变化，报警啥子的 - RGB灯如何？
'todo:提前一个回车键

crt.Screen.Synchronous = False '屏幕同步，看起来是所有完成后再显示屏幕啥的，防止被屏幕干扰，如果命令是一次性的话

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main
	crt.Screen.Send chr(13) & "microcom -D/dev/ttyACM0;microcom -D/dev/ttyUSB0" & chr(13)
	'等待3秒鼠标变化，todo，用逻辑符号等待3秒不到就是成功
	crt.Sleep 1000 '等待一秒
    crt.screen.send chr(126) '按键激活菜单
	crt.Sleep 500 '等待一秒
	crt.screen.sendkeys("t") '进入设置
	crt.Sleep 500 '等待一秒
	crt.screen.sendkeys("p") '进入速度设置
	crt.Sleep 500 '等待一秒
	crt.screen.sendkeys("g") '设置为57600速度

End Sub
