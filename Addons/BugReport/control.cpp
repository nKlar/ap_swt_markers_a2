class swt_ButtonBugReport: swt_ButtonSAVE
{
	idc = 350;
	text = "$STR_SWT_M_BUGREPORT";
	y = "(11 + 12*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
	colorBackground[]={0.95700002,0,0,0.80000001};
	color[] = {0,0,0,1};
	OnButtonClick = "call swt_markers_report_bug";
};