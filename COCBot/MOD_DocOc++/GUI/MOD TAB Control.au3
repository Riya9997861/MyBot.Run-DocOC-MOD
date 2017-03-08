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
