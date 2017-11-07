diag_log "AP SWT MARKERS SERVER VERSION";
swt_markers_count = 0;
swt_markers_isPlayer_bug = [];
{
	missionNamespace setVariable ['swt_markers_logicServer_'+_x,[]];
} forEach ["S","S2","C","GL","V","GR","D"];

// callbacks: swt_markers_send_JIP  swt_markers_send_mark swt_markers_send_dir swt_markers_send_del swt_marker_send_load

swt_markers_logicServer_regMark = {
	private ["_mark"];

	_fnc_areFriendly = {
		private ["_sideA","_sideB"];

		_sideA = _this select 0;
		_sideB = _this select 1;
		if (_sideA in [civilian,sidelogic] || _sideB in [civilian,sidelogic]) then {
			true
		} else {
			private ["_conflictLimit"];
			_conflictLimit = 0.6;
			if	(_sideA getfriend _sideB >= _conflictLimit && _sideB getfriend _sideA >= _conflictLimit) then {true} else {false};
		};
	};

	_addToChannel = {
		private ["_mark"];
		_channelData = _this select 0;
		_channelData = missionNamespace getVariable ("swt_markers_logicServer_" + _channelData);
		_channelUnit = _this select 1;
		_mark = _this select 2;
		if (_channelData find _channelUnit == -1) then {
			_channelData set [count _channelData, _channelUnit];
			_channelData set [count _channelData, [_mark]];
    	} else {
    		_set_arr = (_channelData select ((_channelData find _channelUnit) + 1));
    		_set_arr set [count _set_arr, _mark];
    	};
	};

	_player = _this select 0;
	_mark = _this select 1;
	_channel = _mark select 1;
	_mark set [count _mark, time];
	_mark set [count _mark, _player];
	swt_markers_count = swt_markers_count + 1;
	_mark set [0, "SWT_M#"+ str swt_markers_count]; // BAD
	swt_markers_send_mark = _mark;
	_cond = "";
	_units = [];

	switch (_channel) do {
	    case "S": {
	    	_cond = "(side _x == side _player)";
	    	[_channel, side _player, _mark] call _addToChannel;
	    	_units = (playableUnits+switchableUnits);
	    };
	    case "C": {
	    	_cond = "((((leader _x == _x) or (((effectiveCommander (vehicle _x)) == _x) and (vehicle _x != _x))) and (side _x == side _player)) or (_player == _x))";
	    	[_channel, side _player, _mark] call _addToChannel;
	    	_units = (playableUnits+switchableUnits);
	    };
	    case "GL": {
	    	_cond = "true";
	    	swt_markers_logicServer_GL set [count swt_markers_logicServer_GL, _mark];
	    	_units = (playableUnits+switchableUnits);
	    };
	    case "V": {
	    	_cond = "(_x in vehicle _player)";
	    	[_channel, vehicle _player, _mark] call _addToChannel;
	    	_units = (playableUnits+switchableUnits);
	    };
	    case "GR": {
	    	_cond = "(group _x == group _player)";
	    	[_channel, group _player, _mark] call _addToChannel;
	    	_units = units group _player;
	    };
	    case "D": {
	    	_cond = "(_x distance _player < 15)";
	    	_units = (playableUnits+switchableUnits);
	    };
	};


	{
		if (isPlayer _x or {time==0 and {_player in swt_markers_isPlayer_bug}}) then {
			_cond_x = call compile _cond;
			if _cond_x then {
				(owner _x) publicVariableClient "swt_markers_send_mark";
				if (!isMultiplayer and {_x == player}) then {swt_markers_send_mark call swt_markers_logicClient_create};
			};
		};
	} forEach _units;
};

