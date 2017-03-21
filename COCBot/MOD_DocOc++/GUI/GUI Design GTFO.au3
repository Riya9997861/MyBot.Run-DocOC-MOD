; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Design GTFO
; Description ...: This file creates the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Media Hub
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func CreateGTFOSubTab()
Local $x = 82
$GTFOcheck = GUICtrlCreateCheckbox("", $x + 90, 6, 13, 13)
			GUICtrlSetState(-1,$GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "GTFOcheck")

	$hGUI_GTFOMode = GUICreate("", $_GUI_MAIN_WIDTH - 30 - 10, $_GUI_MAIN_HEIGHT - 255 - 30 - 30, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_DONATE)
	GUISetBkColor($COLOR_WHITE)
	GUISwitch($hGUI_GTFOMode)

		$grpGtfo = GUICtrlCreateGroup(" GTFO - Free Man Style && Mass Donation MOD  Ver 3.2 (By Media Hub) ", 0, 0, 430, 375, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
			$cmbGtfo = GUICtrlCreateCombo("", 37, 18, 37, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$WS_VSCROLL))
				GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20", "6")
				GUICtrlSetTip(-1, "Number of new members you want to kick.."& @CRLF & _
									"Use 1 - 5 for Normal Kicking"& @CRLF & _
									"Use 5 - 10 For Massive Kicking"& @CRLF & _
									"Use 10 above For Forced Kicking")
			$btnGtfoStart = GUICtrlCreateButton("START", 80, 16, 50, 25)
				GUICtrlSetTip(-1, "Start GTFO Free Man Style")
;~ 				GUICtrlSetOnEvent(-1, "GTFOStart")
			$btnGtfoPause = GUICtrlCreateButton("PAUSE", 130, 16, 55, 25)
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Pause GTFO Free Man Style")
;~ 				GUICtrlSetOnEvent(-1, "GTFOPause")
			$btnGtfoStop = GUICtrlCreateButton("STOP", 185, 16, 50, 25)
				GUICtrlSetState(-1, $GUI_DISABLE)
