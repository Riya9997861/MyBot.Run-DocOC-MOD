; #FUNCTION# ====================================================================================================================
; Name ..........: GTFO
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

Func __WinAPI_GetBkColor($hWnd)
        ; Not Prog@ndy
        Local $aResult, $hDC, $Res
        If Not IsHWnd($hWnd) Then $hWnd = ControlGetHandle("", "", $hWnd)
        $hDC = _WinAPI_GetDC($hWnd)
        $aResult = DllCall("GDI32.dll", "int", "GetBkColor", "hwnd", $hDC)
        ConsoleWrite("Hex($aResult[0], 6) = " & Hex($aResult[0], 6) & @CRLF)
        $Res = "0x" & StringRegExpReplace(Hex($aResult[0], 6), "(.{2})(.{2})(.{2})", "\3\2\1")
        _WinAPI_ReleaseDC($hWnd, $hDC)
        Return $Res
EndFunc   ;==>__WinAPI_GetBkColor

Func GtfoTemplate_DoubleClick()

	GUICtrlSetData($txtGtfoChat,GUICtrlRead($lstGtfoChatTemplates))
	Local $CurSel = _GUICtrlListBox_GetCurSel($lstGtfoChatTemplates)
	Local $aItems = _GUICtrlListBox_GetSelItems($lstGtfoChatTemplates)
	For $iI = $aItems[0] To 1 step -1
		_GUICtrlListBox_ClickItem($lstGtfoChatTemplates, $aItems[$iI])
	Next
	_GUICtrlListBox_ClickItem($lstGtfoChatTemplates, $CurSel)

EndFunc

Func GtfoAddToTemplate()
	Local $ChatTxt = StringStripWS (GUICtrlRead($txtGtfoChat),7)
	if $ChatTxt <> "" then
		GUICtrlSetData($lstGtfoChatTemplates, $ChatTxt & "|")

		_GUICtrlListBox_UpdateHScroll($lstGtfoChatTemplates)
	EndIf
	Local $iCnt = _GUICtrlListBox_GetCount($lstGtfoChatTemplates)
    Local $sMsg = ""
    For $n = 0 To $iCnt - 1
        $sMsg &=  _GUICtrlListBox_GetText($lstGtfoChatTemplates, $n)
		if $n <> $iCnt - 1 Then $sMsg &= "|"
    Next
	IniWrite($config, "GTFO", "ChatTemplates", $sMsg)
	GUICtrlSetData($txtGtfoChat,"")
	GUICtrlSetState($txtGtfoChat, $GUI_FOCUS)

EndFunc

Func GtfoRemoveFromTemplate()

	Local $SelectionCount = _GUICtrlListBox_GetSelCount($lstGtfoChatTemplates)
	if $SelectionCount > 0 then
		Local $aItems = _GUICtrlListBox_GetSelItems($lstGtfoChatTemplates)
		For $iI = $aItems[0] To 1 step -1
			_GUICtrlListBox_DeleteString($lstGtfoChatTemplates, $aItems[$iI])
		Next
	Endif

	Local $iCnt = _GUICtrlListBox_GetCount($lstGtfoChatTemplates)
    Local $sMsg = ""
    For $n = 0 To $iCnt - 1
        $sMsg &=  _GUICtrlListBox_GetText($lstGtfoChatTemplates, $n)
		if $n <> $iCnt - 1 Then $sMsg &= "|"
    Next
	IniWrite($config, "GTFO", "ChatTemplates", $sMsg)

	GUICtrlSetState($txtGtfoChat, $GUI_FOCUS)

EndFunc

Func GtfoSetIdleTime()

	GUICtrlSetData($txtGtfoIdleTime, GUICtrlRead($SliderGtfoIdleTime) & " s")
	$GtfoIdleTime = Number(GUICtrlRead($SliderGtfoIdleTime))

EndFunc

Func UpdateTrophies()

	$aUpdateTrophies = GUICtrlRead($cmbGtfoTrophies)

EndFunc

Func GtfoSendChat()

	Local $ChatTxt = StringStripWS (GUICtrlRead($txtGtfoChat),7)
	GUICtrlSetData($txtGtfoChat,$ChatTxt)
	if $ChatTxt <> "" then
		GUICtrlSetState($chkChatStatus, $GUI_CHECKED)
		GUICtrlSetState($txtGtfoChat, $GUI_DISABLE)
		GUICtrlSetState($btnGtfoSendChat, $GUI_DISABLE)
	EndIf
	if $BotAction <> $eBotStart or $RunState <> $eBotSearchMode or $RunState <> $eBotClose  or $RunState <> True Then
		doChat()
	EndIf

EndFunc

Func DonationCap()
	$GtfoDonationCap = Number(GUICtrlRead($cmbGtfoDonationCap))
EndFunc

Func MassKick()
	if GUICtrlRead($chkMassKick) = $GUI_CHECKED Then
		$GtfoMassKickMode = True
	Else
		$GtfoMassKickMode = False
	EndIf
EndFunc

Func KickCap()
	$GtfoReceiveCap = Number(GUICtrlRead($cmbGtfoKickCap))
EndFunc

Func doChat()

	$FirstStart = False
	$RunState = True

	Local $chatString

	If GUICtrlRead($chkChatStatus) = $GUI_CHECKED Then
		AndroidBotStartEvent()
		$chatString = GUICtrlRead($txtGtfoChat)
		If  $chatString = "" then
			GUICtrlSetData($txtGtfoChat, "")
			GUICtrlSetState($chkChatStatus, $GUI_UNCHECKED)
			GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
			GUICtrlSetState($txtGtfoChat, $GUI_ENABLE)
			Return
		EndIf

		ForceCaptureRegion()
		If _CheckPixel($aChatTab, $bCapturePixel) = False Then ClickP($aOpenChat, 1, 0, "#0168")
		If _Sleep($iDelayDonateCC4) Then Return
		Local $icount = 0
		While 1
			If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) = True Then
				ExitLoop
			EndIf
			If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) = True Then
				If _Sleep(150) Then Return
				ClickP($aClanTab, 1, 0, "#0169")
				ExitLoop
			EndIf
			$icount += 1
			If $icount >= 25 Then
				ExitLoop
			EndIf
			If _Sleep(150) Then Return
		WEnd

		_Sleep(150)
		Click(275,700, 1, 0, "#0173")
		_Sleep(150)
		Local $icount = 0
		While Not ( _ColorCheck(_GetPixelColor(830, 700, True), Hex(0xFFFFFF, 6), 20))
			If _Sleep(100) Then ExitLoop
			$icount += 1
			If $icount > 25 Then
				SetLog("  Failed to send Chat Skipping chat Event. Will send Soon.", $COLOR_DEBUG)
				return
			EndIf
		WEnd

		_Sleep(150)
		Click(275,700, 1, 0, "0336")

		Local $tClip = ClipGet()
		ClipPut($chatString)
		_Sleep(150)
		ControlSend($HWnD, "", "", "{CTRLDOWN}a{CTRLUP}{CTRLDOWN}v{CTRLUP}",0)
		_Sleep(150)
		ClipPut($tClip)

		ForceCaptureRegion()
		if _ColorCheck(_GetPixelColor(830, 700, True), Hex(0xFFFFFF, 6), 20) Then
			Click(830,700, 1, 0, "#0173")
		EndIf

		GUICtrlSetData($txtGtfoChat, "")
		GUICtrlSetState($chkChatStatus, $GUI_UNCHECKED)
		GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
		GUICtrlSetState($txtGtfoChat, $GUI_ENABLE)
		Return
	Else
		AndroidBotStartEvent()
		If $GtfoModStatus = $GtfoPause or $GtfoModStatus = $GtfoResume Then
			Return
		EndIf
		Local $iI
		$iI = Random(1,5,1)
