; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
Func chkAutoHide()
	GUICtrlSetState($g_hTxtAutohideDelay, GUICtrlRead($g_hChkAutoHide) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkAutoHide

; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
Func cmbCSVSpeed()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$g_iMatchMode])
		Case 0
			$g_hDivider = 0.5
		Case 1
			$g_hDivider = 0.75
		Case 2
			$g_hDivider = 1
		Case 3
			$g_hDivider = 1.25
		Case 4
			$g_hDivider = 1.5
		Case 5
			$g_hDivider = 2
		Case 6
			$g_hDivider = 3
	EndSwitch

EndFunc   ;==>cmbCSVSpeed

; Attack Now Button MR.ViPeR) - Added by NguyenAnhHD
Func AttackNowLB()
	SetLog("Begin Live Base Attack TEST")
	$g_iMatchMode = $LB			; Select Live Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$LB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$LB] = GuiCtrlRead($g_hCmbScriptNameAB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 1			; Select Live Base As Attack Type
	$g_bRunState = True

	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Live Base Attack TEST")
EndFunc   ;==>AttackNowLB

Func AttackNowDB()
	SetLog("Begin Dead Base Attack TEST")
	$g_iMatchMode = $DB			; Select Dead Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$DB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$DB] = GuiCtrlRead($g_hCmbScriptNameDB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 0			; Select Dead Base As Attack Type
	$g_bRunState = True
	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Dead Base Attack TEST")
EndFunc   ;==>AttackNowLB


