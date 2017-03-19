; #FUNCTION# ====================================================================================================================
; Name ..........: MBR Global Variables for DocOC++ Team
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD, Demen
; Modified ......: Everyone all the time  :)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
Global $ichkAutoHide, $ichkAutoHideDelay = 10

; Check Collector Outside (McSlither) - Added by NguyenAnhHD
#region Check Collectors Outside
; Collectors outside filter
Global $ichkDBMeetCollOutside, $iDBMinCollOutsidePercent, $iCollOutsidePercent ; check later if $iCollOutsidePercent obsolete

; constants
Global Const $THEllipseWidth = 200, $THEllipseHeigth = 150, $CollectorsEllipseWidth = 130, $CollectorsEllipseHeigth = 97.5
Global Const $centerX = 430, $centerY = 335 ; check later if $THEllipseWidth, $THEllipseHeigth obsolete
Global $hBitmapFirst
#endregion

; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
Global $g_hCmbCSVSpeed[2] = [$LB, $DB]
Global $g_iCmbCSVSpeed[2] = [$LB, $DB]
Global $g_hDivider

; SmartUpgrade (Roro-Titi) - Added by NguyenAnhHD
Global $ichkSmartUpgrade
Global $ichkIgnoreTH, $ichkIgnoreKing, $ichkIgnoreQueen, $ichkIgnoreWarden, $ichkIgnoreCC, $ichkIgnoreLab
Global $ichkIgnoreBarrack, $ichkIgnoreDBarrack, $ichkIgnoreFactory, $ichkIgnoreDFactory, $ichkIgnoreGColl, $ichkIgnoreEColl, $ichkIgnoreDColl
Global $iSmartMinGold, $iSmartMinElixir, $iSmartMinDark
Global $sBldgText, $sBldgLevel, $aString
Global $upgradeName[3] = ["", "", ""]
Global $UpgradeCost
Global $TypeFound = 0
Global $UpgradeDuration
Global $canContinueLoop = True

; SwitchAcc_Demen_Style
Global $profile = $g_sProfilePath & "\Profile.ini"
Global $iSwitchAccStyle = 1	; 1 = DocOc, 2 = Demen
Global $ichkSwitchAcc = 0, $ichkTrain = 0, $icmbTotalCoCAcc, $nTotalCoCAcc = 8, $ichkSmartSwitch, $ichkCloseTraining
Global Enum $eNull, $eActive, $eDonate, $eIdle, $eStay, $eContinuous	; Enum for Profile Type & Switch Case & ForceSwitch
Global $ichkForceSwitch, $iForceSwitch, $eForceSwitch = 0, $iProfileBeforeForceSwitch
Global $ichkForceStayDonate
Global $nTotalProfile = 1, $nCurProfile = 1, $nNextProfile
Global $ProfileList
Global $aProfileType[8]		; Type of the all Profiles, 1 = active, 2 = donate, 3 = idle
Global $aMatchProfileAcc[8]	; Accounts match with All Profiles
Global $aDonateProfile, $aActiveProfile
Global $aAttackedCountSwitch[8], $ActiveSwitchCounter = 0, $DonateSwitchCounter = 0
Global $bReMatchAcc = False
Global $aTimerStart[8], $aTimerEnd[8]
Global $aRemainTrainTime[8], $aUpdateRemainTrainTime[8], $nMinRemainTrain
Global $aLocateAccConfig[8], $aAccPosY[8]

; SimpleTrain (Demen) - Added by Demen
Global $ichkSimpleTrain,  $ichkPreciseTroops, $ichkFillArcher, $iFillArcher, $ichkFillEQ

