swt_markers_sys_sendMark = {
	disableSerialization;
	_action = _this select 0;
	_params = _this select 1;
	if (swt_markers_disable) exitWith {systemChat (localize "STR_SWT_M_MESS_DISABLED"); true};

	swt_markers_mark_dir = 0;

	_displayMark = displayNull;
	_displayMap = ({if !(isNull(findDisplay _x)) exitWith {findDisplay _x}} forEach [37,52,53,12]);
	(_displayMap displayCtrl 228) ctrlShow false;
	_text = " " + (if (swt_markers_fast_text_G) then {((str (group player)) call swt_markers_fnc_Group_str) + " "} else {""}) + (if (swt_markers_fast_text_N) then {name player + " "} else {""}) + (if (swt_markers_fast_text_T) then {swt_markers_fast_text_T_saved + " "} else {""});
	_WorldCoord = [];
	_send = [player];
	_channel = "";
	_swtid = "SWT_M#0";
	_go = true;
	switch (swt_markers_channel) do {
		case (localize "str_channel_side"): {
			_channel = "S";
		};

		case (localize "str_channel_command"): {
			_channel = "C";
			if !((leader player == player) or (((effectiveCommander (vehicle player)) == player) and (vehicle player != player))) exitWith {
				_go = false;
				systemChat (localize "STR_SWT_M_NTL");
			}
		};

		case (localize "str_channel_direct"): {
			_channel = "D";
		};

		case (localize "str_channel_global"): {
			_channel = "GL";
		};

		case (localize "str_channel_vehicle"): {
			_channel = "V";
			if (vehicle player == player) exitWith {
				_go = false;
				systemChat (localize "STR_SWT_M_VC");
			};
		};

		case (localize "str_channel_group"): {
			_channel = "GR";
		};

	    default {
	     	_channel = "GR";
	    };
	};

	_coloredName = name player;
	_tag = "%1";
	_coloredName = switch (side player) do {
		case west: {format ["<%2 color='#6495ED'>%1</%2>", _coloredName, _tag]};
		case east: {format ["<%2 color='#E34234'>%1</%2>", _coloredName, _tag]};
		case resistance: {format ["<%2 color='#50C878'>%1</%2>", _coloredName, _tag]};
		case civilian: {format ["<%2 color='#FFED00'>%1</%2>", _coloredName, _tag]};
	};

	if (!_go) exitWith {};

	switch (_action) do {
	    case "mark": {
	    	[0,0] call swt_markers_MapMouseUp;
			_displayMark = _params;
			_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld [((ctrlPosition (_displayMark displayCtrl 204)) select 0)+((ctrlPosition (_displayMark displayCtrl 204)) select 2)/2,((ctrlPosition (_displayMark displayCtrl 204)) select 1)+((ctrlPosition (_displayMark displayCtrl 204)) select 3)/2];
			_text = _text + ctrlText (_displayMark displayctrl 203);

			//FrqMacro addon
			call swt_markers_sys_sendMark_Addon_FrqMacro_main;

			_send set [1,[_swtid,_channel,_text, _WorldCoord, swt_cfgMarkers_names find swt_markers_mark_type, swt_cfgMarkerColors_names find swt_markers_mark_color, swt_markers_mark_dir, sweetk_s, _coloredName]];
			if (!(swt_markers_ctrlState)) then {(_displayMark closeDisplay 0)};
	    };
		case "fast": {
			_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld swt_markers_pos_m;
			if (swt_markers_save_text) then {_text = _text + swt_markers_text};
			_send set [1,[_swtid,_channel,_text,_WorldCoord,swt_cfgMarkers_names find swt_markers_mark_type,swt_cfgMarkerColors_names find swt_markers_mark_color,swt_markers_mark_dir,sweetk_s, _coloredName]];
		};
		case "line": {
		    _send set [1,[_swtid,_channel,"",[(((_params select 0) select 0) + ((_params select 1) select 0))/2,(((_params select 0) select 1) + ((_params select 1) select 1))/2],-2,swt_cfgMarkerColors_names find swt_markers_mark_color,_params select 2,[_params select 3,_params select 4], _coloredName]];
		};
		case "ellipse": {
			_send set [1,[_swtid,_channel,"",[(_params select 0) select 0,(_params select 0) select 1],-3,swt_cfgMarkerColors_names find swt_markers_mark_color,0,[abs(((_params select 1) select 0) - ((_params select 0) select 0)),abs(((_params select 1) select 1) - ((_params select 0) select 1))], _coloredName]];
		};
		case "road": {
			_send set [1,[_swtid,_channel,"",[_params select 0, _params select 1],swt_cfgMarkers_names find swt_markers_mark_type,swt_cfgMarkerColors_names find swt_markers_mark_color,swt_markers_mark_dir,sweetk_s, _coloredName]];
		};
	};

	swt_markers_sys_client_send = _send;
	publicVariableServer "swt_markers_sys_client_send";
	if ((isServer) and !(isMultiplayer)) then {swt_markers_sys_client_send call swt_markers_logicServer_regMark;};
	true
};