;~ 		$iI = 1
		if $iI = 1 Then
			If GUICtrlRead($chkGtfoChatAuto) = $GUI_CHECKED Then
				Local $iCount =  _GUICtrlListBox_GetCount($lstGtfoChatTemplates)
				if $GtfoChatCount >= $iCount Then
					$GtfoChatCount = 0
				EndIf
				If GUICtrlRead($chkGtfoChatRandom) = $GUI_CHECKED Then
					$iI = Random(1,$iCount,1) - 1
				Else
					$iI = $GtfoChatCount
					$GtfoChatCount += 1
				EndIf
				$chatString = _GUICtrlListBox_GetText ($lstGtfoChatTemplates,$iI)

				ForceCaptureRegion()
				If _CheckPixel($aChatTab, $bCapturePixel) = False Then ClickP($aOpenChat, 1, 0, "#0168")
				If _Sleep($iDelayDonateCC4) Then Return
				Local $icount = 0
				While 1
					If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) = True Then
						ExitLoop
					EndIf
					If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) = True Then
						If _Sleep($iDelayDonateCC1) Then Return
						ClickP($aClanTab, 1, 0, "#0169")
						ExitLoop
					EndIf
					$icount += 1
					If $icount >= 15 Then
						ExitLoop
					EndIf
					If _Sleep(150) Then Return
				WEnd

				_Sleep(150)
				Click(275,700, 1, 0, "#0173")
				_Sleep(150)
				Local $icount = 0
				While Not ( _ColorCheck(_GetPixelColor(830, 700, True), Hex(0xFFFFFF, 6), 20))
					If _Sleep(150) Then ExitLoop
					$icount += 1
					If $icount > 15 Then
						SetLog("  Failed to send Chat Skipping chat Event.", $COLOR_DEBUG)
						return
					EndIf
				WEnd

				_Sleep(150)
				Click(275,700, 1, 0, "0336")

				Local $tClip = ClipGet()
				ClipPut($chatString)
				_Sleep(150)
				ControlSend($HWnD, "", "", "{CTRLDOWN}a{CTRLUP}{CTRLDOWN}v{CTRLUP}",0)
				_Sleep(150)
				ClipPut($tClip)

				ForceCaptureRegion()
				if _ColorCheck(_GetPixelColor(830, 700, True), Hex(0xFFFFFF, 6), 20) Then
					Click(830,700, 1, 0, "#0173")
				EndIf

				GUICtrlSetData($txtGtfoChat, "")
				GUICtrlSetState($chkChatStatus, $GUI_UNCHECKED)
				GUICtrlSetState($btnGtfoSendChat, $GUI_ENABLE)
				GUICtrlSetState($txtGtfoChat, $GUI_ENABLE)
				Return

			EndIf
		EndIf
   EndIf

EndFunc

Func GtfoIdle()

	Local $sPauseMsgCount = 1
	While ( $GtfoModStatus = $GtfoPause  or $GtfoModStatus = $GtfoResume) AND $GtfoModStatus <> $GtfoStop
		if $sPauseMsgCount = 1 then
			$diTimer = TimerInit()
			SetLog("  >>>>>  GTFO  PAUSED  <<<<<  ",$COLOR_WARNING)
		EndIf
		$sPauseMsgCount += 1
		$diDiff = TimerDiff($diTimer)
		_TicksToTime($diDiff,$GtfoHours,$GtfoMins,$GtfoSecs)
		if $GtfoHours = 0 then
			$dsString =  StringFormat("%02u:%02u", $GtfoMins, $GtfoSecs)
		Else
			$dsString =  StringFormat("%02u:%02u:%02u",$GtfoHours, $GtfoMins, $GtfoSecs)
		EndIf

		_GUICtrlStatusBar_SetText($statlog, "     GTFO Paused Since : " & $dsString)
		If _Sleep(100) Then Return
	WEnd
	if $sPauseMsgCount <> 1  Then
		SetLog("  >>>>>  GTFO  RESUMED  <<<<<  ",$COLOR_SUCCESS)
	EndIf

EndFunc

Func IsInGame()


	Local $iCount = 0
	While _CheckPixel($aIsGoldBar, True) = False ; Wait for MainScreen
		$iCount += 1
		If _Sleep(50) Then Return
		;If checkObstacles() Then $iCount += 1
		If $iCount > 25 Then
			ClickP($aCloseChat, 1, 0, "#0168")
			If _Sleep(1000) Then Return
			Click(70, 680) ; return home
			If _Sleep(2000) Then Return
			ClickP($aAway, 1, 0, "#0167")
			ReturnAtHome()
			ForceCaptureRegion()
			If _CheckPixel($aChatTab, $bCapturePixel) = False Then
				ClickP($aOpenChat, 1, 0, "#0168")
				If _Sleep(500) Then Return
			EndIf
		EndIf
	WEnd

EndFunc

