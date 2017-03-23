; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Mod - Switch Account
; Description ...: This file creates the "Mods" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team Mod MBR (NguyenAnhHD, Demen)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_hGUI_MOD_SWITCH_STYLE = 0, $g_hGUI_MOD_SWITCH_STYLE_TAB = 0
Global $g_hRdoSwitchAcc_DocOc = 0, $g_hRdoSwitchAcc_Demen = 0

; SwitchAcc_Demen_Style
Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]
Global $chkSwitchAcc = 0, $chkTrain = 0, $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0
Global $g_hChkForceSwitch = 0, $g_txtForceSwitch = 0, $g_lblForceSwitch = 0, $g_hChkForceStayDonate = 0
Global $g_StartHideSwitchAcc_Demen = 0, $g_SecondHideSwitchAcc_Demen, $g_EndHideSwitchAcc_Demen = 0


; SwitchAcc_DocOc_Style
Global $chkEnableSwitchAccount, $lblNB, $cmbAccountsQuantity
Global $chkCanUse[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $chkDonateAccount[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $cmbAccount[9] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_StartHideSwitchAcc_DocOc = 0, $g_EndHideSwitchAcc_DocOc = 0


Func CreateModSwitchAccStyle()

	$g_hGUI_MOD_SWITCH_STYLE = GUICreate("", $_GUI_MAIN_WIDTH - 36, $_GUI_MAIN_HEIGHT - 385, 5, 95, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_MOD_SWITCH)
	Local $x = 76
	$g_hRdoSwitchAcc_Demen = GUICtrlCreateRadio("", $x, 5, 13, 13)
			   GUICtrlSetState(-1,$GUI_CHECKED)
			   GUICtrlSetOnEvent(-1, "RdoSwitchAcc_Style")
	$g_hRdoSwitchAcc_DocOc = GUICtrlCreateRadio("", $x + 88, 5, 13, 13)
			   GUICtrlSetState(-1,$GUI_UNCHECKED)
			   GUICtrlSetOnEvent(-1, "RdoSwitchAcc_Style")

	GUISwitch($g_hGUI_MOD_SWITCH_STYLE)
	$g_hGUI_MOD_SWITCH_STYLE_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 36, $_GUI_MAIN_HEIGHT - 385, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
	GUICtrlCreateTabItem("Demen Style" & "      ")
		CreateSwitchAcc_Demen()
	GUICtrlCreateTabItem("DocOc Style" & "      ")
		CreateSwitchAcc_DocOc()
EndFunc


Func CreateSwitchAcc_Demen()
	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	Local $sTxtTip = ""
	Local $x = 15, $y = 45

		$g_StartHideSwitchAcc_Demen = GUICtrlCreateDummy()
		GUICtrlCreateGroup(GetTranslated(109,4, "Switch Account Mode"), $x - 12, $y - 20, 200, 275)
			$chkSwitchAcc = GUICtrlCreateCheckbox(GetTranslated(109,5, "Enable Switch Account"), $x - 5, $y, -1, -1)
				$sTxtTip = GetTranslated(109,6, "Switch to another account & profile when troop training time is >= 1 minutes") & _
					@CRLF & GetTranslated(109,7, "This function supports maximum 8 CoC accounts & 8 Bot profiles") & _
					@CRLF & GetTranslated(109,8, "Make sure to create sufficient Profiles equal to number of CoC Accounts")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "chkSwitchAcc")

			$chkTrain = GUICtrlCreateCheckbox(GetTranslated(109,9, "Pre-train"), $x + 127, $y, -1, -1)
				$sTxtTip = GetTranslated(109,10, "Enable it to pre-train donated troops in quick train 3 before switch to next account.") & _
					@CRLF & GetTranslated(109,11, "This function requires use Quick Train, not Custom Train.") & _
					@CRLF & GetTranslated(109,12, "Use army 1 for farming troops, army 2 for spells and army 3 for donated troops.")
				GUICtrlSetTip(-1, $sTxtTip)

			GUICtrlCreateLabel(GetTranslated(109,13, "Total CoC Acc:"), $x + 10, $y + 29, -1, -1)
				$sTxtTip = GetTranslated(109,14, "Choose number of CoC Accounts pre-logged")

			$cmbTotalAccount = GUICtrlCreateCombo("", $x + 95, $y + 25, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "1 Acc." & "|" & "2 Acc." & "|" & "3 Acc." & "|" & "4 Acc." & "|" & "5 Acc." & "|" & "6 Acc." & "|" & "7 Acc." & "|" & "8 Acc.")
				GUICtrlSetTip(-1, $sTxtTip)

			$radNormalSwitch = GUICtrlCreateRadio(GetTranslated(109,15, "Normal switch"), $x + 10, $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(109,16, "Switching accounts continously"))
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$radSmartSwitch = GUICtrlCreateRadio(GetTranslated(109,17, "Smart switch"), $x + 100, $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(109,18, "Switch to account with the shortest remain training time"))
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$y += 80
			$g_hChkForceSwitch = GUICtrlCreateCheckbox(GetTranslated(109,19, "Force switch after:"), $x - 5, $y, -1, -1)
				GUICtrlSetTip(-1, GetTranslated(109,20, "Force the Bot to switch account when searching for too long") & _
					@CRLF & GetTranslated(109,21, "First switch to all donate accounts") & _
					@CRLF & GetTranslated(109,22, "Then switch to another active account if its army is ready"))
				GUICtrlSetOnEvent(-1, "chkForceSwitch")
			$g_txtForceSwitch = GUICtrlCreateInput("100", $x + 105, $y+1, 27, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
				GUICtrlSetState(-1, $GUI_DISABLE)
				GUICtrlSetLimit(-1, 3)
			$g_lblForceSwitch = GUICtrlCreateLabel(GetTranslated(109,23, "searches"), $x + 135, $y+4, -1, -1)
				GUICtrlSetState(-1, $GUI_DISABLE)

			$y += 30
			$g_hChkForceStayDonate= GUICtrlCreateCheckbox(GetTranslated(109,24, "Stay on donation while training"), $x - 5, $y, -1, -1)
				GUICtrlSetTip(-1, GetTranslated(109,25, "Stay at donate account until an active account is getting troops ready in 1 minute") & _
					@CRLF & GetTranslated(109,26, "Circulate among the donate accounts if there are more than 1"))

			$y += 30
			$chkUseTrainingClose = GUICtrlCreateCheckbox(GetTranslated(109,27, "Combo Sleep after Switch Acc."), $x - 5, $y, -1, -1)
				$sTxtTip = GetTranslated(109,28, "Close CoC combo with Switch Account when there is more than 3 mins remaining on training time of all accounts.")
				GUICtrlSetTip(-1, $sTxtTip)

			GUIStartGroup()
			$radCloseCoC = GUICtrlCreateRadio(GetTranslated(109,29, "Close CoC"), $x + 10, $y + 30, -1, 16)
				GUICtrlSetState(-1, $GUI_CHECKED)

			$radCloseAndroid = GUICtrlCreateRadio(GetTranslated(109,30, "Close Android"), $x + 100, $y + 30, -1, 16)

			$y += 60
			GUICtrlCreateLabel(GetTranslated(109,31, "Manually locate account coordinates"), $x, $y, -1, -1)

			$cmbLocateAcc = GUICtrlCreateCombo("", $x + 15, $y + 21, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,32, "Select CoC Account to manually locate its y-coordinate")
				GUICtrlSetData(-1, "Acc. 1" & "|" & "Acc. 2" & "|" & "Acc. 3" & "|" & "Acc. 4" & "|" & "Acc. 5" & "|" & "Acc. 6" & "|" & "Acc. 7" & "|" & "Acc. 8", "Acc. 1")
				GUICtrlSetTip(-1, $sTxtTip)

			GUICtrlCreateButton(GetTranslated(109,33, "Locate"), $x + 80, $y + 20 , 50, 23)
				GUICtrlSetTip(-1, GetTranslated(109,34, "Starting locate your CoC Account"))
				GUICtrlSetOnEvent(-1, "btnLocateAcc")

			GUICtrlCreateButton(GetTranslated(109,35, "Clear All"), $x + 135, $y + 20 , 50, 23, $BS_MULTILINE)
				GUICtrlSetTip(-1, GetTranslated(109,36, "Clear location data of all accounts"))
				GUICtrlSetOnEvent(-1, "btnClearAccLocation")

		GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Profiles & Account matching
	Local $x = 225, $y = 45

	GUICtrlCreateGroup(GetTranslated(109,37, "Profiles"), $x - 20, $y - 20, 223, 275)
		GUICtrlCreateButton(GetTranslated(109,38, "Update Profiles"), $x + 40, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "g_btnUpdateProfile")
		GUICtrlCreateButton(GetTranslated(109,39, "Clear Profiles"), $x + 130, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "btnClearProfile")

	$y += 35
		GUICtrlCreateLabel(GetTranslated(109,40, "No."), $x-10, $y, 15,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,41, "Profile Name"), $x+10, $y, 90,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,42, "Acc."), $x+105, $y, 30,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,43, "Bot Type"), $x+140, $y, 60,-1,$SS_CENTER)

	$y += 20
		GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
		GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

	$g_SecondHideSwitchAcc_Demen = GUICtrlCreateDummy()
	$y += 10
		 For $i = 0 To 7
			$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x -10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
			GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

			$lblProfileName[$i] = GUICtrlCreateLabel(GetTranslated(109,44, "Village Name"), $x +10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
				If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i+1])
			$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,45, "Select the index of CoC Account to match with this Profile")
				GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc"&$i+1)
			$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,46, "Define the botting type of this profile")
				GUICtrlSetData(-1, GetTranslated(109,47, "Active") & "|" & GetTranslated(109,48, "Donate") & "|" & GetTranslated(109,49, "Idle"))
				GUICtrlSetTip(-1, $sTxtTip)
			If $i > $nTotalProfile - 1 Then
				For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
					GUICtrlSetState($j, $GUI_HIDE)
				Next
			EndIf
		 Next
		 GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$g_EndHideSwitchAcc_Demen = GUICtrlCreateDummy()

