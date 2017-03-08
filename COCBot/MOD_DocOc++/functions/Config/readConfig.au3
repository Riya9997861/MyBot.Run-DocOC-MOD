; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ReadConfig_MOD()
	; <><><> DocOc++ Team MOD (NguyenAnhHD, Demen) <><><>
	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	IniReadS($ichkAutoHide, $g_sProfileConfigPath, "general", "AutoHide", 0, "int")
	IniReadS($ichkAutoHideDelay, $g_sProfileConfigPath, "general", "AutoHideDelay", 10, "int")

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	IniReadS($ichkDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", 0, "int")
	IniReadS($iDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", 50, "int")

	; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
	$g_iCmbCSVSpeed[$DB] = Int(IniRead($g_sProfileConfigPath, "DeploymentSpeed", "DB", 2))
	$g_iCmbCSVSpeed[$LB] = Int(IniRead($g_sProfileConfigPath, "DeploymentSpeed", "LB", 2))




EndFunc
