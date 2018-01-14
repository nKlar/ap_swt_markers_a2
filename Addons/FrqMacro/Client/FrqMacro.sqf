

//${6,' // '} = [6,' // ']
swt_fnc_processMacros = {
	private ["_text","_radioType","_return","_arrayText","_macroControl","_macroStart","_macro","_swt_fnc_processMacro","_swt_fnc_macroGenerateFrqs"];
	_text = _this select 0;
	_radioType = _this select 1;
	_return = [];

	_arrayText = toArray _text;
	_macroControl = false;
	_macroStart = false;
	_macro = [];

	_swt_fnc_macroGenerateFrqs = {
		private ["_times","_return","_separator","_precision"];
		_times = 1;
		_precision = 3;
		_separator = " ";
		_return = "";

		if(!isNil{_this select 0}) then
		{
			_param1 = _this select 0;
			if(typeName(_param1) == "SCALAR") then
			{
				_param1 = round(_this select 0);
				_times = [10, _param1] select ((_param1)<=10 && (_param1)>=1);
			};


			if(!isNil{_this select 1}) then
			{
				_param2 = _this select 1;
				switch (typeName(_param2)) do
				{
					case "STRING":
					{
						_separator = _param2;
					};

					case "SCALAR":
					{
						_param2 = round(_param2);
						_precision = [3, _param2] select (_param2<=3 && _param2>= 0);
					};
				};


				if(!isNil{_this select 2}) then
				{
					_param3 = _this select 2;
					switch (typeName(_param3)) do
					{
						case "STRING":
						{
							_separator = _param3;
						};

						case "SCALAR":
						{
							_param3 = round(_param3);
							_precision = [3, _param3] select (_param3<=3 && _param3>= 0);
						};
					};
				};
			};
		};

		switch (_radioType) do
		{
			case "swt_kv":
			{
				for "_i" from 1 to _times-1 step 1 do
				{
					_return = _return + str([([30,512] call BIS_fnc_randomNum), _precision] call BIS_fnc_cutDecimals) + _separator;
				};
				_return = _return + str([([30,512] call BIS_fnc_randomNum), _precision] call BIS_fnc_cutDecimals);
			};
			case "swt_dv":
			{
				for "_i" from 1 to _times-1 step 1 do
				{
					_return = _return + str([([1,25] call BIS_fnc_randomNum), _precision] call BIS_fnc_cutDecimals) + _separator;
				};
				_return = _return + str([([1,25] call BIS_fnc_randomNum), _precision] call BIS_fnc_cutDecimals);
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
			_return = (_macro call _swt_fnc_macroGenerateFrqs);
		}
		catch
		{
			_return = "";
		};
		_return;
	};

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

swt_markers_sys_sendMark_Addon_FrqMacro_main = {
	if (swt_markers_mark_type in ["swt_kv", "swt_dv"]) then {
		_text = [_text, swt_markers_mark_type] call swt_fnc_processMacros;
	};
};