swt_markers_allMarkers = [];
swt_markers_allMarkers_params = [];

swt_markers_getChannel = {
	(swt_markers_allMarkers_params select (swt_markers_allMarkers find _this)) select 1;
};

swt_markers_createMarker = {
	private ["_mark","_params"];
	_params = _this;
	_mark = _params select 0;
	_Chan  = _params select 1;
	_Text  = _params select 2;
	_Pos   = _params select 3;
	_Type  = _params select 4;
	_Color = _params select 5;
	_Dir   = _params select 6;
	_Scale = _params select 7;
	_Name  = _params select 8;
	_Sender = _params select 10; //ADDED BY NKLAR

	swt_markers_allMarkers set [count swt_markers_allMarkers,_mark];
	swt_markers_allMarkers_params set [count swt_markers_allMarkers_params, _params];

	_mark = createMarkerLocal [_mark,_Pos];

	_mark setMarkerColorLocal (swt_cfgMarkerColors_names select _Color);
	_mark setMarkerDirLocal _Dir;

	if (_Type == -2) then {
		_mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
		_mark setMarkerBrushLocal "Solid";
		_mark setMarkerShapeLocal "RECTANGLE";
	} else {
		if (_Type == -3) then {
		    _mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
			_mark setMarkerBrushLocal "Solid";
			_mark setMarkerShapeLocal "ELLIPSE";
		} else {
			_typeName = swt_cfgMarkers_names select _Type;
			_mark setMarkerTypeLocal _typeName;
			_mark setMarkerTextLocal _Text;
			_mark setMarkerSizeLocal [_Scale,_Scale];
			switch (_typeName) do
			{
				case "nm_dv":
				{
					if !(player diarySubjectExists "NK_DV") then
					{
						player createDiarySubject ["NK_DV", localize "STR_NK_DV"];
					};
					player createDiaryRecord ["NK_DV", [localize "STR_NK_FREQ", ([_Text, 1, 25, _Sender] call nk_swt_markers_parse_frequency)]];
				};

				case "nm_kv":
				{
					if !(player diarySubjectExists "NK_KV") then
					{
						player createDiarySubject ["NK_KV", localize "STR_NK_KV"];
					};
					player createDiaryRecord ["NK_KV", [localize "STR_NK_FREQ", ([_Text, 30, 512, _Sender] call nk_swt_markers_parse_frequency)]];
				};
			};
		};
	};
};

swt_markers_sys_sendMark = compile preprocessFileLineNumbers '\swt_markers\Logic\sendMark.sqf';

swt_markers_logicClient_create = {
	_this call swt_markers_createMarker;
	["CREATE", _this] call swt_markers_log;
};

