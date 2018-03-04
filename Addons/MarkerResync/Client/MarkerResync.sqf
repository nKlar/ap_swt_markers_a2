swt_markers_canSync = true;

swt_markers_resync_markers = {
	if (swt_markers_canSync) then
	{
		swt_markers_canSync = false;
		{
			deleteMarkerLocal _x;
		} forEach swt_markers_allMarkers;
		swt_markers_allMarkers = [];
		swt_markers_allMarkers_params = [];
		swt_markers_sys_req_markers = player;
		publicVariableServer "swt_markers_sys_req_markers";
		[] spawn
		{
			disableSerialization;
			_timer = 60;
			while {_timer > 0} do
			{
				_ctrl = ((findDisplay 54) displayCtrl 349);
				_ctrl ctrlSetText ((localize "STR_SWT_M_RESYNC") + " (" + str _timer + ")");
				_ctrl ctrlSetBackgroundColor [0.259,0.286,0.286,1];
				_timer = _timer - 1;
				uiSleep 1;
			};
			_ctrl = ((findDisplay 54) displayCtrl 349);
			_ctrl ctrlSetText (localize "STR_SWT_M_RESYNC");
			_ctrl ctrlSetBackgroundColor [0.95700002,0,0,0.80000001];
			swt_markers_canSync = true;
		};
	};
};