Func GTFOStart()

	WinGetAndroidHandle()
	_FileCreate($sProfilePath & "\" & $sCurrProfile  & "\gtfo.log")
	GtfoSaveSettings()
	SetLog("  >>>>>  GTFO  STARTED  <<<<<  ",$COLOR_WARNING)
	_GUICtrlComboBox_SetCurSel($cmbLog,4)
	cmbLog()
	$sTimer = TimerInit()
	saveConfig()
	readConfig()
	applyConfig(False)
	ResetVariables("donated")
	$GtfoTrainCount = 0
	$GtfoTroopTrainCount = 0
	$GtfoSpellBrewCount = 0

	GtfoActions($GtfoStart)
	if $BotAction = $eBotStart or $RunState = $eBotSearchMode or $RunState = $eBotClose  or $RunState = True Then
		SetLog("To Start GTFO - Free Man Style Stop / Restart the MyBot and try again")
		Return
	EndIf

	$GtfoReceiveCap = Number(GUICtrlRead($cmbGtfoKickCap))
	$GtfoDonationCap = Number(GUICtrlRead($cmbGtfoDonationCap))

	Local $GtfoTempSpell = GUICtrlRead($cmbGtfoSpell)
	$GtfoSpellType = -1
	Switch $GtfoTempSpell
		Case "Poison"
			$GtfoSpellType = 29
		Case "Earthquake"
			$GtfoSpellType = 30
		Case "Haste"
			$GtfoSpellType = 31
		Case "Skeleton"
			$GtfoSpellType = 32
	EndSwitch
	Local $GtfoTempTroop = GUICtrlRead($cmbGtfoTroop)
	$GtfoTroopType = -1
	Switch $GtfoTempTroop
		Case "Barbarian"
			$GtfoTroopType = 0
		Case "Archer"
			$GtfoTroopType = 1
	EndSwitch

	$FirstStart = True
	$RunState = True

	_guictrltab_clicktab($tabmain, 0)
	setredrawbotwindow(True)
	AndroidBotStartEvent()

;~ 	$x_start = 580
;~ 	$y_start = 380
;~ 	SetLog(getOcrAndCapture("coc-v-t", $x_start, $y_start, 75, 20, True))
;~ 	SetLog(getOcrAndCapture("coc-bonus", $x_start, $y_start, 75, 20, True))
;~ 	SetLog(getOcrAndCapture("coc-t-p", $x_start, $y_start, 75, 20, True))
;~ 	SetLog(getOcrAndCapture("coc-u-r", $x_start, $y_start, 75, 20, True))
;~ 	SetLog(getOcrAndCapture("coc-loot", $x_start, $y_start, 75, 20, True))
;~ 	SetLog(getOcrAndCapture("coc-build", $x_start, $y_start, 75, 20, True))
;~ 	$x_start = 520
;~ 	$y_start = 245
;~ 	SetLog(getOcrAndCapture("coc-pbttime", 520, 245, 40, 15, True))
;~ 	SetLog(getOcrAndCapture("coc-RemainTrain", $x_start, $y_start, 40, 15, True))
;~ 	SetLog(getOcrAndCapture("coc-profile", $x_start, $y_start, 40, 15, True))
;~ 	SetLog(getOcrAndCapture("CurXpOCR-bundle", $x_start, $y_start, 40, 15, True))
;~ 	GTFOStop()
;~ 	Return

	checkMainScreen()
	chkShieldStatus(True, True)
	If Not $bSearchMode Then
		BotDetectFirstTime()
	EndIf
	Collect()
	VillageReport(True, True)

	_CaptureRegion2()
	$hClone = _GDIPlus_BitmapCloneArea(_GDIPlus_BitmapCreateFromHBITMAP($hHBitmap2), 600, 100, 10, 10, $GDIP_PXF24RGB)
	_GDIPlus_ImageSaveToFile($hClone, $donateimagefoldercapture & $sLastkickedFile)
	_GDIPlus_ImageDispose($hClone)

	$tempCounter = 0
	While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 5
		$tempCounter += 1
		If _Sleep(100) Then Return
		VillageReport(True, True)
	WEnd
	RequestCC()
	ReArm()
	VillageReport(True, True)
	if Not GtfoTrain() Then Return
	Sleep(250)

	Local $cycleCount, $DonateCount ,$dTimer, $dDiff
	$cycleCount = 0
	$DonateCount = 0

	Local $yPos = 90

	While 1

		IsInGame()
		doChat()
		GtfoIdle()
		If $GtfoModStatus = $GtfoStop Then Return

		Local $bOpen = True, $bClose = False
		$bDonate = True
		$iDonTroopsLimit = $GtfoDonationCap
		$iDonSpellsLimit = 1
		$iDonTroopsAv = 0
		$iDonSpellsAv = 0
		$iDonTroopsQuantityAv = 0
		$iDonTroopsQuantity = 0
		$iDonSpellsQuantityAv = 0
		$iDonSpellsQuantity = 0
		$bSkipDonTroops = False
		$bSkipDonSpells = False


		If $DonateCount >= 25 Then
			$DonateCount = 0
			ClickP($aCloseChat, 1, 0, "#0168")
			If _Sleep(500) Then Return
			ClickP($aAway, 1, 0, "#0167")
			checkMainScreen()
			checkAttackDisable($iTaBChkIdle)
			if Not GtfoTrain() Then Return
			chkShieldStatus(True,True)
			ClickP($aOpenChat, 1, 0, "#0168")
			If _Sleep(1000) Then Return
			GTFOKICK()
			$dTimer = TimerInit()
		EndIf
		If Mod($cycleCount, 500) = 0 Then
			ClickP($aCloseChat, 1, 0, "#0168")
			ClickP($aAway, 1, 0, "#0167")
			If _Sleep(1000) Then Return
			checkMainScreen()
			ZoomOut()
			Collect()
			VillageReport(True, True)
			$tempCounter = 0
			While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 5
				$tempCounter += 1
				If _Sleep(100) Then Return
				VillageReport(True, True)
			WEnd
			ReArm()
			VillageReport(True, True)
			RequestCC()
			ClickP($aOpenChat, 1, 0, "#0168")
			If _Sleep($iDelayDonateCC1) Then Return
		EndIf
		if $cycleCount = 0 then
			$dTimer = TimerInit()
		EndIf
		$cycleCount =  $cycleCount  + 1

		ClickP($aAway, 1, 0, "#0167")

		if $GtfoTopEnd = 0 Then
			$yPos = 90
			$GtfoTopEnd = -1
		EndIf

		ForceCaptureRegion()
		If _CheckPixel($aChatTab, $bCapturePixel) = False Then
			ClickP($aOpenChat, 1, 0, "#0168")
			If _Sleep(500) Then Return
		EndIf

		Local $icount = 0
		While 1
			If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) = True Then
				ExitLoop
			EndIf
			If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) = True Then
				If _Sleep(100) Then Return
				ClickP($aClanTab, 1, 0, "#0169")
				ExitLoop
			EndIf
			$icount += 1
			If $icount >= 10 Then
				ContinueLoop 2
			EndIf
			If _Sleep(150) Then Return
		WEnd
		ClickP($aClanTab, 1, 0, "#0169")
		Local $Scroll

		While ($bDonate and $DonateCount < 25) and (Not $GtfoMassKickMode)
			If $GtfoModStatus = $GtfoStop Then Return
			GtfoIdle()
			IsInGame()
			checkAttackDisable($iTaBChkIdle)
;~ 			If _Sleep(100) Then ExitLoop
			ForceCaptureRegion()

			$DonatePixel = _MultiPixelSearch(202, $yPos, 224, 660 + $bottomOffsetY, 50, 1, Hex(0x98D057, 6), $aChatDonateBtnColors, 15)
			If IsArray($DonatePixel) Then
;~ 				If $debugsetlog = 1 Then SetLog("$DonatePixel: (" & $DonatePixel[0] & "," & $DonatePixel[1] & ") $yPos: " & $yPos, $COLOR_DEBUG)
				$bDonate = False
				$bSkipDonTroops = False
				$bSkipDonSpells = False
				RemainingCCcapacity()

				If $iTotalDonateCapacity <= 0 Then
					SetLog("Clan Castle troops are full, skip troop donation...", $COLOR_ORANGE)
					$bSkipDonTroops = True
				EndIf
				If $iTotalDonateSpellCapacity = 0 Then
					SetLog("Clan Castle spells are full, skip spell donation...", $COLOR_ORANGE)
					$bSkipDonSpells = True
				ElseIf $iTotalDonateSpellCapacity = -1 Then
					If $debugsetlog = 1 Then SetLog("This CC cannot accept spells, skip spell donation...", $COLOR_DEBUG)
					$bSkipDonSpells = True
				EndIf

				If ($bSkipDonTroops = True And $bSkipDonSpells = True)  Then
					$bDonate = True
					$yPos = $DonatePixel[1] + 50
					$GtfoTopEnd = -1
					ContinueLoop
				EndIf
				if DonateWindow($bOpen) = False Then
					$bDonate = True
					$yPos = $DonatePixel[1] + 50
					$GtfoTopEnd = -1
					ContinueLoop
				EndIf

				$DonateCount = $DonateCount + 1
				if $GtfoSpellType <> -1 and $bSkipDonSpells = False then
					GtfoDonateTroopType($GtfoSpellType, 1, False, True)
				EndIf
				If $GtfoTroopType <> -1 and $bSkipDonTroops = False Then
					GtfoDonateTroopType($GtfoTroopType, $iDonTroopsLimit, False, True)
				EndIf
				$dTimer = TimerInit()
				Click(700,5, 1, 150)
				$bDonate = True
				$yPos = $DonatePixel[1] + 50
				$GtfoTopEnd = -1
