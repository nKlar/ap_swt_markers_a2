swt_makrers_send_patch = false;
if(swt_makrers_send_patch) then {
	swt_markers_DynamicPatch = {
		//Code of patch



		//Code of patch end
	};

	#ifdef DEBUG
		diag_log format["SWT_MARKERS OUT (swt_markers_DynamicPatch): %1", swt_markers_DynamicPatch];
	#endif
	publicVariable "swt_markers_DynamicPatch";
};