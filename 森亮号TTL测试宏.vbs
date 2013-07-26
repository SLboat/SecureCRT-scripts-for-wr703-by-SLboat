#$language = "VBScript"
#$interface = "1.0"

'当前版本：Ver.a3
'a3: 增加跳动空格
'a2: 增加空格
'a1: 基础原型，使用了同步来防止不刷新

'todo:
'1: 自己了解自己是否检测成功-声音提醒？
'2: 使用与管道来判断是否完成了任务

' 看起来同步之后的事情很糟糕，变得郁闷
crt.Screen.Synchronous = false

' 这是主要事件在这里
Sub Main
	' 无限制的循环发生在这里
	Dim Use_Blank
	Dim Rnd_Num
	Dim Go_Num
	Use_Blank = True
	Go_Num = 0
	' 循环
	while(1)
		' 发送出去回车键信号
		crt.Screen.Send VbCr
		'等待鼠标好了，需要在时间前面，如果不发生呢？
		'等待最长10秒时间
		crt.Screen.WaitForCursor(3) 
		'发送一个空格-这样更容易看明白，但不会干扰很大
		'跳舞的空格
		'todo：任意多个自己跳舞？
		Rnd_Num = Int(100*rnd+1)
		If (Use_Blank) Then
  		    Go_Num = Go_Num+1
			' 按键f会破坏安全模式，但是字串看起来呢？
			crt.Screen.Send (" # :-] I Working...As SLboat Say[" & Rnd_Num & "]or[" & Go_Num & "]")
			
		End if
		Use_Blank = Not Use_Blank '逻辑反
		'等待300毫秒好了 （100毫秒=0.1秒）
		crt.Sleep 300
	wend
End Sub