;~ 				ClickP($aAway, 1, 0, "#0171")
;~ 				If _Sleep($iDelayDonateCC2) Then ExitLoop
			Else
				$GtfoTopEnd = 0
			EndIf
			GtfoIdle()

			ForceCaptureRegion()
			$DonatePixel = _MultiPixelSearch(202, $yPos, 224, 660 + $bottomOffsetY, 50, 1, Hex(0x98D057, 6), $aChatDonateBtnColors, 15)
			If IsArray($DonatePixel) Then
				If $debugsetlog = 1 Then SetLog("More Donate buttons found, new $DonatePixel: (" & $DonatePixel[0] & "," & $DonatePixel[1] & ")", $COLOR_DEBUG)
				ContinueLoop
			EndIf

			If $GtfoModStatus = $GtfoPause or $GtfoModStatus = $GtfoResume Then
				$dTimer = TimerInit()
			else
				$dDiff = TimerDiff($dTimer)

				$GtfoMins = Int($dDiff / (60 * 1000))
				$GtfoSecs = Int(($dDiff - ($GtfoMins * 60 * 1000)) / 1000)

;~ 				_TicksToTime($dDiff,$GtfoHours,$GtfoMins,$GtfoSecs)
				$sString =  StringFormat("%02u" & ":" & "%02u", $GtfoMins, $GtfoSecs)
				_GUICtrlStatusBar_SetText($statlog, "     GTFO Idle Since : " & $sString)
				$dDiff = Number($dDiff,2)
				if $dDiff > ($GtfoIdleTime * 1000) Then
;~ 					$DonateCount = 25
;~ 					ContinueLoop 2
					ClickP($aClanTab, 1, 0, "#0169")
					GTFOKICK()
					$dTimer = TimerInit()
					$yPos = 90
				EndIf
			EndIf

			ForceCaptureRegion()
			$Scroll = _PixelSearch(293, 98, 295, 113, Hex(0xFFFFFF, 6), 20)
			If IsArray($Scroll) Then
				$bDonate = True
				Click($Scroll[0], $Scroll[1], 1, 0, "#0172")
				$yPos = 90
;~ 				If _Sleep(200) Then ExitLoop
				ContinueLoop
			Else
;~ 				ClickP($aClanTab, 1, 0, "#0169")
			EndIf
			$bDonate = False
		WEnd

		if $GtfoMassKickMode Then
			GTFOKICK()
			$DonateCount += 1
		EndIf

		ClickP($aAway, 1, 0, "#0176")
		Click(700,5, 1, 150)
		If _Sleep(150) Then Return

   WEnd
	Click(1, 40, 1, 150)
	If _Sleep(150) Then Return
   GTFOStop()

EndFunc

Func GTFOPause()

	If $GtfoModStatus = $GtfoStart Then
		GtfoActions($GtfoPause)
	Else
		GtfoActions($GtfoResume)
	EndIf

EndFunc