;~ 				GUICtrlSetOnEvent(-1, "GTFOStop")
				GUICtrlSetTip(-1, "Stop GTFO Free Man Style")
			$chkMassDonate = GUICtrlCreateCheckbox("Mass Donate", 238, 13, 82, 17)
				GUICtrlSetTip(-1, "Enable / Disable Mass Donate mode without GTFO Free Man Style")
			$chkKickMode = GUICtrlCreateCheckbox("Kick Spammers", 238, 32, 90, 17)
				GUICtrlSetTip(-1, "Kick Only those who donate troops")
			$chkClanOpen = GUICtrlCreateCheckbox("Auto Open Clan", 328, 32, 97, 17)
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetTip(-1, "Open the Clan If Clan is closed")
			$chkWaitForTroops = GUICtrlCreateCheckbox("Wait For Troops", 328, 13, 97, 17)
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetTip(-1, "Stay Idle(Random) Until Some Troops Get Trained")
			$chkMassKick = GUICtrlCreateCheckbox("Only Kick", 238, 53, 65, 17)
				GUICtrlSetTip(-1, "Enable / Disable Only Kick Bot Mode.")
				GUICtrlSetOnEvent(-1, "MassKick")
			$chkSetTrophies = GUICtrlCreateCheckbox("Trophies", 305, 53, 60, 17)
				GUICtrlSetTip(-1, "Enable / Disable to update Clan Trophies")
				GUICtrlSetOnEvent(-1, "SetTrophies")
			$cmbGtfoTrophies = GUICtrlCreateCombo("", 365, 50, 55, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL, $WS_VSCROLL))
				GUICtrlSetData(-1, "0|200|400|600|800|1000|1100|1200|1300|1400|1500|1600|1700|1800|1900|2000|2100|2200|2300|2400|2500|2600|2700|2800|3000|3100|3200|3300|3400|3500|3600|3700|3800|3900|4000|4100|4200", "1200")
				GUICtrlSetTip(-1, "Set clan Trophies")
				GUICtrlSetOnEvent(-1, "UpdateTrophies")

			$cmbGtfoDonationCap = GUICtrlCreateCombo("", 85, 50, 30, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "1|2|3|4|5|6|7|8", "5")
				GUICtrlSetTip(-1, "Set Donation Capacity / Limit per round")
				GUICtrlSetOnEvent(-1, "DonationCap")
			$cmbGtfoKickCap = GUICtrlCreateCombo("", 185, 50, 40, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$WS_VSCROLL))
				GUICtrlSetData(-1, "10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36", "20")
				GUICtrlSetTip(-1, "Set Kick Capacity / Received limit for members to kick")
				GUICtrlSetOnEvent(-1, "KickCap")

			$cmbGtfoTroop = GUICtrlCreateCombo("", 48, 80, 70, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "Barbarian|Archer", "Barbarian")
			$cmbGtfoTroopBoost = GUICtrlCreateCombo("", 190, 80, 35, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$WS_VSCROLL))
				GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24", "0")
			$cmbGtfoSpell = GUICtrlCreateCombo("", 48, 110, 70, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "None|Poison|Haste|Earthquake|Skeleton", "None")
			$cmbGtfoSpellBoost = GUICtrlCreateCombo("", 190, 110, 35, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$WS_VSCROLL))
				GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24", "0")

			$chkGtfoProfileSwitch = GUICtrlCreateCheckbox("Switch Profile", 10, 237, 53, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_MULTILINE))
				GUICtrlSetState(-1, $GUI_DISABLE)
			$cmbGtfoProfiles = GUICtrlCreateCombo("", 76, 240, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetState(-1, $GUI_DISABLE)
			$btnGtfoProfileAdd = GUICtrlCreateButton("+", 177, 240, 20, 20, $BS_VCENTER)
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Add Profile")
			$btnGtfoProfileRemove = GUICtrlCreateButton("-", 200, 240, 20, 20, $BS_VCENTER)
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Remove Profile")

			$SliderGtfoIdleTime = GUICtrlCreateSlider(100, 270, 125, 27)
				GUICtrlSetOnEvent(-1, "GtfoSetIdleTime")
				GUICtrlSetLimit(-1, 120, 5)
				GUICtrlSetData(-1, 15)
				GUICtrlSetTip(-1, "Maximum Idle Time While Donating Troops")

			$chkGtfoNote = GUICtrlCreateCheckbox("Kick With Note", 10, 300, 97, 17)
				GUICtrlSetOnEvent(-1, "GtfoSetKickNote")
				GUICtrlSetTip(-1, "Check this to kick members with Note..")
			 $txtGtfoNote = GUICtrlCreateInput("Join back later", 8, 320, 217, 21)
				GUICtrlSetLimit(-1, 255)
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Type Kick note...")
;~ 			$chkGtfoClip = GUICtrlCreateCheckbox("Use System Clipboard to Send Messages", 10, 275, 217, 17)
;~ 				GUICtrlSetState(-1, $GUI_DISABLE)

			$txtGtfoChat = GUICtrlCreateInput("Hello Clan", 35, 345, 340, 21)
				GUICtrlSetLimit(-1, 255)
				GUICtrlSetTip(-1, "You can chat with clan while GTFO running")
			$btnGtfoSendChat = GUICtrlCreateButton("Send", 375, 343, 50, 25)
				GUICtrlSetOnEvent(-1, "GtfoSendChat")

			$lstGtfoChatTemplates = GUICtrlCreateList("", 232, 73, 190, 245, BitOR($LBS_NOTIFY,$LBS_MULTIPLESEL,$LBS_USETABSTOPS,$WS_VSCROLL))
				GUICtrlSetData(-1, "Members Don"&Chr(39)&"t Donate|Request and leave|Don"&Chr(39)&"t Wait for Spell|No Giants|We Donate BAM only|Request Or Kick|we need serious player who is interested whatsapp me|BookMark US. Request and Leave|Recruiting Staff|members don"&Chr(39)&"t donate|req|REQ|Read Clan Page for Eligibility|Don"&Chr(39)&"t Send Friend Requests|Request")
;~ 				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Chat Templates"& @CRLF & _
									"Use +/- to Add  or Remove"& @CRLF & _
									"Use " & chr(124) & " between words to add multiple at once"& @CRLF & _
									"Double Click to select chat line"& @CRLF & _
									"Multiple Selection allowed During Delete")

			$btnGtfoChatAdd = GUICtrlCreateButton("+", 232, 320, 20, 20, $BS_VCENTER)
				GUICtrlSetOnEvent(-1, "GtfoAddToTemplate")
