#$language = "VBScript"
#$interface = "1.0"

'mod uboot's mac address for SecureCRT
'this made by slboat,change a mac address,what ever you like,maybe it can help you:)

crt.Screen.Synchronous = false

'how long it wait for the console...
Const wait_second = 5

Sub Main
	need_mac_addr = True
	mac_addr = InputBox("what's mac address you want?","Change Mac Address in uboot","14-CF-92-87-07-A8")

	While (need_mac_addr)
		' check the mac address if right
		Set regEx = New RegExp
		regEx.Pattern = "^..\-..\-..\-..\-..\-..$"
		If regEx.Test(mac_addr) Then
			need_mac_addr = False
		else
			mac_addr = InputBox("Please input a vaild mac address,like [14-CF-92-87-07-A8]","Change Mac Address in uboot",mac_addr)
		End If
	wend
	' take care the mac addr,replace all the "-" letter,and make low case
	mac_addr = LCase(Replace(mac_addr, "-", ""))
	' get the first 4bit,and last 4bit
	mac_4bit1st = Left(mac_addr, 8)
	mac_4bitend = Right(mac_addr, 4) & "ffff"

	' start work now
	crt.Screen.Send "cp.b 0x9f010000 0x81010000 0x10000" & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 
	crt.Screen.Send "mw 0x8101fc00 " & mac_4bit1st & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 
	' now is the last part
	crt.Screen.Send "mw 0x8101fc04 " & mac_4bitend & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 

	'todo: check the ram if same

	crt.Screen.Send "erase 0x9f010000 +0x10000" & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 

	crt.Screen.Send "cp.b 0x81010000 0x9f010000 0x10000" & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 

	crt.Screen.Send "md 0x9f01fc00 2" & chr(13)
	If Not crt.screen.WaitForString("> ",wait_second) Then
		Tips()
		Exit sub
	End If 
	
	'todo: report if work well
	msgbox "the mac mod is done,plz check if it's right!"
	' you should check here if right
	' crt.Screen.Send "reset" & chr(13)
End Sub

Sub Tips()
		MsgBox "not going well,maybe try again:(."
End Sub