Func GTFOStop()
	FileDelete ($sProfilePath & "\" & $sCurrProfile  & "\gtfo.log")
	GUICtrlSetState($GTFOcheck,$GUI_ENABLE)
	$GtfoTrainCount = 0
	$GtfoTroopTrainCount = 0
	$GtfoSpellBrewCount = 0
	GtfoActions($GtfoStop)
	$BotAction = $eBotNoAction
	$RunState = False
	_GUICtrlComboBox_SetCurSel($cmbLog,0)
	cmbLog()
	SetLog("  >>>>>  GTFO  STOPPED  <<<<<  ",$COLOR_WARNING)
	GtfoSaveSettings()
EndFunc

Func GtfoTrain()

	if $GtfoMassKickMode Then Return True
	GUICtrlSetState($GTFOcheck,$GUI_DISABLE)
    Local $aGetArmySize[3] = ["", "", ""]

	Local $timer
	Local $tempElixir = ""
	Local $tempDElixir = ""
	Local $tempElixirSpent = 0
	Local $tempDElixirSpent = 0

	ClickP($aCloseChat, 1, 0, "#0168")
	_Sleep($iDelayTrain1)
	ClickP($aAway, 1, 0, "#0167") ;Click Away
	_Sleep($iDelayTrain1)

	VillageReport(True, True)
	$tempCounter = 0
	While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 10
		$tempCounter += 1
		If _Sleep(100) Then Return
		VillageReport(True, True)
	WEnd
	$tempElixir = $iElixirCurrent
	$tempDElixir = $iDarkCurrent

	Local $GtfoTempTroop = GUICtrlRead($cmbGtfoTroop)
	Local $GtfoTempSpell = GUICtrlRead($cmbGtfoSpell)
	Local $GtfoTempTroopBoost = GUICtrlRead($cmbGtfoTroopBoost)
	Local $GtfoTempSpellBoost = GUICtrlRead($cmbGtfoSpellBoost)

	if ( int($itxtRestartElixir) >= int($iElixirCurrent) ) or ( int($iElixirCurrent) <1000 ) Then
		SetLog("Running Out of Elixir. GTFO Stopped. Elixir Halt Limit Reached.", $COLOR_RED)
		GTFOStop()
		Return False
	EndIf

	If (Int($itxtRestartDark) >= Int($iDarkCurrent) or ( int($iDarkCurrent) < 200 )) and $GtfoTempSpell <> "None" Then
		SetLog("Disabled Spell Donations. Dark Elixir Halt Limit Reached.",$COLOR_RED )
		_GUICtrlComboBox_SetCurSel($cmbGtfoSpell,0)
		$GtfoTempSpell = GUICtrlRead($cmbGtfoSpell)
	EndIf

	If $GtfoTempSpell = "None" Then
		SetLog("Training Troops", $COLOR_BLUE)
	Else
		SetLog("Training Troops & Brew Spells", $COLOR_BLUE)
	EndIf

	If WaitforPixel(28, 505 + $bottomOffsetY, 30, 507 + $bottomOffsetY, Hex(0xE4A438, 6), 5, 10) Then
		If $debugsetlogTrain = 1 Then SetLog("Click $aArmyTrainButton", $COLOR_DEBUG)
		Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293") ; Button Army Overview
	EndIf
	_Sleep(500)

	$Result = getAttackDisable(180, 156 + $midOffsetY) ; Try to grab Ocr for PBT warning message as it can randomly block pixel check
	If $debugSetlog = 1 Then SetLog("OCR PBT early warning= " & $Result, $COLOR_DEBUG)
	If (StringLen($Result) > 3) And StringRegExp($Result, "[a-w]", $STR_REGEXPMATCH) Then ; Check string for valid characters
		SetLog("Personal Break Warning found!", $COLOR_INFO)

		CheckAttackDisable($iTaBChkIdle)

;~ 		WinGetAndroidHandle()
;~ 		AndroidHomeButton()
;~ 		If _SleepStatus(18 * 1000 * 60) Then Return
		_GUICtrlEdit_SetText($txtLog, _PadStringCenter(" GTFO LOG ", 71, "="))
		_GUICtrlRichEdit_SetFont($txtLog, 6, "Lucida Console")
		_GUICtrlRichEdit_AppendTextColor($txtLog, "" & @CRLF, _ColorConvert($Color_Black))
;~ 		SendAdbCommand("shell am start -n " & $androidgamepackage & "/" & $androidgameclass)
		_GuiCtrlStatusBar_SetText($statlog, "")
		AndroidBotStartEvent()
		CheckMainScreen()
		CheckAttackDisable($iTaBChkIdle)
		ChkShieldStatus(True,True)
		RequestCC()
		ReArm()
		GtfoTrain()
		Return
	EndIf

	If WaitforPixel(815, 120 , 820, 125 , Hex(0xF06C70, 6), 10, 10) Then
		If $debugsetlogTrain = 1 Then SetLog("Wait for ArmyOverView Window", $COLOR_DEBUG)
		_Sleep(500)
		$getArmyCampCap = getOcrAndCapture("coc-ms", 110, 166, 82, 16, True)
		If $debugsetlogTrain = 1 Then SetLog("OCR $getArmyCampCap = " & $getArmyCampCap, $COLOR_DEBUG)
		$aGetArmySize = StringSplit($getArmyCampCap, "#")
		If IsArray($aGetArmySize) Then
			If $aGetArmySize[0] > 1 Then ; check if the OCR was valid and returned both values
			   $CurCamp = Number($aGetArmySize[1])
			   $TotalCamp = Number($aGetArmySize[2])
			   $CurCampPer = Int($CurCamp / $TotalCamp * 100)
			   SetLog("Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp & " (" & $CurCampPer & "%)", $COLOR_GREEN)
			   $ArmyCapacity = Int($CurCamp / $TotalCamp * 100)
			EndIf
		Else
			SetLog("OCR Error while reading Army Overview Window", $COLOR_DEBUG)
		EndIf

		$getSpellCap = getOcrAndCapture("coc-ms", 100, 313, 50, 16, True)
		;SetLog("OCR $getSpellCap = " & $getSpellCap, $COLOR_DEBUG)
		If $debugsetlogTrain = 1 Then SetLog("OCR $getSpellCap = " & $getSpellCap, $COLOR_DEBUG)
		$aGetSpellSize = StringSplit($getSpellCap, "#")
		If IsArray($aGetSpellSize) Then
			If $aGetSpellSize[0] > 1 Then ; check if the OCR was valid and returned both values
			   $CurSpell = Number($aGetSpellSize[1])
			   $TotalSpell = Number($aGetSpellSize[2])
			   SetLog("Total Spell capacity: " & $CurSpell & "/" & $TotalSpell , $COLOR_GREEN)
			   $SpellCapacity = Int($CurSpell / $TotalSpell * 100)
			EndIf
		Else
			SetLog("OCR Error while reading Army Overview Window", $COLOR_DEBUG)
		EndIf

		Click(230, 140, 1, 0, "#0293")
	EndIf
   _Sleep(250)

	If WaitforPixel(230, 140 , 240, 145 , Hex(0xE8ECE0, 6), 10, 10) Then

		If $debugsetlogTrain = 1 Then SetLog("Wait for Troops Window", $COLOR_GREEN)
		_Sleep(500)
		$getArmyCampCap = getOcrAndCapture("coc-train-quant", 45, 160, 70, 18, True)
		If $debugsetlogTrain = 1 Then SetLog("OCR $sArmyInfo = " & StringLeft($getArmyCampCap, StringLen($getArmyCampCap)-3), $COLOR_DEBUG)
		Local $iTroopTrain = ($TotalCamp*2) - Number(StringLeft($getArmyCampCap, StringLen($getArmyCampCap)-3))

		if $iTroopTrain <= 0 then
			$iTroopTrain = 0
		Else
			Local $eGtfoTempTroop = -1
			Switch $GtfoTempTroop
				Case "Barbarian"
					$eGtfoTempTroop = 0
				Case "Archer"
					$eGtfoTempTroop = 1
			EndSwitch
			$GtfoTroopType = $eGtfoTempTroop
			SetLog("Troops to Train ("& $GtfoTempTroop &"): " & $iTroopTrain, $COLOR_GREEN)
			TrainIt($eGtfoTempTroop, $iTroopTrain, 10)
		EndIf
		if $GtfoTroopTrainCount > 0 Then DonatedTroop($GtfoTroopType, $iTroopTrain)
		$GtfoTroopTrainCount += 1

		if $GtfoTempTroopBoost > 0 Then
			$ClickResult = ClickOnBoostArmyWindow()
			If $ClickResult = True Then
				$GemResult = IsGemWindowOpen("", "", True)
				If $GemResult = True Then
					If $GtfoTempTroopBoost >= 1 Then $GtfoTempTroopBoost -= 1
					SetLog(" Total remain cycles to boost Barracks:" & $GtfoTempTroopBoost, $COLOR_GREEN)
					GUICtrlSetData($cmbGtfoTroopBoost, $GtfoTempTroopBoost)
				EndIf
			EndIf
		EndIf

		Click(430, 140, 1, 0, "#0293")
	EndIf
	_Sleep(500)

	If WaitforPixel(430, 140 , 440, 145 , Hex(0xE8ECE0, 6), 10, 10) Then
		If $debugsetlogTrain = 1 Then SetLog("Wait for Spells Window", $COLOR_DEBUG)
		_Sleep(500)
		Local $iSplAdj = 1
		if $TotalSpell >= 10 then $iSplAdj = 2
		$getSpellCap = getOcrAndCapture("coc-train-quant", 50, 160, 40, 18, True)
		If $debugsetlogTrain = 1 Then SetLog("OCR $sArmyInfo = " & StringLeft($getSpellCap, StringLen($getSpellCap)-$iSplAdj), $COLOR_DEBUG)

		Local $iSpellBrew = ($TotalSpell*2) - Number(StringLeft($getSpellCap, StringLen($getSpellCap)-$iSplAdj))


		if $iSpellBrew <= 0 or $GtfoTempSpell = "None" then
			$iSpellBrew = 0
		Else
			Local $eGtfoTempSpell = -1
			Switch $GtfoTempSpell
				Case "Poison"
					$eGtfoTempSpell = 29
				Case "Earthquake"
					$eGtfoTempSpell = 30
				Case "Haste"
					$eGtfoTempSpell = 31
				Case "Skeleton"
					$eGtfoTempSpell = 32
			EndSwitch
			$GtfoSpellType =  $eGtfoTempSpell
			;CheckForSantaSpell()
			SetLog("Spell to Brew (" & $GtfoTempSpell  &"): " & $iSpellBrew, $COLOR_GREEN)
			TrainIt($eGtfoTempSpell, $iSpellBrew, 10)
		EndIf
		if $GtfoSpellBrewCount = 0 Then ResetVariables("donated")
		if $GtfoSpellBrewCount > 0 Then DonatedSpell($GtfoSpellType, $iSpellBrew)
		$GtfoSpellBrewCount += 1

		if $GtfoTempSpell <> "None" then
			if $GtfoTempSpellBoost > 0 Then
				$ClickResult = ClickOnBoostArmyWindow()
				If $ClickResult = True Then
					$GemResult = IsGemWindowOpen("", "", True)
					If $GemResult = True Then
						If $GtfoTempSpellBoost >= 1 Then $GtfoTempSpellBoost -= 1
						SetLog(" Total remain cycles to boost Barracks:" & $GtfoTempSpellBoost, $COLOR_GREEN)
						GUICtrlSetData($cmbGtfoSpellBoost, $GtfoTempSpellBoost)
					EndIf
				EndIf
			EndIf
		EndIf


		if $CurCampPer < 5 Then
			Click(30, 140, 1, 0, "#0293")
			If WaitforPixel(30, 140 , 240, 145 , Hex(0xE8ECE0, 6), 10, 10) Then
				Local $TimeRemainTroops = getRemainTrainTimer(756, 169)
				Local $ResultTroopsHour, $ResultTroopsMinutes, $ResultTroopsSeconds
				Global $aRemainTrainTroopTimer = 0
				$aTimeTrain[0] = 0

				If $TimeRemainTroops <> "" Then
					If StringInStr($TimeRemainTroops, "h") > 1 Then
						$ResultTroopsHour = StringSplit($TimeRemainTroops, "h", $STR_NOCOUNT)
						$ResultTroopsMinutes = StringTrimRight($ResultTroopsHour[1], 1)
						$aRemainTrainTroopTimer = (Number($ResultTroopsHour[0]) * 60) + Number($ResultTroopsMinutes)
					ElseIf StringInStr($TimeRemainTroops, "m") > 1 Then
						$ResultTroopsMinutes = StringSplit($TimeRemainTroops, "m", $STR_NOCOUNT)
						$aRemainTrainTroopTimer = $ResultTroopsMinutes[0] + Ceiling($ResultTroopsMinutes[1] / 60)
					Else
						$ResultTroopsSeconds = StringTrimRight($TimeRemainTroops, 1)
						$aRemainTrainTroopTimer = Ceiling($ResultTroopsSeconds / 60)
					EndIf
					$aTimeTrain[0] = $aRemainTrainTroopTimer
				EndIf
			EndIf
			;;$aRemainTrainTroopTimer
		else
			Click(815, 245, 1, 0, "#0293")
		EndIf

	EndIf
	Click(1, 40, 1, 500)
	_Sleep(500)

	VillageReport(True, True)

	$tempCounter = 0
	While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 30
		$tempCounter += 1
		If _Sleep($iDelayTrain1) Then Return
		VillageReport(True, True)
	WEnd

	If $tempElixir <> "" And $iElixirCurrent <> "" Then
		$tempElixirSpent = ($tempElixir - $iElixirCurrent)
		$iTrainCostElixir += $tempElixirSpent
		$iElixirTotal -= $tempElixirSpent
	EndIf

	If $tempDElixir <> "" And $iDarkCurrent <> "" Then
		$tempDElixirSpent = ($tempDElixir - $iDarkCurrent)
		$iTrainCostDElixir += $tempDElixirSpent
		$iDarkTotal -= $tempDElixirSpent
	EndIf

	If $Runstate = False Then Return
	UpdateStats()

	checkAttackDisable($iTaBChkIdle)

;~ 	If GUICtrlRead($chkWaitForTroops) = $GUI_CHECKED and $GtfoTempTroopBoost = 0 Then
	If GUICtrlRead($chkWaitForTroops) = $GUI_CHECKED Then
		if $CurCampPer < 5 Then
			GTFOKICK()
			SetLog("GTFO: Smart wait train time = " & $aRemainTrainTroopTimer & " Minutes", $color_info)
			WinGetAndroidHandle()
			AndroidHomeButton()
			If _SleepStatus($aRemainTrainTroopTimer * 1000 * 60) Then Return
			_GUICtrlEdit_SetText($txtLog, _PadStringCenter(" GTFO LOG ", 71, "="))
			_GUICtrlRichEdit_SetFont($txtLog, 6, "Lucida Console")
			_GUICtrlRichEdit_AppendTextColor($txtLog, "" & @CRLF, _ColorConvert($Color_Black))
			SendAdbCommand("shell am start -n " & $androidgamepackage & "/" & $androidgameclass)
			_GuiCtrlStatusBar_SetText($statlog, "")
			AndroidBotStartEvent()
			CheckMainScreen()
			CheckAttackDisable($iTaBChkIdle)
			ChkShieldStatus(True,True)
			RequestCC()
			ReArm()
		EndIf
	EndIf

	Return True
EndFunc

Func GTFOKICK($limit = 0)

;~     Click(1, 40, 1, 500)
    Local  $Scroll,$len, $kick_y, $kicked = 0,$kicklimit, $mDonated, $mReceived, $Count = 1, $loopcount, $new, $p1, $p2,$lastNum, $lastNumCheck, $cp, $sNum, $sresultTrophies
    $len = 0
	$kicked = 0

	If GUICtrlRead($GTFOcheck) = 1 Then
		;Set Global Kick loop Couter Here
	Else
		Return
	EndIf

	if $limit = 0 then
		$kicklimit =  GUICtrlRead($cmbGtfo)
		if $kicklimit = 0 Then
		  Return
		EndIf
    Else
	   $kicklimit = $limit
    EndIf


	Click(1, 40, 1, 250)
	If _Sleep(250) Then Return
	If _CheckPixel($aChatTab, $bCapturePixel) = False Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
	If _Sleep($iDelayDonateCC4) Then Return

	Local $icount = 0
	While 1
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) = True Then
			ExitLoop
		EndIf
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) = True Then
			If _Sleep($iDelayDonateCC1) Then Return
			ClickP($aClanTab, 1, 0, "#0169")
			ExitLoop
		EndIf
		$icount += 1
		If $icount >= 15 Then
			$DonateCount = 100
			ExitLoop
		EndIf
		If _Sleep($iDelayDonateCC1) Then Return
	WEnd

	While $kicked < $kicklimit
		IsInGame()
		GtfoIdle()
		If $GtfoModStatus = $GtfoStop Then Return
		if _Sleep(250) then ExitLoop
		Click(150, 60)
		If _Sleep(250) Then ExitLoop
		$loopcount = 0

		While _ColorCheck( _GetPixelColor(60, 350, True), Hex(0x65B010, 6), 20) == False ;- Check Green pixel on warlog Button
			If _Sleep(150) Then ExitLoop
			$loopcount += 1
			If $loopcount >= 20 Then
				$loopcount = 0
				Click(1, 40, 1, 250)
				SetLog("    Unable to Load Clan Page Skipping Member Kick", $COLOR_RED)
				Return
			EndIf
		WEnd

		Local $sresultTrophies = ""
		If $bSetTrophies Then
			_captureregion()
			$sresultTrophies = getOcrAndCapture("coc-pbttime", 520, 245, 40, 15, True)
			$currClanTrophies = Number($sresultTrophies)
		EndIf

		Local $res = "", $res1 = "", $ClanMode="", $bsUpdateTrophies = False
		If GUICtrlRead($chkClanOpen) = $GUI_CHECKED Then
			_captureregion()
			$res  = isImageVisible("ClanClosed",@ScriptDir & "\images\closed_0_0_85.bmp","510,225,560,240")
			$res1  = isImageVisible("AnyOneCanJoin",@ScriptDir & "\images\AnyOneCanJoin_0_0_85.bmp","510,225,560,240")
			If $res1 <> "" Then
				$posPoint = StringSplit($res1,",")
				If $posPoint[0] = "0" or $posPoint[0] = "" Then
					$ClanMode = ""
				Else
					$ClanMode = "Open"
				EndIf
			ElseIf $res <> "" Then
				$posPoint1 = StringSplit($res,",")
				If $posPoint1[0] = "0" or $posPoint1[0] = "" Then
					$ClanMode = ""
				Else
					$ClanMode = "Closed"
				EndIf
			Else
				$ClanMode = "Invite"
			EndIf
		EndIf

		if $bSetTrophies Then
			if $aUpdateTrophies <> $currClanTrophies Then
				Local $CurrentTrophiesIndex= _ArrayFindAll($aGtfoCanTrophies, $currClanTrophies)
				Local $SetTrophieIndex = _ArrayFindAll($aGtfoCanTrophies, $aUpdateTrophies)
				Local $diffIndexLevel = $SetTrophieIndex[0]  - $CurrentTrophiesIndex[0]
				$bsUpdateTrophies = True
			EndIf
		EndIf

		If (($ClanMode <> "") and ($ClanMode <> "Open")) or $bsUpdateTrophies then
			Click(540, 340, 1, 500)
		    _Sleep(500)
			Switch $ClanMode
				Case "Invite"
					Click(434, 393, 2, 500)
				Case "Closed"
					Click(434, 393, 1, 500)
				Case "Open"
					SetLog("Clan Is alrady in Open State", $COLOR_GREEN)
				Case Else
					SetLog("       Unknown error ", $COLOR_RED)
			EndSwitch
			_Sleep(500)

			if $bsUpdateTrophies Then
				if $diffIndexLevel < 0 Then
					$diffIndexLevel =  (-1 * $diffIndexLevel)
					Click(545, 395, $diffIndexLevel, 500)