swt_markers_logicServer_req_markers = {
	_player = _this;
	if (!isPlayer _player) then {
		if (swt_markers_isPlayer_bug find _player == -1) then {
			swt_markers_isPlayer_bug set [count swt_markers_isPlayer_bug, _player];
		};
	};
	_addMarkers = {
		_channelUnit = _this;
		_num = _channelData find _channelUnit;
    	if (_num != -1) then {
    		[swt_markers_send_JIP, (_channelData select (_num + 1))] call BIS_fnc_arrayPushStack;
    	};
	};

	swt_markers_send_JIP = [];
	{
		_channelData = missionNamespace getVariable ("swt_markers_logicServer_" + _x);
		if !(count _channelData == 0) then {
			switch _x do {
			    case "S": {
			    	(side _player) call _addMarkers;
			    };
			    case "C": {
			    	if ((leader _player == _player) or (((effectiveCommander (vehicle _player)) == _player) and (vehicle _player != _player))) then {
			    		(side _player) call _addMarkers;
			    	};
			    };
			    case "GL": {
			    	[swt_markers_send_JIP,_channelData] call BIS_fnc_arrayPushStack;
			    };
			    case "V": {
				    if (vehicle _player != _player) then {
				    	(vehicle _player) call _addMarkers;
				    };
			    };
			    case "GR": {
			    	(group _player) call _addMarkers;

			    };
			    /*case "DIRECT": {

			    };*/
			};
		};
	} forEach ["S","S2","C","GL","V","GR"];
	if(count swt_markers_send_JIP > 0)
	{
		(owner _player) publicVariableClient "swt_markers_send_JIP";
	};
};

swt_markers_logicServer_change_mark = {
	//Only creator can change marker
	private ["_pos","_dir"];
	_processMarker = {
		_action = _this select 0;
		_markParams = _this select 1;
		_arr = _this select 2;
		_index = _this select 3;
		_arrIndex = _this select 4;
		switch (toUpper _action) do {
		    case "DIR": {
		    	_markParams set [6,_dir];
		    	_markParams set [9,time];
		    };

		    case "DEL": {
		    	_arr set [_index, "_DELETE_"];
		    	_arr = _arr - ["_DELETE_"];
		    	_channelData set [_arrIndex, _arr];
		    };

			case "POS": {
			    _markParams set [3,_pos];
			    _markParams set [9,time];
			};
		};
	};


	_find_changeMarkers = {
		private ['_find'];
		_channelUnit = _this;
		_find = false;
		_num = _channelData find _channelUnit;

    	if (_num != -1) then {
    		{
    			if (_x select 0 == _mark_id) exitWith {
					[_action, _x, _channelData select (_num + 1), _forEachIndex, (_num + 1)] call _processMarker;
					_find = true;
				};
    		} forEach (_channelData select (_num + 1));
    	};

    	if (!_find) then {
    		for [{_i=1}, {_i<(count _channelData)&&!_find},{_i=_i+2}] do {
    			{
    				if (_x select 0 == _mark_id) exitWith {
						[_action, _x, (_channelData select _i), _forEachIndex, _i] call _processMarker;
						_find = true;
					};
    			} forEach (_channelData select _i);
    		};
    	};
    	if (!_find) then {diag_log "SWT MARKERS: CHANGE MARKER FAIL, CAN'T FIND DATA";};
	};

	_action = _this select 0;
	_player = _this select 1;
	_mark_id = _this select 2;
	_channel = _this select 3;
	_dir = 0;
	_pos = [];

	switch (_action) do {
	    case "DIR": {
	    	_dir = _this select 4;
	    	swt_markers_send_dir = [_mark_id,_dir,_player, time];
			publicVariable "swt_markers_send_dir";
			if (hasInterface) then {swt_markers_send_dir call swt_markers_logicClient_dir};
	    };

	     case "DEL": {
	    	swt_markers_send_del = [_mark_id,_player];
			publicVariable "swt_markers_send_del";
			if (hasInterface) then {swt_markers_send_del call swt_markers_logicClient_del};
	    };

		case "POS": {
			_pos = _this select 4;
		   swt_markers_send_pos = [_mark_id,_pos,_player, time];
		   publicVariable "swt_markers_send_pos";
		   if (hasInterface) then {swt_markers_send_pos call swt_markers_logicClient_pos};
	   };
	};


	_channelData = missionNamespace getVariable ("swt_markers_logicServer_" + _channel);

	if !(count _channelData == 0) then {
		switch _channel do {
		    case "S": {
		    	(side _player) call _find_changeMarkers;
		    };
		    case "C": {
		    	(side _player) call _find_changeMarkers;
		    };
		    case "V": {
		    	(vehicle _player) call _find_changeMarkers;
		    };
		    case "GR": {
		    	(group _player) call _find_changeMarkers;
		    };
		    case "D": {
		    	//
		    };
		    case "GL": {
		    	{
					if (_x select 0 == _mark_id) exitWith {
						[_action, _x, _channelData, _forEachIndex] call _processMarker;
					};
				} forEach _channelData;
		    };
		};
	};
};

