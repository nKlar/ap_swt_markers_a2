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


if (!_go) exitWith {};

_swt_fnc_macroGenerateFrqs = {
	private ["_times","_return","_separator"];
	_times = [10, _this select 0] select ((_this select 0)<10);
	_return = "";
	_separator = " ";
	if(!isNil{_this select 1}) then
	{
		_separator = _this select 1;
	};

	switch (swt_markers_mark_type) do
	{
		case "swt_kv":
		{
			for "_i" from 1 to _times-1 step 1 do
			{
				_return = _return + str([([30,512] call BIS_fnc_randomNum), 3] call BIS_fnc_cutDecimals) + _separator;
			};
			_return = _return + str([([30,512] call BIS_fnc_randomNum), 3] call BIS_fnc_cutDecimals);
		};
		case "swt_dv":
		{
			for "_i" from 1 to _times-1 step 1 do
			{
				_return = _return + str([([1,25] call BIS_fnc_randomNum), 3] call BIS_fnc_cutDecimals) + _separator;
			};
			_return = _return + str([([1,25] call BIS_fnc_randomNum), 3] call BIS_fnc_cutDecimals);
		};
	};

	_return;
};

_swt_fnc_processMacro = {
	private ["_macro","_return"];
	_macro = _this;
	_return = "";
	try
	{
		_macro = call compile ("[]+" + _macro + "+[]");
		switch (count _macro) do
		{
			case 1:
			{
				if(typeName(_macro select 0) == 'SCALAR') then
				{
					_return = ([round(_macro select 0)] call _swt_fnc_macroGenerateFrqs);
				};
			};

			case 2:
			{
				if(typeName(_macro select 0) == 'SCALAR' && typeName(_macro select 1) == 'STRING') then
				{
					_return = ([round(_macro select 0), (_macro select 1)] call _swt_fnc_macroGenerateFrqs);
				};
			};
		};
	}
	catch
	{
		_return = "";
	};
	_return;
};

//${6,' // '} = [6,' // ']
_swt_fnc_processMacros = {
	private ["_text","_return","_arrayText","_macroControl","_macroStart","_macro"];
	_text = _this;
	_return = [];

	_arrayText = toArray _text;

	_macroControl = false;
	_macroStart = false;
	_macro = [];

	if(( _arrayText find 36) == -1) exitWith {_text};

	{
		switch (_x) do
		{
			case 36: //$
			{
				_macroControl = true;
			};
			case 123: //{
			{
				if(_macroControl) then
				{
					_macroStart = true;
					_macro set [count _macro,91]; //[
				}
				else
				{
					_return set [count _return,_x];
				};
			};
			case 125: //}
			{
				if(_macroStart) then
				{
					_macro set [count _macro,93]; //]
					_macroStart = false;
					_macroControl = false;
					_macro = _macro - [59];
					_macro = toString _macro;
					_macro = _macro call _swt_fnc_processMacro;
					_return = _return + (toArray _macro);
					_macro = [];
				}
				else
				{
					_return set [count _return,_x];
				};
			};
			default
			{
				if(_macroControl && _macroStart) then
				{
					_macro set [count _macro,_x];
				}
				else
				{
					if(_macroControl) then {
						_return set [count _return,36];
						_macroControl = false;
					};
					_return set [count _return,_x];
				};
			};
		};
	} forEach _arrayText;

	toString _return;
};


switch (_action) do {
    case "mark": {
    	[0,0] call swt_markers_MapMouseUp;
		_displayMark = _params;
		_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld [((ctrlPosition (_displayMark displayCtrl 204)) select 0)+((ctrlPosition (_displayMark displayCtrl 204)) select 2)/2,((ctrlPosition (_displayMark displayCtrl 204)) select 1)+((ctrlPosition (_displayMark displayCtrl 204)) select 3)/2];
		_text = _text + ctrlText (_displayMark displayctrl 203);

		if (swt_markers_mark_type in ["swt_kv", "swt_dv"]) then
		{
			_text = _text call _swt_fnc_processMacros;
		};

		_send set [1,[_swtid,_channel,_text, _WorldCoord, swt_cfgMarkers_names find swt_markers_mark_type, swt_cfgMarkerColors_names find swt_markers_mark_color, swt_markers_mark_dir, sweetk_s, name player]];
		if (!(swt_markers_ctrlState)) then {(_displayMark closeDisplay 0)};
    };
	case "fast": {
		_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld swt_markers_pos_m;
		if (swt_markers_save_text) then {_text = _text + swt_markers_text};
		_send set [1,[_swtid,_channel,_text,_WorldCoord,swt_cfgMarkers_names find swt_markers_mark_type,swt_cfgMarkerColors_names find swt_markers_mark_color,swt_markers_mark_dir,sweetk_s, name player]];
	};
	case "line": {
	    _send set [1,[_swtid,_channel,"",[(((_params select 0) select 0) + ((_params select 1) select 0))/2,(((_params select 0) select 1) + ((_params select 1) select 1))/2],-2,swt_cfgMarkerColors_names find swt_markers_mark_color,_params select 2,[_params select 3,_params select 4], name player]];
	};
	case "ellipse": {
		_send set [1,[_swtid,_channel,"",[(_params select 0) select 0,(_params select 0) select 1],-3,swt_cfgMarkerColors_names find swt_markers_mark_color,0,[abs(((_params select 1) select 0) - ((_params select 0) select 0)),abs(((_params select 1) select 1) - ((_params select 0) select 1))], name player]];
	};
	case "road": {
		_send set [1,[_swtid,_channel,"",[_params select 0, _params select 1],swt_cfgMarkers_names find swt_markers_mark_type,swt_cfgMarkerColors_names find swt_markers_mark_color,swt_markers_mark_dir,sweetk_s, name player]];
	};
};

swt_markers_sys_client_send = _send;
publicVariableServer "swt_markers_sys_client_send";
if ((isServer) and !(isMultiplayer)) then {swt_markers_sys_client_send call swt_markers_logicServer_regMark;};
true