;~ 					SetLog("Reduce trophies")
				Else
					Click(680, 395, $diffIndexLevel, 500)
;~ 					SetLog("Increase trophies")
				EndIf
				_Sleep(500)
			EndIf

			Click(425, 610, 1, 500)
			_Sleep(1000)
			Click(150, 60)
			_Sleep(500)

			$loopcount = 0
			While _ColorCheck( _GetPixelColor(60, 350, True), Hex(0x65B010, 6), 20) = False
				If _Sleep(150) Then ExitLoop
				$loopcount += 1
				If $loopcount >= 20 Then
					$loopcount = 0
					Click(700,5, 1, 500)
					SetLog("    Unable to Load Clan Page After Clan Settings", $COLOR_RED)
					Return
				EndIf
			WEnd
		EndIf

		$KickPosX = -1
		$Scroll = 0
		$cp = 117
		$len = 0
		While 1
			If $GtfoModStatus = $GtfoStop Then Return
			If $debugSetlog = 1 Then SetLog("Capture. cp: " & $cp , $COLOR_ORANGE)
			_CaptureRegion(199, $cp, 211, 671)
			$new = _PixelSearch(200, $cp, 210, 671, Hex(0xE73838, 6),20)
			If IsArray($new) Then
				$KickPosX = $new[0]
				$KickPosY = $new[1]

				$mDonated = Int(Number(getOcrAndCapture("coc-army",$new[0]+280,$new[1]-10, 70, 14, True)))

				if $mDonated > 0  Then
					$mReceived = 999999
				Else
					if( GUICtrlRead($chkKickMode) <> 1 ) Then
						$mReceived = getOcrAndCapture("coc-army",$new[0]+400,$new[1]-10, 70, 14, True)
					Else
						$mReceived = 0
					EndIf
				EndIf

