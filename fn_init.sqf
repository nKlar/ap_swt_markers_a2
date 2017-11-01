if (isServer) then
{
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\logic_server.sqf'
};

if (hasInterface) then
{
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\UI\ui.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\logic_client.sqf'
	call swt_markers_profileNil;
};

0 spawn compile preprocessFileLineNumbers '\ap_swt_markers_a2\UI\displays_init.sqf';