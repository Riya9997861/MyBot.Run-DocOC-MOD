; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Control GTFO
; Description ...: This file Includes all functions to current GUI
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

Func GtfoHelp()
	ShellExecute("https://mybot.run/forums/index.php?/profile/43550-mediahub/")
EndFunc

Func GtfoAutoChat()
	if GUICtrlread($chkChatStatus) = $GUI_UNCHECKED then
		IF GUICtrlRead($chkGtfoChatAuto) = $GUI_CHECKED  THEN
			GUICtrlSetState($chkGtfoChatRandom, $GUI_ENABLE)
;~ 			GUICtrlSetState($btnGtfoChatAdd, $GUI_ENABLE)
;~ 			GUICtrlSetState($btnGtfoChatRemove, $GUI_ENABLE)
;~ 			GUICtrlSetState($lstGtfoChatTemplates, $GUI_ENABLE)
			GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
		Else
;~ 			GUICtrlSetState($chkGtfoChatRandom, $GUI_UNCHECKED)
			GUICtrlSetState($chkGtfoChatRandom, $GUI_DISABLE)
;~ 			GUICtrlSetState($btnGtfoChatAdd, $GUI_DISABLE)
;~ 			GUICtrlSetState($btnGtfoChatRemove, $GUI_DISABLE)
;~ 			GUICtrlSetState($lstGtfoChatTemplates, $GUI_DISABLE)
			GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
		EndIf
	Else
		GUICtrlSetState($chkGtfoChatAuto, $GUI_UNCHECKED)
		GUICtrlSetState($chkGtfoChatRandom, $GUI_DISABLE)
		SetLog("Chat: Previous chat message is in queue.")
	EndIf
EndFunc

Func GtfoRandomChat()

	IF GUICtrlRead($chkGtfoChatRandom) = $GUI_CHECKED  THEN
;~ 		GUICtrlSetState($btnGtfoChatAdd, $GUI_DISABLE)
;~ 		GUICtrlSetState($btnGtfoChatRemove, $GUI_DISABLE)
		GUICtrlSetState($lstGtfoChatTemplates, $GUI_DISABLE)
		GUICtrlSetState($btnGtfoSendChat, $GUI_DISABLE)
	Else
;~ 		GUICtrlSetState($btnGtfoChatAdd, $GUI_ENABLE)
;~ 		GUICtrlSetState($btnGtfoChatRemove, $GUI_ENABLE)
		GUICtrlSetState($lstGtfoChatTemplates, $GUI_ENABLE)
		GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
	EndIf
EndFunc

Func GtfoSetKickNote()

	IF GUICtrlRead($chkGtfoNote) = $GUI_CHECKED  Then
		GUICtrlSetState($txtGtfoNote, $GUI_ENABLE)
	Else
		GUICtrlSetState($txtGtfoNote, $GUI_DISABLE)
	EndIf

EndFunc

Func SetTrophies()

	IF GUICtrlRead($chkSetTrophies) = $GUI_CHECKED  Then
		GUICtrlSetState($cmbGtfoTrophies, $GUI_ENABLE)
		UpdateTrophies()
		$bSetTrophies = True
	Else
		GUICtrlSetState($cmbGtfoTrophies, $GUI_DISABLE)
		$bSetTrophies = False
	EndIf

EndFunc

Func GtfoActions($Action)

	$GtfoModStatus = $Action

	Switch $GtfoModStatus
		Case $GtfoIdle

		Case $GtfoStart
			GUICtrlSetState($btnStart, $GUI_DISABLE)
			GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
			GUICtrlSetState($btnGtfoStart, $GUI_DISABLE)
			GUICtrlSetState($cmbGtfoTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbGtfoSpell, $GUI_DISABLE)
			GUICtrlSetState($btnGtfoPause, $GUI_ENABLE)
			GUICtrlSetState($btnGtfoStop, $GUI_ENABLE)
			GtfoEnableDisable($cmbProfile,$btnRename,$GUI_DISABLE)

		Case $GtfoPause
			GUICtrlSetData($btnGtfoPause,"RESUME")
			$GtfoModStatus = $GtfoResume

		Case $GtfoResume
			GUICtrlSetData($btnGtfoPause,"PAUSE")
			$GtfoModStatus = $GtfoStart

		Case $GtfoStop
			GUICtrlSetState($btnStart, $GUI_ENABLE)
			GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
			GUICtrlSetState($btnGtfoStart, $GUI_ENABLE)
			GUICtrlSetState($cmbGtfoTroop, $GUI_ENABLE)
			GUICtrlSetState($cmbGtfoSpell, $GUI_ENABLE)
			GUICtrlSetState($btnGtfoPause, $GUI_DISABLE)
			GUICtrlSetData($btnGtfoPause,"PAUSE")
			GUICtrlSetState($btnGtfoStop, $GUI_DISABLE)
			GtfoEnableDisable($cmbProfile,$btnRename,$GUI_ENABLE)

	EndSwitch