;~ 				_CaptureRegion2()
;~ 				$hClone = _GDIPlus_BitmapCloneArea(_GDIPlus_BitmapCreateFromHBITMAP($hHBitmap2), 190, $new[1] - 30, 65, 30, $GDIP_PXF24RGB)
;~ 				_GDIPlus_ImageSaveToFile($hClone, $donateimagefoldercapture & "KickCapture.png")
;~ 				_GDIPlus_ImageDispose($hClone)
				_captureregion()
				$res  = isImageVisible("LastKicked",$donateimagefoldercapture & $sLastkickedFile, String(190) & ","& String($new[1] - 30) & "," & String(255) & "," & String($new[1]))
				If $res <> "" then
					$posPoint = StringSplit($res,",")
					If $posPoint[0] = "0" or $posPoint[0] = "" Then
						;
					Else
						SetLog("Found Last Kicked, Skipping and continue finding other members", $COLOR_SUCCESS)
	 					$cp = $new[1]  + 20
	 					ContinueLoop
;~ 						$mReceived = 0
;~ 						$mDonated = 0
					EndIf
				EndIf

				If $debugSetlog = 1 Then SetLog("Check For To Kick Members", $COLOR_RED)
				If $debugSetlog = 1 Then SetLog($sNum & " # x:" & $new[0] & " y:"  & $new[1], $COLOR_RED)

				If $mDonated > 0 or $mReceived >= $GtfoReceiveCap then
					$sNum = getTrophyVillageSearch($new[0]-180,$new[1]-18)
					Click($new[0], $new[1])
					If _Sleep(250) Then ExitLoop
					If $new[1] > 620 Then
						$kick_y = 700
					Else
						$kick_y = $new[1] + 70
					EndIf

					_CaptureRegion2()
					$hClone = _GDIPlus_BitmapCloneArea(_GDIPlus_BitmapCreateFromHBITMAP($hHBitmap2), 195, $new[1] - 15, 35, 10, $GDIP_PXF24RGB)
					_GDIPlus_ImageSaveToFile($hClone, $donateimagefoldercapture & $sLastkickedFile)
					_GDIPlus_ImageDispose($hClone)

					Click($new[0] + 300, $kick_y) ; kick
					If _Sleep(250) Then ExitLoop

					If GUICtrlRead($chkGtfoNote) = $GUI_CHECKED Then
						Click(430, 150)
						If _Sleep(150) Then ExitLoop
						Local $tClip = ClipGet()
						$chatString = GUICtrlRead($txtGtfoNote)
						ClipPut($chatString)
						_Sleep(150)
						ControlSend($HWnD, "", "", "{CTRLDOWN}a{CTRLUP}{CTRLDOWN}v{CTRLUP}",0)
						_Sleep(150)
						ClipPut($tClip)
					EndIf

					Click(520, 240)
;~ 					If _Sleep(250) Then ExitLoop
					$kicked += 1
					if $mReceived = 999999 Then
						SetLog("Player #" & $sNum & "  Donated : " & $mDonated & " has been kicked out", $COLOR_RED)
					Else
						SetLog("Player #" & $sNum & "  Donated : " & $mDonated &  " - Received : " & $mReceived & " has been kicked out", $COLOR_RED)
					EndIf

					ExitLoop
				Else
					$cp = $new[1]  + 20
;~ 					ExitLoop
				EndIf

			Else
				if $Scroll > 3 then
					If $debugSetlog = 1 Then SetLog("Kicking bottom members", $COLOR_RED)
					If $KickPosX > 0 Then
						If $debugSetlog = 1 Then SetLog($sNum & " # x:" & $KickPosX & " y:"  & $KickPosY, $COLOR_RED)
						Click($KickPosX, $KickPosY)
						If _Sleep(250) Then ExitLoop
						If $KickPosY  > 615 Then
							$kick_y = 700
						Else
							$kick_y = $KickPosY + 70
						EndIf
						Click($KickPosX + 300, $kick_y) ; kick
						If _Sleep(250) Then ExitLoop
						Click(520, 240)
						$kicked += 1
						SetLog("Player #" & $sNum & "  Donated : " & $mDonated &  " - Received : " & $mReceived & " has been kicked out", $COLOR_RED)
					Else
						If $debugSetlog = 1 Then SetLog("no members to kick", $COLOR_RED)
					EndIf
					ExitLoop 2
				Else
					ClickDrag(430,665,430,115)
					$cp = 110
					If $debugSetlog = 1 Then SetLog("Page Scroll : " & $Scroll, $COLOR_RED)
					$Scroll = $Scroll + 1
				EndIf
			EndIf
		WEnd

		Click(1, 40, 1, 250)
   WEnd

;~    SetLog("Finished Kicking", $COLOR_RED)
;~    Click(1, 40, 1, 500)

   EndFunc

Func isImageVisible($sName,$sTile,$sPlace)

	Local $result
	Local $RetunrCoords = ""
	$result = FindImageInPlace($sName,$sTile,$sPlace)
	If $result<>"" Then
		$RetunrCoords = $result
		Return $RetunrCoords
	Else
		Return $RetunrCoords
	EndIF

EndFunc

Func GtfoDonateTroopType($Type, $Quant = 0, $Custom = False, $bDonateAll = False)

	If $debugsetlog = 1 Then SetLog("$DonateTroopType Start: " & NameOfTroop($Type), $COLOR_DEBUG) ;Debug

	Local $Slot = -1, $YComp = 0, $sTextToAll = ""
	Local $detectedSlot = -1
	Local $donaterow = -1 ;( =3 for spells)
	Local $donateposinrow = -1

	If $iTotalDonateCapacity = 0 And $iTotalDonateSpellCapacity = 0 Then Return

	If $Type >= $eBarb And $Type <= $eArch Then
		$iDonTroopsQuantityAv = $iTotalDonateCapacity
		If $iDonTroopsQuantityAv < 1 Then
			SetLog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
			Return
		EndIf
		If $iDonTroopsQuantityAv >= $iDonTroopsLimit Then
			$iDonTroopsQuantity = $iDonTroopsLimit
		Else
			$iDonTroopsQuantity = $iDonTroopsQuantityAv
		EndIf
	EndIf

	If $Type >= $ePSpell And $Type <= $eSkSpell Then
		$iDonSpellsQuantityAv = $iTotalDonateSpellCapacity
		If $iDonSpellsQuantityAv < 1 Then
			SetLog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
			Return
		EndIf
		If $iDonSpellsQuantityAv >= $iDonSpellsLimit Then
			$iDonSpellsQuantity = $iDonSpellsLimit
		Else
			$iDonSpellsQuantity = $iDonSpellsQuantityAv
		EndIf
	EndIf

	If $debugOCRdonate = 1 Then
		Local $oldDebugOcr = $debugOcr
		$debugOcr = 1
	EndIf
	$Slot = DetectSlotTroop($Type)
	$detectedSlot = $Slot
	If $debugsetlog = 1 Then SetLog("Slot Found = " & $Slot, $COLOR_DEBUG)
	If $debugOCRdonate = 1 Then $debugOcr = $oldDebugOcr

	If $Slot = -1 Then Return

	$donaterow = 1
	$donateposinrow = $Slot
	If $Slot >= 6 And $Slot <= 11 Then
		$donaterow = 2
		$Slot = $Slot - 6
		$donateposinrow = $Slot
		$YComp = 88
	EndIf

	If $Slot >= 12 And $Slot <= 14 Then
		$donaterow = 3
		$Slot = $Slot - 12
		$donateposinrow = $Slot
		$YComp = 203
	EndIf

	If $YComp <> 203 Then ; Troops

		If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
				_ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
				_ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then
			Local $plural = 0

			If $iDonTroopsQuantity > 1 Then $plural = 1

			If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
			   _ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
			   _ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then
				Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, $iDonTroopsQuantity, $iDelayDonateCC3, "#0175")
			EndIf

			SetLog("Donating " & $iDonTroopsQuantity & " " & NameOfTroop($Type, $plural) , $COLOR_GREEN)
			$bDonate = True

		ElseIf $DonatePixel[1] - 5 + $YComp > 675 Then
			SetLog("Unable to donate " & NameOfTroop($Type) & ". Donate screen not visible, will retry next run.", $COLOR_RED)
		Else
			SetLog("No " & NameOfTroop($Type) & " available to donate..", $COLOR_RED)
		EndIf


	Else ; spells

		If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x6038B0, 6), 20) Or _
				_ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x6038B0, 6), 20) Or _
				_ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x6038B0, 6), 20) Then

			Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, $iDonSpellsQuantity, $iDelayDonateCC3, "#0600")
			$bFullArmySpells = False
			$fullArmy = False
			SetLog("Donating " & $iDonSpellsQuantity & " " & NameOfTroop($Type) , $COLOR_GREEN)
			$bDonate = True

		ElseIf $DonatePixel[1] - 5 + $YComp > 675 Then
			SetLog("Unable to donate " & NameOfTroop($Type) & ". Donate screen not visible, will retry next run.", $COLOR_RED)
		Else
			SetLog("No " & NameOfTroop($Type) & " available to donate..", $COLOR_RED)
		EndIf
	EndIf

EndFunc   ;==>DonateTroopType

Func GtfoEnableDisable($iFrom, $iTo, $iState)
    For $i = $iFrom To $iTo
        GUICtrlSetState($i, $iState)
    Next
EndFunc

Func GtfoLoadSettings()

	if IniRead($config, "GTFO", "GTFOcheck", 0 ) = 0 Then
		GUICtrlSetState($GTFOcheck ,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($GTFOcheck ,$GUI_CHECKED)
	EndIf
	GTFOcheck()
	GUICtrlSetData($cmbGtfo,IniRead($config, "GTFO", "Kick", "6"))
	if IniRead($config, "GTFO", "MassDonate", 0 ) = 0 Then
		GUICtrlSetState($chkMassDonate,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkMassDonate,$GUI_CHECKED)
	EndIf
	if IniRead($config, "GTFO", "KickMode", 0 ) = 0 Then
		GUICtrlSetState($chkKickMode,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkKickMode,$GUI_CHECKED)
	EndIf
	if IniRead($config, "GTFO", "ClanOpen", 0 ) = 0 Then
		GUICtrlSetState($chkClanOpen,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkClanOpen,$GUI_CHECKED)
	EndIf
	if IniRead($config, "GTFO", "WaitForTroops", 0 ) = 0 Then
		GUICtrlSetState($chkWaitForTroops,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkWaitForTroops,$GUI_CHECKED)
	EndIf
	if IniRead($config, "GTFO", "MassKick", 0 ) = 0 Then
		GUICtrlSetState($chkMassKick,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkMassKick,$GUI_CHECKED)
	EndIf
	MassKick()
	if IniRead($config, "GTFO", "SetTrophies", 0 ) = 0 Then
		GUICtrlSetState($chkSetTrophies,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkSetTrophies,$GUI_CHECKED)
	EndIf
	SetTrophies()

	GUICtrlSetData($cmbGtfoTroop,IniRead($config, "GTFO", "Troop", "Barbarian"))
	GUICtrlSetData($cmbGtfoTroopBoost,IniRead($config, "GTFO", "TroopBoost", "0"))
	GUICtrlSetData($cmbGtfoSpell,IniRead($config, "GTFO", "Spell", "None"))
	GUICtrlSetData($cmbGtfoSpellBoost,IniRead($config, "GTFO", "SpellBoost", "0"))
	GUICtrlSetData($SliderGtfoIdleTime,IniRead($config, "GTFO", "IdleTime", "15"))
	GUICtrlSetData($cmbGtfoDonationCap,IniRead($config, "GTFO", "DonationCap", "5"))
	GUICtrlSetData($cmbGtfoKickCap,IniRead($config, "GTFO", "KickCap", "20"))
	GUICtrlSetData($cmbGtfoTrophies,IniRead($config, "GTFO", "Trophies", "1200"))

	GtfoSetIdleTime()
	if IniRead($config, "GTFO", "Note", 0 ) = 0 Then
		GUICtrlSetState($chkGtfoNote,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkGtfoNote,$GUI_CHECKED)
	EndIf
	GtfoSetKickNote()

	GUICtrlSetData($txtGtfoNote,IniRead($config, "GTFO", "Notes", "Join back later"))
	GUICtrlSetData($txtGtfoChat,IniRead($config, "GTFO", "Chat", "Hello Clan"))

	_GUICtrlListBox_ResetContent($lstGtfoChatTemplates)
	Local $sMsg = IniRead($config, "GTFO", "ChatTemplates", "Hello Clan|Members Don"&Chr(39)&"t Donate|Request and leave")
	if $sMsg = "" then
		$sMsg = "Hello Clan|Members Don"&Chr(39)&"t Donate|Request and leave"
		IniWrite($config, "GTFO", "ChatTemplates", $sMsg)
	EndIf
	GUICtrlSetData($lstGtfoChatTemplates, $sMsg & "|")


	if IniRead($config, "GTFO", "ChatAuto", 0 ) = 0 Then
		GUICtrlSetState($chkGtfoChatAuto,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkGtfoChatAuto,$GUI_CHECKED)
	EndIf
	GtfoAutoChat()
	if IniRead($config, "GTFO", "ChatRandom", 0 ) = 0 Then
		GUICtrlSetState($chkGtfoChatRandom,$GUI_UNCHECKED)
	Else
		GUICtrlSetState($chkGtfoChatRandom,$GUI_CHECKED)
	EndIf


EndFunc