;~ 				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Add to Chat Template")
			$btnGtfoChatRemove = GUICtrlCreateButton("-", 255, 320, 20, 20, $BS_VCENTER)
				GUICtrlSetOnEvent(-1, "GtfoRemoveFromTemplate")
;~ 				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetTip(-1, "Remove Selected From Chat Template")
			$chkGtfoChatAuto = GUICtrlCreateCheckbox("Auto Chat", 285, 320, 70, 17)
				GUICtrlSetOnEvent(-1, "GtfoAutoChat")
				GUICtrlSetColor(-1, 0x910A91)
			$chkGtfoChatRandom = GUICtrlCreateCheckbox("Random", 360, 320, 65, 17)
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetOnEvent(-1, "GtfoRandomChat")

			$lblGtfoDonationCap = GUICtrlCreateLabel("Donation Cap", 10, 52, 74, 20)
				GUICtrlSetTip(-1, "Set Donation Capacity / Limit per round")
				GUICtrlSetColor(-1, 0x7D7D2D)
			$lblGtfoKickCap = GUICtrlCreateLabel("Receiced Cap", 125, 47, 55, 32,1)
				GUICtrlSetTip(-1, "Set Kick Capacity / Received limit for members to kick")
				GUICtrlSetColor(-1, 0xffa800)
			$lblGtfoHelp = GUICtrlCreateLabel("help", 2, 2, 20, 15)
				GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
				GUICtrlSetColor(-1, 0xFF0000)
				GUICtrlSetTip(-1, "Help")
				GUICtrlSetOnEvent(-1, "GtfoHelp")
			$lblKick = GUICtrlCreateLabel("Kick", 10, 20, 25, 17)
				GUICtrlSetColor(-1, 0xFF0000)
			$lblGtfoTroop = GUICtrlCreateLabel("Troop", 10, 82, 32, 17)
				GUICtrlSetColor(-1, 0xFF00FF)
			$lblGtfoSpell = GUICtrlCreateLabel("Spell", 10, 112, 27, 17)
				GUICtrlSetColor(-1, 0x0000FF)
			$lblGtfoTroopBoost = GUICtrlCreateLabel("Boost Count", 125, 82, 62, 17)
				GUICtrlSetColor(-1, 0x00AF00)
			$lblGtfoSpellBoost = GUICtrlCreateLabel("Boost Count", 125, 112, 62, 17)
				GUICtrlSetColor(-1, 0x00AF00)
			$lblGtfoChat = GUICtrlCreateLabel("Chat", 7, 347, 26, 17)
				GUICtrlSetColor(-1, 0x00e4ff)
			$lblGtfoIdle = GUICtrlCreateLabel("Idle Time", 10, 275, 47, 17)
				GUICtrlSetTip(-1, "Idle Time in Sec")
				GUICtrlSetColor(-1, 0x963232)
			$txtGtfoIdleTime = GUICtrlCreateInput("15 s", 56, 273, 40, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY,$ES_NUMBER))
				GUICtrlSetLimit(-1, 2)
			$chkChatStatus = GUICtrlCreateCheckbox("", 410, 310, 18, 17)
				GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc
