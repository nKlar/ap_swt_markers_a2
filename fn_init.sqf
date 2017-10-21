if (isServer) then
{
	call compile preprocessFileLineNumbers '\swt_markers\Logic\logic_server.sqf'
};
if (hasInterface) then
{
	call compile preprocessFileLineNumbers '\swt_markers\UI\ui.sqf';
	call compile preprocessFileLineNumbers '\swt_markers\Logic\logic_client.sqf'
};
call swt_markers_profileNil;
0 spawn compile preprocessFileLineNumbers '\swt_markers\UI\displays_init.sqf';