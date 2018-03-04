class swt_ButtonResync: swt_ButtonSAVE
{
	idc = 349;
	text = "$STR_SWT_M_RESYNC";
	y = "(10 + 11*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
	colorBackground[]={0.95700002,0,0,0.80000001};
	color[] = {0,0,0,1};
	OnButtonClick = "call swt_markers_resync_markers";
};