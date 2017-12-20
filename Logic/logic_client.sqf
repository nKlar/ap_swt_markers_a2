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

			switch (_typeName) do
			{
				case "swt_dv":
				{
					if !(player diarySubjectExists "SWT_DV") then
					{
						player createDiarySubject ["SWT_DV", localize "STR_SWT_DS_DV"];
					};
					player createDiaryRecord ["SWT_DV", [localize "STR_SWT_DE_FREQ", ([_Text, 1, 25, _Sender] call swt_markers_parse_frequency)]];
				};

				case "swt_kv":
				{
					if !(player diarySubjectExists "SWT_KV") then
					{
						player createDiarySubject ["SWT_KV", localize "STR_SWT_DS_KV"];
					};
					player createDiaryRecord ["SWT_KV", [localize "STR_SWT_DE_FREQ", ([_Text, 30, 512, _Sender] call swt_markers_parse_frequency)]];
				};
			};
		};
	};
};

swt_markers_sys_sendMark = compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\sendMark.sqf';

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

swt_markers_parse_frequency = {
	private["_input","_frqMin","_frqMax","_sender","_arrayInput","_title","_titleReady","_frequencies","_shifts","_isNumber","_blocks","_block","_separator","_prefix","_blockSize","_numberArray","_firstChar","_lastChar","_char","_num","_swt_markers_parse_squad","_parsed"];

	_isNumber =
	{
		(_this >= 48 && _this <= 57);
	};

	_input =  _this select 0;
	_frqMin = _this select 1;
	_frqMax = _this select 2;
	_sender = _this select 3;

	_arrayInput = toArray _input;
	_arrayInput = _arrayInput - [60,62];

	_title = [];
	_titleReady = false;
	_frequencies = [];
	_shifts = [];

	_blocks = [];
	_block = [];
	_separator = [];



//Separating to data blocks
	{
		if((_x in [43,45,44,46]) || (_x call _isNumber) || (_x >= 1025 && _x <= 1105) || (_x >= 65 && _x <= 90) || (_x >= 97 && _x <= 122)) then
		{
			if(count _separator > 0) then
			{
				_blocks set [count _blocks, ["s",_separator]];
				_separator = [];
			};
			_block set [count _block, _x];
		}
		else
		{
			if(count _block > 0) then
			{
				_blocks set [count _blocks, ["b",_block]];
				_block = [];
			};
			_separator set [count _separator, _x];
		}
	} forEach _arrayInput;

	if(count _separator > 0) then
	{
		_blocks set [count _blocks, ["s",_separator]];
		_separator = [];
	};
	if(count _block > 0) then
	{
		_blocks set [count _blocks, ["b",_block]];
		_block = [];
	};


//Parsing
	{
		switch (_x select 0) do
		{
			_block = (_x select 1);
			case "b":
			{
				_prefix = -1;
				_blockSize = (count _block);
				_numberArray = [];
				//if first char is prefix
				if((_block select 0) in [43,45]) then {_prefix = (_block select 0)};
				//if first char is number
				_firstChar = (_block select ([0,1] select(_prefix != -1)));
				if(_firstChar call _isNumber) then
				{
					_numberArray set [count _numberArray, _firstChar];
					//if last char is number
					_lastChar = (_block select (_blockSize-1));
					if(_lastChar call _isNumber) then
					{
						//check if other symbols in block are valid
						for "_i" from ([1,2] select(_prefix != -1)) to _blockSize-2 do
						{
							_char = (_block select _i);
							switch (true) do
							{
								case (_char call _isNumber || _char == 46):
								{
									_numberArray set [count _numberArray, _char];
								};
								case (_char == 44):
								{
									_numberArray set [count _numberArray, 46];
								};
								default
								{
									if(!_titleReady) then
									{
										_title = _title + _block;
									};
									_i = 999;
								};
							};
						};
						_numberArray set [count _numberArray, _lastChar];
						_titleReady = true;

						_num = (floor((parseNumber (toString _numberArray))*1000))/1000;
						if(_prefix != -1) then
						{
							_prefix = toString [_prefix];
							_shifts set[count _shifts, format["%1%2",_prefix,_num]];
							_prefix = -1;
						}
						else
						{
							if(_num >= _frqMin && _num <= _frqMax) then
							{
								_frequencies set[count _frequencies, _num];
							};
						};
					}
					else
					{
						if(!_titleReady) then
						{
							_title = _title + _block;
						};
					};
				}
				else
				{
					if(!_titleReady) then
					{
						_title = _title + _block;
					};
				};
			};

			case "s":
			{
				if(!_titleReady) then
				{
					_title = _title + _block;
				};
			};
		};
	} forEach _blocks;


//Formating
	_swt_markers_parse_squad = {
		private["_name","_array","_srch"];
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


	_parsed = (toString _arrayInput);
	switch (true) do
	{
		case ((group _sender) == (group player)):
		{
			_parsed = format[localize "STR_SWT_MY_GRP", _parsed];
		};

		case (([_sender] call _swt_markers_parse_squad) == ([player] call _swt_markers_parse_squad)):
		{
			_parsed = format[localize "STR_SWT_MY_SQD", _parsed];
		};
	};

	_parsed = _parsed + '<br/>';

	if((count _frequencies) > 0) then
	{
		_parsed = _parsed + format[(localize "STR_SWT_FQ_MAIN"), _frequencies select 0] + '<br/>';
		for [{_i=1},{_i<(count _frequencies)},{_i=_i+1}] do
		{
			_parsed = _parsed + format[(localize "STR_SWT_FQ_N"), _i, _frequencies select _i] + '<br/>';
		};
	};
	if((count _shifts) > 0) then
	{
		for [{_i=0},{_i<(count _shifts)},{_i=_i+1}] do
		{
			_parsed = _parsed + format[(localize "STR_SWT_FQ_ST"), _i+1, _shifts select _i] + '<br/>';
		};
	};
	_parsed;
};

canSync = true;

swt_markers_resync_markers = {
	if (canSync) then
	{
		canSync = false;
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
			canSync = true;
		};
	};
};

canReport = true;

swt_markers_report_bug = {
	if(!isNil "swt_markers_allow_bugreport" && swt_markers_allow_bugreport) then
	{
		if (canReport) then
		{
			canReport = false;

			_name = name player;
			_mission = missionName;

			swt_markers_send_bug_report = [_name,_mission,swt_markers_allMarkers,swt_markers_allMarkers_params];
			publicVariableServer "swt_markers_send_bug_report";

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
				canReport = true;
			};
		};
	}
	else
	{
		hint localize "STR_SWT_M_ALLOWBUGREPORT";
	};
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