EndFunc


Func CreateSwitchAcc_DocOc()

	Local $x = 3, $z = 180, $w = 345, $y = 25
	$g_StartHideSwitchAcc_DocOc = GUICtrlCreateDummy()	; Hide DocOc SwitchAcc to make room for SwitchAcc_Demen_Style
	GUICtrlCreateGroup(GetTranslated(108,1, "Smart Switch Accounts"), $x, $y, 425, 275)
		$x += 10
		$y += 20
			$chkEnableSwitchAccount = GUICtrlCreateCheckbox(GetTranslated(108,2, "Use Smart Switch Accounts"), $x, $y, 152, 17)
				GUICtrlSetOnEvent(-1, "chkSwitchAccount")
			$lblNB = GUICtrlCreateLabel(GetTranslated(108,3, "Number of accounts on Emulator :"), $x + 195, $y + 2, 165, 17)
			$cmbAccountsQuantity = GUICtrlCreateCombo("", $x + 365, $y - 2, 45, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
				GUICtrlSetOnEvent(-1, "cmbAccountsQuantity")
				GUICtrlSetData(-1, "2|3|4|5|6|7|8", "2")
		$y += 30
			$chkCanUse[1] = GUICtrlCreateCheckbox(GetTranslated(108,4, "Use Account 1 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[1] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[1] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[2] = GUICtrlCreateCheckbox(GetTranslated(108,6, "Use Account 2 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[2] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[2] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[3] = GUICtrlCreateCheckbox(GetTranslated(108,7, "Use Account 3 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[3] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[3] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[4] = GUICtrlCreateCheckbox(GetTranslated(108,8, "Use Account 4 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[4] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[4] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[5] = GUICtrlCreateCheckbox(GetTranslated(108,9, "Use Account 5 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[5] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[5] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[6] = GUICtrlCreateCheckbox(GetTranslated(108,10, "Use Account 6 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[6] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[6] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[7] = GUICtrlCreateCheckbox(GetTranslated(108,11, "Use Account 7 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[7] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[7] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
		$y += 28
			$chkCanUse[8] = GUICtrlCreateCheckbox(GetTranslated(108,12, "Use Account 8 with Profile :"), $x, $y, 150, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
			$cmbAccount[8] = GUICtrlCreateCombo("", $z, $y - 2, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
			$chkDonateAccount[8] = GUICtrlCreateCheckbox(GetTranslated(108,5, "Donate only"), $w, $y, 75, 17)
				GUICtrlSetOnEvent(-1, "chkAccountsProperties")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$g_EndHideSwitchAcc_DocOc = GUICtrlCreateDummy()	; Hide DocOc SwitchAcc to make room for SwitchAcc-Demen-Style

	setupProfileComboBox()
	PopulatePresetComboBox()

EndFunc
