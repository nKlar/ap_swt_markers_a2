if (isServer) then
{
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\logic_server.sqf';

	//Addons
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\DynamicPatch\Server\DynamicPatch.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\BugReport\Server\BugReport.sqf';
};

if (hasInterface) then
{
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\UI\ui.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\logic_client.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Logic\sendMark.sqf';

	//Addons
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\FrqParser\Client\FrqParser.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\FrqMacro\Client\FrqMacro.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\BugReport\Client\BugReport.sqf';
	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\MarkerResync\Client\MarkerResync.sqf';

	call compile preprocessFileLineNumbers '\ap_swt_markers_a2\Addons\DynamicPatch\Client\DynamicPatch.sqf';

	call swt_markers_profileNil;
};

0 spawn compile preprocessFileLineNumbers '\ap_swt_markers_a2\UI\displays_init.sqf';