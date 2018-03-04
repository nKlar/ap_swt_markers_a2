swt_markers_canReport = true;

swt_markers_report_bug = {
	if(!isNil "swt_markers_allow_bugreport" && swt_markers_allow_bugreport) then
	{
		if (swt_markers_canReport) then
		{
			swt_markers_canReport = false;

			if(!isNil "swt_markers_client_bugreport_fnc") then {
				//Code from server

				call swt_markers_client_bugreport_fnc;

				//Code from server end
			};

			[] spawn
			{
				disableSerialization;
				_timer = 60*10;
				while {_timer > 0} do
				{
					_ctrl = ((findDisplay 54) displayCtrl 350);
					_ctrl ctrlSetText ((localize "STR_SWT_M_BUGREPORT") + " (" + str _timer + ")");
					_ctrl ctrlSetBackgroundColor [0.259,0.286,0.286,1];
					_timer = _timer - 1;
					uiSleep 1;
				};
				_ctrl = ((findDisplay 54) displayCtrl 350);
				_ctrl ctrlSetText (localize "STR_SWT_M_BUGREPORT");
				_ctrl ctrlSetBackgroundColor [0.95700002,0,0,0.80000001];
				swt_markers_canReport = true;
			};
		};
	}
	else
	{
		hint localize "STR_SWT_M_ALLOWBUGREPORT";
	};
};