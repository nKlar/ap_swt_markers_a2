swt_markers_allMarkers = [];
swt_markers_allMarkers_params = [];

swt_markers_getChannel = {
	(swt_markers_allMarkers_params select (swt_markers_allMarkers find _this)) select 1;
};

swt_markers_createMarker = {
	private ["_mark","_params"];
	_params = _this select 0;
	_mark = _params select 0;
	_Chan  = _params select 1;
	_Text  = _params select 2;
	_Pos   = _params select 3;
	_Type  = _params select 4;
	_Color = _params select 5;
	_Dir   = _params select 6;
	_Scale = _params select 7;
	_Name  = _params select 8;
	_Sender = _params select 10;

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

			if(swt_markers_mark_new_mark && (_this select 1)) then
			{
				_mark spawn
				{
					for "_i" from 1 to 10 step 1 do
					{
						_this setMarkerAlphaLocal ([1, 0.5] select (_i%2));
						uisleep 1;
					};
				};
			};

			//FrqParser addon
			call swt_markers_createMarker_Addon_FrqParser_main;

		};
	};
};

swt_markers_logicClient_create = {
	[_this, true] call swt_markers_createMarker;
	["CREATE", _this] call swt_markers_log;
};

swt_markers_logicClient_del = {
	_mark = _this select 0;
	_index = swt_markers_allMarkers find _mark;
	if (_index > -1) then {
		_player = _this select 1;
		deleteMarkerLocal _mark;
		_paramsOut = swt_markers_allMarkers_params select _index;
		//Modifying local data
		swt_markers_allMarkers_params set[_index, "_DELETE_"];
		swt_markers_allMarkers_params = swt_markers_allMarkers_params - ["_DELETE_"];
		swt_markers_allMarkers = swt_markers_allMarkers - [_mark];
		["DEL", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_dir = {
	_mark = _this select 0;
	_index = swt_markers_allMarkers find _mark;
	if (_index > -1) then {
		_dir = _this select 1;
		_player = _this select 2;
		_time = _this select 3;
		_mark setMarkerDirLocal _dir;
		_paramsOut = swt_markers_allMarkers_params select _index;
		(swt_markers_allMarkers_params select _index) set [6,_dir];
		(swt_markers_allMarkers_params select _index) set [9,_time];
		["DIR", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_pos = {
	_mark = _this select 0;
	_index = swt_markers_allMarkers find _mark;
	if (_index > -1) then {
		_pos = _this select 1;
		_player = _this select 2;
		_time = _this select 3;
		_mark setMarkerPosLocal _pos;
		_paramsOut = swt_markers_allMarkers_params select _index;
		(swt_markers_allMarkers_params select _index) set [3,_pos];
		(swt_markers_allMarkers_params select _index) set [9,_time];
		["POS", [name _player, _paramsOut]] call swt_markers_log;
	};
};

swt_markers_logicClient_load = {
	_player = _this select 0;

	{
		[_x, false] call swt_markers_createMarker;
	} forEach (_this select 1);
	["LOAD", [name _player, count (_this select 1)]] call swt_markers_log;
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
			[_x, false] call swt_markers_createMarker;
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