EndFunc

Func GtfoSaveSettings()


	If GUICtrlRead($GTFOcheck) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "GTFOcheck", 1)
	Else
		IniWrite($config, "GTFO", "GTFOcheck", 0)
	EndIf
	IniWrite($config, "GTFO", "Kick", GUICtrlRead($cmbGtfo))
	If GUICtrlRead($chkMassDonate) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "MassDonate", 1)
	Else
		IniWrite($config, "GTFO", "MassDonate", 0)
	EndIf
	If GUICtrlRead($chkKickMode) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "KickMode", 1)
	Else
		IniWrite($config, "GTFO", "KickMode", 0)
	EndIf
	If GUICtrlRead($chkMassKick) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "MassKick", 1)
	Else
		IniWrite($config, "GTFO", "MassKick", 0)
	EndIf

	If GUICtrlRead($chkClanOpen) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "ClanOpen", 1)
	Else
		IniWrite($config, "GTFO", "ClanOpen", 0)
	EndIf
	If GUICtrlRead($chkWaitForTroops) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "WaitForTroops", 1)
	Else
		IniWrite($config, "GTFO", "WaitForTroops", 0)
	EndIf
	If GUICtrlRead($chkSetTrophies) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "SetTrophies", 1)
	Else
		IniWrite($config, "GTFO", "SetTrophies", 0)
	EndIf
	IniWrite($config, "GTFO", "Troop",  GUICtrlRead($cmbGtfoTroop))
	IniWrite($config, "GTFO", "TroopBoost",  GUICtrlRead($cmbGtfoTroopBoost))
	IniWrite($config, "GTFO", "Spell",  GUICtrlRead($cmbGtfoSpell))
	IniWrite($config, "GTFO", "SpellBoost",  GUICtrlRead($cmbGtfoSpellBoost))
	IniWrite($config, "GTFO", "DonationCap",  GUICtrlRead($cmbGtfoDonationCap))
	IniWrite($config, "GTFO", "KickCap",  GUICtrlRead($cmbGtfoKickCap))
	IniWrite($config, "GTFO", "Trophies",  GUICtrlRead($cmbGtfoTrophies))

	IniWrite($config, "GTFO", "IdleTime",  GUICtrlRead($SliderGtfoIdleTime))
	If GUICtrlRead($chkGtfoNote) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "Note", 1)
	Else
		IniWrite($config, "GTFO", "Note", 0)
	EndIf
	IniWrite($config, "GTFO", "Notes",  GUICtrlRead($txtGtfoNote))
	IniWrite($config, "GTFO", "Chat",  GUICtrlRead($txtGtfoChat))

	Local $iCnt = _GUICtrlListBox_GetCount($lstGtfoChatTemplates)
    Local $sMsg = ""
    For $n = 0 To $iCnt - 1
        $sMsg &=  _GUICtrlListBox_GetText($lstGtfoChatTemplates, $n)
		if $n <> $iCnt - 1 Then $sMsg &= "|"
    Next
	IniWrite($config, "GTFO", "ChatTemplates", $sMsg)

	If GUICtrlRead($chkGtfoChatAuto) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "ChatAuto", 1)
	Else
		IniWrite($config, "GTFO", "ChatAuto", 0)
	EndIf
	If GUICtrlRead($chkGtfoChatRandom) = $GUI_CHECKED Then
		IniWrite($config, "GTFO", "ChatRandom", 1)
	Else
		IniWrite($config, "GTFO", "ChatRandom", 0)
	EndIf

EndFunc