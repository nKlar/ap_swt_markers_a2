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

swt_markers_createMarker_Addon_FrqParser_main = {
	switch (_typeName) do {
		case "swt_dv": {
			if !(player diarySubjectExists "SWT_DV") then {
				player createDiarySubject ["SWT_DV", localize "STR_SWT_DS_DV"];
			};
				player createDiaryRecord ["SWT_DV", [localize "STR_SWT_DE_FREQ", ([_Text, 1, 25, _Sender] call swt_markers_parse_frequency)]];
		};

		case "swt_kv": {
			if !(player diarySubjectExists "SWT_KV") then {
				player createDiarySubject ["SWT_KV", localize "STR_SWT_DS_KV"];
			};
				player createDiaryRecord ["SWT_KV", [localize "STR_SWT_DE_FREQ", ([_Text, 30, 512, _Sender] call swt_markers_parse_frequency)]];
		};
	};
};

swt_markers_MapKeyDown_Addon_FrqParser_delete_condition =
{
	_return = false;
	if((_markerData select 4) >= 0) then
	{
		_type = swt_cfgMarkers_names select (_markerData select 4);
		if(_type in ["swt_kv","swt_dv"] && player != (_markerData select 10)) exitWith {
			systemChat (localize "STR_SWT_M_MESS_CANTDELFRQ");
			_return = true;
		};
	};
	_return;
};