swt_markers_logicServer_load = {
	_player = _this select 0;
	_data = _this select 1;
	{
		swt_markers_count = swt_markers_count + 1;
		_x set [0, "SWT_M_L#"+ str swt_markers_count];
		_x set [1, "S"];
		_x set [count _x, (name _player)];
		_x set [count _x, time];
		_x set [count _x, _player];
		_x set [count _x, true]; //means loaded
	} forEach _data;

	if (swt_markers_logicServer_S find (side _player) == -1) then {
		swt_markers_logicServer_S set [count swt_markers_logicServer_S, (side _player)];
		swt_markers_logicServer_S set [count swt_markers_logicServer_S, _data];
	} else {
		[(swt_markers_logicServer_S select ((swt_markers_logicServer_S find (side _player)) + 1)), _data] call BIS_fnc_arrayPushStack;
    };

    swt_markers_send_load = [_player, _data];
    {
    	if (isPlayer _x or {time==0 and {_player in swt_markers_isPlayer_bug}}) then {
	    	if (side _player == side _x) then {
	    		(owner _x) publicVariableClient "swt_markers_send_load";
	    		if (!isMultiplayer and {_x == player}) then {swt_markers_send_load call swt_markers_logicClient_load};
	     	};
     	};
	} forEach (playableUnits+switchableUnits);
};

[] spawn {
	swt_markers_daytime = daytime;
	publicVariable "swt_markers_daytime";

	swt_cfgMarkerColors_names = [];
	_cfg = (configfile >> "CfgMarkerColors");
	for "_i" from 0 to (count _cfg) - 1 do
	{
		_color = _cfg select _i;
		if (getNumber (_color >> 'scope') > 1) then
		{
			swt_cfgMarkerColors_names set [count swt_cfgMarkerColors_names, (configName _color)];
		};
	};
	swt_cfgMarkerColors_names = swt_cfgMarkerColors_names - ["Default"];
	if (count swt_cfgMarkerColors_names != 0) then {publicVariable "swt_cfgMarkerColors_names"};

	swt_cfgMarkers_names = [];
	_cfg = (configfile >> "CfgMarkers");
	for "_i" from 0 to (count _cfg) - 1 do
	{
		_marker = _cfg select _i;
		if (getNumber (_marker >> 'swt_show') > 0) then
		{
			swt_cfgMarkers_names set [count swt_cfgMarkers_names, (configName _marker)];
		};
	};
	if (count swt_cfgMarkers_names != 0) then {publicVariable "swt_cfgMarkers_names"};


	"swt_markers_sys_client_send" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicServer_regMark;
	};

	"swt_markers_sys_req_markers" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicServer_req_markers;
	};

	"swt_markers_sys_change_mark" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicServer_change_mark;
	};

	"swt_markers_sys_load" addPublicVariableEventHandler {
		(_this select 1) call swt_markers_logicServer_load;
	};
};
