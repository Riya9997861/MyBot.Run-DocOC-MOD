; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
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

Func SaveConfig_MOD()
	; <><><> DocOc++ Team MOD (NguyenAnhHD, Demen) <><><>
	ApplyConfig_MOD("Save")
	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "general", "AutoHide", $ichkAutoHide)
	IniWriteS($g_sProfileConfigPath, "general", "AutoHideDelay", $ichkAutoHideDelay)

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)

	; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "DB", $g_iCmbCSVSpeed[$DB])
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "LB", $g_iCmbCSVSpeed[$LB])




EndFunc
