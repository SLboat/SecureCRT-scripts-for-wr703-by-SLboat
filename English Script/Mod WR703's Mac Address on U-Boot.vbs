#$language = "VBScript"
#$interface = "1.0"

'mod uboot's mac address for SecureCRT
'this made by slboat,change a mac address,what ever you like,maybe it can help you:)

crt.Screen.Synchronous = false

'how long it wait for the console...
Const wait_second = 5

Sub Main
	'test are we on the u-boot
	crt.Screen.Send chr(13) & "version" & chr(13)
	If Not crt.screen.WaitForString("U-Boot",wait_second) Then
		MsgBox "it seems you are not on the uboot now,please first enter the uboot"
		Exit sub
	End If 

	need_mac_addr = True
	mac_addr = InputBox("what's mac address you want?","Change Mac Address in uboot","14-CF-92-87-07-A8")

	While (need_mac_addr)
		' check the mac address if right
		Set regEx = New RegExp
		regEx.Pattern = "^..\-..\-..\-..\-..\-..$"
		If regEx.Test(mac_addr) Then
			need_mac_addr = False
		ElseIf mac_addr="" Then
			MsgBox "you have not enter a mac address,let's stop work.."
			Exit sub
		else
			mac_addr = InputBox("Please input a vaild mac address,like [14-CF-92-87-07-A8]","Change Mac Address in uboot",mac_addr)
		End If
	Wend
	' just for human readable:)
	humanble_mac_addr=UCase(mac_addr)
	' take care the mac addr,replace all the "-" letter,and make low case
	mac_addr = LCase(Replace(mac_addr, "-", ""))
	' get the first 4bit,and last 4bit
	mac_4bit1st = Left(mac_addr, 8)
	mac_4bitend = Right(mac_addr, 4) & "ffff"
	mac_look_in_ram = mac_4bit1st & " " & mac_4bitend

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

	'check the ram if same
	crt.Screen.Send "md 0x8101fc00 2 " & chr(13)
	If Not crt.screen.WaitForString( mac_look_in_ram ,wait_second) Then
		MsgBox "Ram Write seems faild,IT dosen't fit[" & mac_look_in_ram & "],please try again"
		Exit sub
	End If 
	
	'erase the orgin flash
	crt.Screen.Send "erase 0x9f010000 +0x10000" & chr(13)
	If Not crt.screen.WaitForString("sectors",wait_second) Then
		Tips()
		Exit sub
	End If 
	
	'wait about 0.5 second
	crt.Sleep 500

	crt.Screen.Send "cp.b 0x81010000 0x9f010000 0x10000" & chr(13)
	If Not crt.screen.WaitForString("done",wait_second) Then
		Tips()
		Exit sub
	End If 

	'wait about 0.5 second
	crt.Sleep 500

	'report if work well
	crt.Screen.Send "md 0x9f01fc00 2" & chr(13)
	If crt.screen.WaitForString( mac_look_in_ram ,wait_second) Then
		MsgBox "The mac mod is done,Now is[" & mac_addr & "],and it has pass the check!" & Chr(13) & "Now you may need boot in openwrt and regenerate the wifi profile" & Chr(13) & "You can run the [Openwrt wifi detect.vbs]script on openwrt to do this:)"
	Else
		MsgBox "Flash Write seems faild,IT dosen't fit[" & mac_look_in_ram & "],please try again"
	End If 

	Exit sub	
	' crt.Screen.Send "reset" & chr(13)
End Sub

Sub Tips()
		MsgBox "not going well,maybe try again:(."
End Sub