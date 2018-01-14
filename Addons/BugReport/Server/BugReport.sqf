swt_markers_allow_bugreport = true;
#ifdef DEBUG
	diag_log format["SWT_MARKERS OUT (swt_markers_allow_bugreport): %1", swt_markers_allow_bugreport];
#endif
publicVariable "swt_markers_allow_bugreport";

if(swt_markers_allow_bugreport) then {
	swt_markers_client_bugreport_fnc = {
		_name = name player;
		_mission = missionName;

		swt_markers_send_bug_report = [_name,_mission,swt_markers_allMarkers,swt_markers_allMarkers_params];
		publicVariableServer "swt_markers_send_bug_report";
	};

	#ifdef DEBUG
		diag_log format["SWT_MARKERS OUT (swt_markers_client_bugreport_fnc): %1", swt_markers_client_bugreport_fnc];
	#endif
	publicVariable "swt_markers_client_bugreport_fnc";
};

swt_markers_logicServer_process_report = {
	private ["_swt_markers_allMarkers","_swt_markers_allMarkers_params","_swt_markers_allMarkers_count","_swt_markers_allMarkers_params_count","_index"];

	diag_log "SWT_MARKERS_REPORT: ====================REPORT START====================";

	diag_log format ["SWT_MARKERS_REPORT (name): %1", _this select 0];
	diag_log format ["SWT_MARKERS_REPORT (mission): %1", _this select 1];

	_swt_markers_allMarkers = _this select 2;
	_swt_markers_allMarkers_params = _this select 3;

	_swt_markers_allMarkers_count = count _swt_markers_allMarkers;
	_swt_markers_allMarkers_params_count = count _swt_markers_allMarkers_params;



	diag_log format ["SWT_MARKERS_REPORT (_swt_markers_allMarkers_count): %1", _swt_markers_allMarkers_count];
	diag_log format ["SWT_MARKERS_REPORT (_swt_markers_allMarkers_params_count): %1", _swt_markers_allMarkers_params_count];

	_index = 0;
	_maxIndex = [_swt_markers_allMarkers_count,_swt_markers_allMarkers_params_count] select (_swt_markers_allMarkers_params_count >= _swt_markers_allMarkers_count);

	_desync = false;
	_swt_markers_allMarkers_endState = false;
	_swt_markers_allMarkers_params_endState = false;



	while {_index < _maxIndex} do
	{
		if(_index < _swt_markers_allMarkers_count) then {
			diag_log format ["SWT_MARKERS_REPORT (marker): %1", _swt_markers_allMarkers select _index];
		}
		else
		{
			_swt_markers_allMarkers_endState = true;
		};

		if(_index < _swt_markers_allMarkers_params_count) then {
			_data = _swt_markers_allMarkers_params select _index;
			if(typeName _data != "ARRAY") then
			{
				diag_log "SWT_MARKERS_REPORT: POSSIBLE ERROR DETECTED";
			}
			else
			{
				if(!_desync && !_swt_markers_allMarkers_endState && !_swt_markers_allMarkers_params_endState) then
				{
					if((_swt_markers_allMarkers select _index) != _data select 0) then
					{
						_desync = true;
						diag_log "SWT_MARKERS_REPORT: DESYNC DETECTED";
					};
				};
			};
			diag_log format ["SWT_MARKERS_REPORT (marker_params): %1", _swt_markers_allMarkers_params select _index];
		}
		else
		{
			_swt_markers_allMarkers_params_endState = true;
		};

		_index = _index + 1;
	};

	diag_log "SWT_MARKERS_REPORT: =====================REPORT END=====================";
};

if(swt_markers_allow_bugreport) then {
	"swt_markers_send_bug_report" addPublicVariableEventHandler {
		#ifdef DEBUG
			diag_log format["SWT_MARKERS IN (%1): %2", _this select 0, _this select 1];
		#endif
		(_this select 1) call swt_markers_logicServer_process_report;
	};
};