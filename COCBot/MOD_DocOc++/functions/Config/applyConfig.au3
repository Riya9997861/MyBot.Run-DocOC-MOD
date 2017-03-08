; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ApplyConfig_MOD($TypeReadSave)
	; <><><> DocOc++ Team MOD (NguyenAnhHD, Demen) <><><>
	Switch $TypeReadSave
		Case "Read"
			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkAutohide, $ichkAutoHide = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAutohideDelay, $ichkAutoHideDelay)
			chkAutoHide()

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkDBMeetCollOutside, $ichkDBMeetCollOutside = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $iDBMinCollOutsidePercent)
			chkDBMeetCollOutside()

			; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$DB], $g_iCmbCSVSpeed[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$LB], $g_iCmbCSVSpeed[$LB])


		Case "Save"
			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			$ichkAutoHide = GUICtrlRead($g_hChkAutohide) = $GUI_CHECKED ? 1 : 0
			$ichkAutoHideDelay = GUICtrlRead($g_hTxtAutohideDelay)

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			$ichkDBMeetCollOutside = GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED ? 1 : 0
			$iDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent)

			; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
			$g_iCmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB])
			$g_iCmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB])



	EndSwitch
EndFunc