; Switch Profile (IceCube) - Added by NguyenAnhHD
Global $profileString = ""
Global $ichkGoldSwitchMax, $itxtMaxGoldAmount, $icmbGoldMaxProfile, $ichkGoldSwitchMin, $itxtMinGoldAmount, $icmbGoldMinProfile
Global $ichkElixirSwitchMax, $itxtMaxElixirAmount, $icmbElixirMaxProfile, $ichkElixirSwitchMin, $itxtMinElixirAmount, $icmbElixirMinProfile
Global $ichkDESwitchMax, $itxtMaxDEAmount, $icmbDEMaxProfile, $ichkDESwitchMin, $itxtMinDEAmount, $icmbDEMinProfile
Global $ichkTrophySwitchMax, $itxtMaxTrophyAmount, $icmbTrophyMaxProfile, $ichkTrophySwitchMin, $itxtMinTrophyAmount, $icmbTrophyMinProfile

; CoCStats - Added by NguyenAnhHD
Global $ichkCoCStats = 0
Global $MyApiKey = ""

; Upgrade Management (MMHK) - Added by NguyenAnhHD
Global $g_ibUpdateNewUpgradesOnly = False
Global Const $UP = True, $DOWN = False, $TILL_END = True

; GTFO
Global $DonationWindowY, $bDonate
Global $iTotalDonateCapacity, $iTotalDonateSpellCapacity
Global $iDonTroopsLimit, $iDonSpellsLimit, $iDonTroopsAv, $iDonSpellsAv
Global $iDonTroopsQuantityAv, $iDonTroopsQuantity, $iDonSpellsQuantityAv, $iDonSpellsQuantity
Global $bSkipDonTroops, $bSkipDonSpells
Global $GTFOCheck, $hGUI_DONATE, $hGUI_GTFOMode, $grpGTFO, $cmbGTFO, $g_hBtnGTFOStart, $g_hBtnGTFOPause, $g_hBtnGTFOStop, $chkMassDonate, $chkClanOpen, $chkWaitForTroops, $chkGTFOStats
Global $cmbGTFOTroop, $cmbGTFOTroopBoost, $cmbGTFOSpell, $cmbGTFOSpellBoost, $chkGTFOProfileSwitch, $cmbGTFOProfiles, $btnGTFOProfileAdd
Global $btnGtfoProfileRemove, $SliderGtfoIdleTime, $chkGtfoNote, $txtGtfoNote, $chkGtfoClip, $txtGtfoChat, $btnGtfoSendChat, $lstGtfoChatTemplates
Global $btnGtfoChatAdd, $btnGtfoChatRemove, $chkGtfoChatAuto, $chkGtfoChatRandom, $lblGtfoTroop, $lblGtfoHelp, $lblGtfoIdle, $lblGtfoSpell
Global $lblGtfoTroopBoost, $lblGtfoChat, $lblGtfoSpellBoost, $lblKick, $txtGtfoIdleTime, $chkChatStatus
Global $lblStartXp, $lblCurrentXP,$lblStartXpVal, $lblCurrentXPVal, $lblGtfoDonationCap,$lblGtfoKickCap
Global Enum $GtfoIdle, $GtfoStart, $GtfoPause , $GtfoResume , $GtfoStop
Global $GtfoModStatus = $GtfoIdle
Global $GtfoTroopType, $GtfoSpellType, $GtfoChatCount = 0
Global $GtfoHours = 0, $GtfoMins = 0, $GtfoSecs = 0, $GtfoTroopTrainCount = 0, $GtfoSpellBrewCount = 0
Global $GtfoIdleTime = 15, $GtfoReceiveCap = 0, $GtfoDonationCap = 0 , $GtfoTopEnd = -1, $GtfoMassKickMode = False
Global $aIsGoldBar[4] = [822,22,0xFFF448, 20]
Global $aIsElixirBar[4] = [822,72,0x761476, 20]
Global $sLastkickedFile = "lastkicked_0_0_85.png"
Global $aGtfoCanTrophies[37] = [0,200,400,600,800,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,3000,3100,3200,3300,3400,3500,3600,3700,3800,3900,4000,4100,4200]
Global $bSetTrophies = False, $aUpdateTrophies = -1, $currClanTrophies = -1