swt_markers_logicClient_del = {
	_mark = _this select 0;
	if (_mark in swt_markers_allMarkers) then {
		_player = _this select 1;
		deleteMarkerLocal _mark;
		_paramsOut = [];
		//Modifying local data
		{
			if (_x select 0 == _mark) exitWith {
				_paramsOut = _x;
				swt_markers_allMarkers_params set[_forEachIndex, "_DELETE_"];
				swt_markers_allMarkers_params = swt_markers_allMarkers_params - ["_DELETE_"];
			};
		} forEach swt_markers_allMarkers_params;
		swt_markers_allMarkers = swt_markers_allMarkers - [_mark];
		["DEL", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_dir = {
	_mark = _this select 0;
	if (_mark in swt_markers_allMarkers) then {
		_dir = _this select 1;
		_player = _this select 2;
		_mark setMarkerDirLocal _dir;
		_paramsOut = [];
		{
			if (_x select 0 == _mark) exitWith {
				_x set [6,_dir];
				_paramsOut = _x;
			};
		} forEach swt_markers_allMarkers_params;
		["DIR", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_pos = {
	_mark = _this select 0;
	if (_mark in swt_markers_allMarkers) then {
		_pos = _this select 1;
		_player = _this select 2;
		_mark setMarkerPosLocal _pos;
		_paramsOut = [];
		{
			if (_x select 0 == _mark) exitWith {
				_x set [3,_pos];
				_paramsOut = _x;
			};
		} forEach swt_markers_allMarkers_params;
		["POS", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_load = {
	_player = _this select 0;

	{
		_x call swt_markers_createMarker;
	} forEach (_this select 1);
	["LOAD", [name _player, count (_this select 1)]] call swt_markers_log;
};

swt_markers_clear_map = {
	{
		deleteMarkerLocal _x;
	} forEach swt_markers_allMarkers;
	swt_markers_allMarkers = [];
	swt_markers_allMarkers_params = [];
};


nk_swt_markers_parse_frequency = {
	private["_text", "_array", "_min", "_max", "_title", "_frequencies", "_shifts", "_arrayDouble", "_i", "_titleReady", "_prefix", "_Sender"];
	_text = _this select 0;
	_array = toArray _text;
	_array = _array - [60,62];
	_min = _this select 1;
	_max = _this select 2;
	_Sender = _this select 3;

	_title = [];
	_frequencies = [];
	_shifts = [];
	_arrayDouble = [];
	_i = 0;
	_titleReady = false;
	_prefix = -1;

	while{(_i < (count _array))} do
	{
		_char = (_array select _i);
		if(_char >= 48 && _char <= 57) then
		{
			while {(_char >= 48 && _char <= 57) || (_char in [44,46])} do
			{
				if(_char == 44) then {_char = _char + 2;};
				_arrayDouble set [count _arrayDouble, _char];
				_i = _i + 1;
				_char = (_array select _i);
			};
			_stringDouble = toString _arrayDouble;
			_double = parseNumber _stringDouble;
			if(_prefix != -1) then
			{
				_prefix = toString [_prefix];
				_shifts set[count _shifts, format["%1%2",_prefix,_double]];
				_prefix = -1;
			}
			else
			{
				if(_double >= _min && _double <= _max) then
				{
					_frequencies set[count _frequencies, _double];
					_titleReady = true;
				};
			};

			if(!_titleReady) then
			{
				_title = _title + _arrayDouble;
			};
			_arrayDouble = [];
		}
		else
		{
			switch (true) do
			{
				case (_char in [43,45]):
				{
					_prefix = _char;
				};

				case (_char != 32):
				{
					_prefix = -1;
				};
			};
			if(!_titleReady) then
			{
				_title set [count _title, _char];
			};
			_i = _i + 1;
		}
	};

	_parsed = (toString _array);
	switch (true) do
	{
		case ((group _Sender) == (group player)):
		{
			_parsed = format[localize "STR_NK_MY_GRP", _parsed];
		};

		case (([_Sender] call nk_swt_markers_parse_squad) == ([player] call nk_swt_markers_parse_squad)):
		{
			_parsed = format[localize "STR_NK_MY_SQD", _parsed];
		};
	};

	_parsed = _parsed + '<br/>';

	if((count _frequencies) > 0) then
	{
		_parsed = _parsed + format[(localize "STR_NK_FQ_MAIN"), _frequencies select 0] + '<br/>';
		for [{_i=1},{_i<(count _frequencies)},{_i=_i+1}] do
		{
			_parsed = _parsed + format[(localize "STR_NK_FQ_N"), _i, _frequencies select _i] + '<br/>';
		};
	};
	if((count _shifts) > 0) then
	{
		for [{_i=0},{_i<(count _shifts)},{_i=_i+1}] do
		{
			_parsed = _parsed + format[(localize "STR_NK_FQ_ST"), _i+1, _shifts select _i] + '<br/>';
		};
	};
	_parsed;
};

nk_swt_markers_parse_squad = {
	_name = name (_this select 0);
	_array = toArray(_name);
	_srch = _array find 93;
	if(_srch != -1) then
	{
		_array resize (_srch);
		_array = _array - [91];
	};

	(toString _array);
};

[] spawn {
	"swt_markers_send_mark"  addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicClient_create;
	};
	"swt_markers_send_del" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicClient_del;
	};
	"swt_markers_send_dir" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicClient_dir;
	};
	"swt_markers_send_pos" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicClient_pos;
	};
	"swt_markers_send_JIP" addPublicVariableEventHandler {
		_markers = _this select 1;
		{
			_x call swt_markers_createMarker;
		} forEach (_markers);
	};

	"swt_markers_send_load" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicClient_load;
	};

	waitUntil {!isNull player};
	swt_markers_sys_req_markers = player;
	publicVariableServer "swt_markers_sys_req_markers";
	player createDiarySubject ["SwtMarkersLog", localize "STR_SWT_MARKERS"];
	player createDiaryRecord ["SwtMarkersLog", [localize "STR_SWT_M_A", localize "STR_SWT_M_ATXT"]];
	player createDiaryRecord ["SwtMarkersLog", [localize "STR_SWT_M_SET", localize "STR_SWT_M_SETTXT"]];
	player createDiaryRecord ["SwtMarkersLog", [localize "STR_SWT_M_INFO", localize "STR_SWT_M_INFOTXT"]];
};