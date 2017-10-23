class CfgPatches
{
	class ap_markers
	{
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"Extended_EventHandlers",
			"CAUI"
		};
		author[]=
		{
			"swatSTEAM",
			"Noma",
			"nKlar"
		};
		versionDesc="SWT Markers, rebuilt by ArmaProject";
		version="2.1";
		versionStr="2.1";
		versionAr[]={2,1};
	};
};
class Extended_PreInit_EventHandlers
{
	class swt_markers
	{
		Init="execVM '\swt_markers\fn_init.sqf'";
	};
};
class CfgMarkers
{
	class nm_kv
	{
		scope=2;
		name="$STR_NM_KV";
		icon="\swt_markers\data\nm_kv_ca.paa";
		color[]={1,0,0,1};
		size=29;
		shadow=1;
	};
	class nm_dv: nm_kv
	{
		name="$STR_NM_DV";
		icon="\swt_markers\data\nm_dv_ca.paa";
	};
};
class RscListBox;
class RscIGUIListBox;
class RscXListBox;
class RscStructuredText;
class RscButtonMenu;
class RscButton;
class RscPicture;
class RscText;
class RscEdit;
class RscActivePicture;
class RscToolbox;
class RscIGUIShortcutButton;
class RscActiveText;
class ScrollBar;
class RscCombo;
class RscControlsGroup;
class RscCheckBox;
class swt_border_RscText: RscText
{
	color[]={1,1,1,1};
	colorText[]={1,1,1,1};
	style="64 + 2";
};
class swt_RscShortcutButton
{
	idc=-1;
	style=0;
	default=0;
	shadow=1;
	w=0.183825;
	h="(  (  ((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[]={1,1,1,1};
	colorFocused[]={1,1,1,1};
	color2[]={0.94999999,0.94999999,0.94999999,1};
	colorDisabled[]={1,1,1,0.25};
	colorBackground[]=
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};
	colorBackgroundFocused[]=
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};
	colorBackground2[]={1,1,1,1};
	animTextureDefault="\ca\ui\data\ui_button_default_ca.paa";
	animTextureNormal="\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled="\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver="\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused="\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed="\ca\ui\data\ui_button_down_ca.paa";
	periodFocus=1.2;
	periodOver=0.80000001;
	class HitZone
	{
		left=0;
		top=0;
		right=0;
		bottom=0;
	};
	class ShortcutPos
	{
		left=0;
		top="(   (  (  ((safezoneW / safezoneH) min 1.2) / 1.2) / 20) -   (   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top="(   (  (  ((safezoneW / safezoneH) min 1.2) / 1.2) / 20) -   (   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right=0.0049999999;
		bottom=0;
	};
	period=0.40000001;
	font="Zeppelin32";
	size="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text="";
	soundEnter[]=
	{
		"",
		0.090000004,
		1
	};
	soundPush[]=
	{
		"",
		0.090000004,
		1
	};
	soundClick[]=
	{
		"",
		0.090000004,
		1
	};
	soundEscape[]=
	{
		"",
		0.090000004,
		1
	};
	action="";
	class Attributes
	{
		font="Zeppelin32";
		color="#E5E5E5";
		align="left";
		shadow="true";
	};
	class AttributesImage
	{
		font="Zeppelin32";
		color="#E5E5E5";
		align="left";
	};
};
class swt_RscButtonMenu: swt_RscShortcutButton
{
	idc=-1;
	type=16;
	style=2;
	default=0;
	shadow=0;
	x=0;
	y=0;
	text="";
	textureNoShortcut="#(argb,8,8,3)color(0,0,0,0)";
	w="10 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
	h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	animTextureNormal="#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled="#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver="#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused="#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed="#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault="#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[]={0,0,0,0.80000001};
	colorBackgroundFocused[]={1,1,1,1};
	colorBackground2[]={0.75,0.75,0.75,1};
	color[]={1,1,1,1};
	colorFocused[]={0,0,0,1};
	color2[]={0,0,0,1};
	colorText[]={1,1,1,1};
	colorDisabled[]={1,1,1,0.25};
	period=1.2;
	periodFocus=1.2;
	periodOver=1.2;
	size="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[]={1,1,1,1};
	tooltipColorBox[]={1,1,1,1};
	tooltipColorShade[]={0,0,0,0.64999998};
	class TextPos
	{
		left="0.25 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
		top="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) -   (   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right=0.0049999999;
		bottom=0;
	};
	class Attributes
	{
		font="Zeppelin32";
		color="#E5E5E5";
		align="left";
		shadow="false";
	};
	class ShortcutPos
	{
		left="(6.25 *    (   ((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top=0.0049999999;
		w=0.022500001;
		h=0.029999999;
	};
};
class swt_RscStructuredText: RscStructuredText
{
	w="(10-0.9) *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
	size="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
	class Attributes
	{
		align="left";
		color="#ffffff";
	};
};
class swt_RscStructuredText_sett: RscStructuredText
{
	x="(0.9+0.3) * (((safezoneW/safezoneH) min 1.2)/40)";
	y=0;
	w="(10-0.9) *  (((safezoneW/safezoneH) min 1.2)/40)";
	h="0.9 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
	size="(((((safezoneW/safezoneH) min 1.2)/1.2)/25) * 0.85)";
	class Attributes
	{
		align="left";
		color="#ffffff";
	};
};
class swt_RscCheckBox: RscActiveText
{
	style=48;
	text="";
	x="0.3 * (((safezoneW/safezoneH) min 1.2)/40)";
	y=0;
	w="1 * (((safezoneW/safezoneH) min 1.2)/40)";
	h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
};
class swt_ScrollBar: ScrollBar
{
	color[]={0,0,0,0.69999999};
	colorActive[]={0,0,0,0.69999999};
	colorDisabled[]={0,0,0,0.69999999};
	thumb="#(argb,8,8,3)color(0,0,0,0.7)";
	arrowEmpty="#(argb,8,8,3)color(0,0,0,0)";
	arrowFull="#(argb,8,8,3)color(0,0,0,0)";
	border="#(argb,8,8,3)color(0,0,0,0)";
	shadow=0;
};
class swt_RscControlsGroup
{
	class VScrollbar
	{
		color[]={1,1,1,1};
		width=0.021;
		autoScrollSpeed=-1;
		autoScrollDelay=5;
		autoScrollRewind=0;
		shadow=0;
	};
	class HScrollbar
	{
		color[]={1,1,1,1};
		height=0;
		shadow=0;
	};
	class ScrollBar
	{
		color[]={0,0,0,0.69999999};
		colorActive[]={0,0,0,0.69999999};
		colorDisabled[]={0,0,0,0.69999999};
		thumb="#(argb,8,8,3)color(0,0,0,0.7)";
		arrowEmpty="#(argb,8,8,3)color(0,0,0,0)";
		arrowFull="#(argb,8,8,3)color(0,0,0,0)";
		border="#(argb,8,8,3)color(0,0,0,0)";
		shadow=0;
	};
	class Controls
	{
	};
	type=15;
	idc=-1;
	x=0;
	y=0;
	w=1;
	h=1;
	shadow=0;
	style=16;
};
class swt_RscCombo: RscCombo
{
	colorSelect[]={0,0,0,1};
	colorText[]={1,1,1,1};
	colorBackground[]={0,0,0,0.69999999};
	colorSelectBackground[]={1,1,1,0.69999999};
	colorScrollbar[]={1,0,0,1};
	arrowEmpty="\swt_markers\data\arrow_combo_ca.paa";
	arrowFull="\swt_markers\data\arrow_combo_active_ca.paa";
	wholeHeight=0.44999999;
	colorActive[]={1,0,0,1};
	colorDisabled[]={1,1,1,0.25};
	class ComboScrollBar: ScrollBar
	{
		color[]={1,1,1,0.5};
	};
};
class swt_RscActivePicture: RscActiveText
{
	style=48;
	color[]={1,1,1,0.60000002};
	colorActive[]={1,1,1,1};
};
class swt_RscButton
{
	type=1;
	style=2;
	x=0;
	y=0;
	w=0;
	h=0;
	shadow=2;
	font="Zeppelin32";
	sizeEx="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text="";
	colorText[]={0,0,0,0};
	colorBackground[]={0,0,0,0};
	colorFocused[]={0,0,0,0};
	colorBackgroundActive[]={0,0,0,0};
	colorDisabled[]={0,0,0,0};
	colorBackgroundDisabled[]={0,0,0,0};
	offsetX=0;
	offsetY=0;
	offsetPressedX=0;
	offsetPressedY=0;
	colorShadow[]={0,0,0,0};
	colorBorder[]={0,0,0,0};
	borderSize=0;
	soundEnter[]={};
	soundPush[]={};
	soundClick[]={};
	soundEscape[]={};
};
class RscDisplayMainMap
{
	class controls
	{
		class swt_markers_infoCtrl: swt_RscStructuredText
		{
			idc=228;
			x=0;
			y=0;
			w=0;
			h=0;
			text="";
		};
	};
};
class RscDisplayGetReady: RscDisplayMainMap
{
	class controls
	{
		class swt_markers_infoCtrl: swt_RscStructuredText
		{
			idc=228;
			x=0;
			y=0;
			w=0;
			h=0;
			text="";
		};
	};
};
class RscDisplayServerGetReady: RscDisplayGetReady
{
	class controls
	{
		class swt_markers_infoCtrl: swt_RscStructuredText
		{
			idc=228;
			x=0;
			y=0;
			w=0;
			h=0;
			text="";
		};
	};
};
class RscDisplayClientGetReady: RscDisplayGetReady
{
	class controls
	{
		class swt_markers_infoCtrl: swt_RscStructuredText
		{
			idc=228;
			x=0;
			y=0;
			w=0;
			h=0;
			text="";
		};
	};
};
class RscDisplayChannel
{
	onLoad="[_this select 0] spawn {swt_markers_channel = ctrlText ((_this select 0) displayCtrl 101)}";
};
class RscDisplayInsertMarker
{
	enableSimulation=0;
	onLoad="_this call swt_markers_onLoad";
	onUnload="call swt_markers_unLoad";
	idd=54;
	movingEnable="true";
	onKeyDown="_this call swt_markers_DOWN";
	onKeyUp="_this call swt_markers_UP";
	onMouseButtonDown="_this call swt_markers_d_cl_pic";
	onMouseZChanged="_this call swt_markers_MouseZ";
	class controlsBackground
	{
		class Description: RscStructuredText
		{
			colorBackground[]={0,0,0,0.69999999};
			idc=1100;
			x=0;
			y=0;
			w="10 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="2 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			colorText[]={1,1,1,1};
			size="(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow=1;
			class Attributes
			{
				font="Zeppelin32";
				color="#ffffff";
				align="left";
				shadow=1;
			};
		};
	};
	class controls
	{
		delete ButtonOK;
		delete Picture;
		delete Text;
		class swt_Text: RscEdit
		{
			idc=203;
			x=0;
			y=0;
			w="10 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			onKeyDown="_this call swt_markers_editDOWN";
		};
		class swt_Picture: RscPicture
		{
			idc=204;
			moving="true";
			x=0.25998399;
			y=0.40000001;
			w=0.050000001;
			h=0.0666667;
		};
		class ButtonMenuOK: swt_RscButtonMenu
		{
			text="OK";
			default=1;
			idc=1;
			x=0;
			y=0;
			w="5 *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="['mark',(ctrlParent (_this select 0))] call swt_markers_sys_sendMark; true";
		};
		class ButtonChannel: swt_RscButton
		{
			idc=205;
			x=0;
			y=0;
			w="7 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="_this call swt_markers_click_chann";
		};
		class ButtonMenuCancel: swt_RscButtonMenu
		{
			text="$STR_SWT_M_CANCEL";
			idc=2;
			x=0;
			y=0;
			w="5 *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
		};
		class ButtonMenuInfo: swt_RscButtonMenu
		{
			idc=2400;
			text="";
			x=0;
			y=0;
			w="10 *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="(_this select 0) call swt_markers_infoAnim";
		};
		class Settings_butt: swt_RscActivePicture
		{
			idc=900;
			text="\swt_markers\data\icon_config_ca.paa";
			x=0;
			y=0;
			w="0.75 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="_this spawn swt_markers_set_butt";
		};
		class show_lb_butt: swt_RscActivePicture
		{
			idc=904;
			text="\swt_markers\data\icon_menu.paa";
			x=0;
			y=0;
			w="0.75 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="_this spawn swt_markers_show_lb_butt";
		};
		class add_group: RscActiveText
		{
			idc=903;
			text="G";
			color[]={1,1,1,0.25};
			colorText[]={1,1,1,0.25};
			colorActive[]={0.80000001,0.80000001,0.80000001,0.5};
			x=0;
			y=0;
			w="0.5 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			sizeEx="0.8 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,'G'] call swt_markers_fast_text";
		};
		class add_name: RscActiveText
		{
			idc=902;
			text="N";
			color[]={1,1,1,0.25};
			colorText[]={1,1,1,0.25};
			colorActive[]={0.80000001,0.80000001,0.80000001,0.5};
			x=0;
			y=0;
			w="0.5 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			sizeEx="0.8 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,'N'] call swt_markers_fast_text";
		};
		class add_text: RscActiveText
		{
			idc=901;
			text="T";
			color[]={1,1,1,0.25};
			colorText[]={1,1,1,0.25};
			colorActive[]={0.80000001,0.80000001,0.80000001,0.5};
			x=0;
			y=0;
			w="0.5 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			sizeEx="0.8 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,'T'] call swt_markers_fast_text";
		};
		class RscListbox_15000_color: RscListBox
		{
			idc=15000;
			x=0;
			y=0;
			w="2 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="10 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			onLBSelChanged="[_this select 0, _this select 1, 15000] call swt_markers_lb_sel_adv";
			class ScrollBar: swt_ScrollBar
			{
			};
		};
		class RscListbox_15001_pic: RscListBox
		{
			idc=15001;
			x=0;
			y=0;
			w="2 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="10 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			onLBSelChanged="[_this select 0, _this select 1, 15001] call swt_markers_lb_sel_adv";
			class ScrollBar: swt_ScrollBar
			{
			};
		};
		class swt_RscControlsGroup: swt_RscControlsGroup
		{
			idc=1103;
			x=0;
			y=0;
			w="10 *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="15 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			class controls
			{
				class Info_12: swt_RscStructuredText
				{
					colorBackground[]={0,0,0,0.69999999};
					idc=1101;
					x=0;
					y="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="10 *  (((safezoneW/safezoneH) min 1.2)/40)";
					h="23.5 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
			};
		};
		class swt_color_1200: swt_RscActivePicture
		{
			idc=1200;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) * (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,0] call swt_markers_setColor";
		};
		class swt_color_1201: swt_RscActivePicture
		{
			idc=1201;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) * (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,1] call swt_markers_setColor";
		};
		class swt_color_1202: swt_RscActivePicture
		{
			idc=1202;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) * (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,2] call swt_markers_setColor";
		};
		class swt_color_1203: swt_RscActivePicture
		{
			idc=1203;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) * (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,3] call swt_markers_setColor";
		};
		class swt_color_1204: swt_RscActivePicture
		{
			idc=1204;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) * (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,4] call swt_markers_setColor";
		};
		class swt_color_1205: swt_RscActivePicture
		{
			idc=1205;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w="(10/6) *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="0.7 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="[_this select 0,5] call swt_markers_setColor";
		};
		class swt_icon_1300: swt_RscButton
		{
			idc=1300;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,0] call swt_markers_setIcon";
		};
		class swt_icon_1301: swt_RscButton
		{
			idc=1301;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,1] call swt_markers_setIcon";
		};
		class swt_icon_1302: swt_RscButton
		{
			idc=1302;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,2] call swt_markers_setIcon";
		};
		class swt_icon_1303: swt_RscButton
		{
			idc=1303;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,3] call swt_markers_setIcon";
		};
		class swt_icon_1304: swt_RscButton
		{
			idc=1304;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,4] call swt_markers_setIcon";
		};
		class swt_icon_1305: swt_RscButton
		{
			idc=1305;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick="[_this select 0,5] call swt_markers_setIcon";
		};
		class swt_icon_1400: RscPicture
		{
			idc=1400;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_icon_1401: RscPicture
		{
			idc=1401;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_icon_1402: RscPicture
		{
			idc=1402;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_icon_1403: RscPicture
		{
			idc=1403;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_icon_1404: RscPicture
		{
			idc=1404;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_icon_1405: RscPicture
		{
			idc=1405;
			text="";
			w=0.050000001;
			h=0.0666667;
		};
		class swt_RscCombo_2100: swt_RscCombo
		{
			idc=2100;
			x="0.448438 * safezoneW + safezoneX";
			y="0.511 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 0] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2101: swt_RscCombo
		{
			idc=2101;
			x="0.448438 * safezoneW + safezoneX";
			y="0.533 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 1] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2102: swt_RscCombo
		{
			idc=2102;
			x="0.448438 * safezoneW + safezoneX";
			y="0.555 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 2] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2103: swt_RscCombo
		{
			idc=2103;
			x="0.448438 * safezoneW + safezoneX";
			y="0.577 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 3] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2104: swt_RscCombo
		{
			idc=2104;
			x="0.448438 * safezoneW + safezoneX";
			y="0.599 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 4] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2105: swt_RscCombo
		{
			idc=2105;
			x="0.448438 * safezoneW + safezoneX";
			y="0.621 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 5] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2106: swt_RscCombo
		{
			idc=2106;
			x="0.520625 * safezoneW + safezoneX";
			y="0.511 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 6] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2107: swt_RscCombo
		{
			idc=2107;
			x="0.520625 * safezoneW + safezoneX";
			y="0.533 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 7] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2108: swt_RscCombo
		{
			idc=2108;
			x="0.520625 * safezoneW + safezoneX";
			y="0.555 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 8] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2109: swt_RscCombo
		{
			idc=2109;
			x="0.520625 * safezoneW + safezoneX";
			y="0.577 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 9] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2110: swt_RscCombo
		{
			idc=2110;
			x="0.520625 * safezoneW + safezoneX";
			y="0.599 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 10] call swt_markers_lb_sel;";
		};
		class swt_RscCombo_2111: swt_RscCombo
		{
			idc=2111;
			x="0.520625 * safezoneW + safezoneX";
			y="0.621 * safezoneH + safezoneY";
			w="5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged="[_this select 0, _this select 1, 11] call swt_markers_lb_sel;";
		};
		class swt_ButtonAdv: swt_RscButtonMenu
		{
			idc=228;
			text="$STR_SWT_M_ADV";
			x=0;
			y=0;
			w="10 *  (((safezoneW/safezoneH) min 1.2)/40)";
			h="1 *  ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			OnButtonClick="_this spawn swt_markers_adv_set_butt";
		};
		class swt_RscControlsGroup_adv: swt_RscControlsGroup
		{
			idc=1104;
			x=0;
			y=0;
			w="25 * (((safezoneW/safezoneH) min 1.2)/40)";
			h="20 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
			class controls
			{
				class adv_background: RscText
				{
					idc=822;
					x=0;
					y=0;
					w="(21.1) * (((safezoneW/safezoneH) min 1.2)/40)";
					h="((3.5*0.9)+(4.5*0.9)+(7.5*0.9) + 2.5 * 0.9 + 0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					colorBackground[]={0,0,0,0.69999999};
					text="";
				};
				class first_block: RscText
				{
					style="64 + 2";
					x="0.15 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="0 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					text="$STR_SWT_M_SHOW_BUTTONS";
					w="(9.7) * (((safezoneW/safezoneH) min 1.2)/40)";
					h="(3.5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					SizeEx="0.8 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_show_butt: swt_RscCheckBox
				{
					idc=229;
					y="(0.9)* ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SHOW OK'] spawn swt_markers_cb_butt";
				};
				class text_show_butt: swt_RscStructuredText_sett
				{
					idc=230;
					text="$STR_SWT_M_OKCAN";
					y="(0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class Second_block: first_block
				{
					x="0.15 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="(3.5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					text="$STR_SWT_M_CHOOSE";
					h="(4.5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_show_icon: swt_RscCheckBox
				{
					idc=231;
					y="(3.5*0.9+0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SHOW ICON'] spawn swt_markers_cb_butt";
				};
				class text_show_icon: swt_RscStructuredText_sett
				{
					idc=232;
					text="$STR_SWT_M_ICONS";
					y="(3.5*0.9+0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_show_color: swt_RscCheckBox
				{
					idc=233;
					y="(3.5*0.9+2*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SHOW COLOR'] spawn swt_markers_cb_butt";
				};
				class text_show_color: swt_RscStructuredText_sett
				{
					idc=234;
					text="$STR_SWT_M_COLORS";
					y="(3.5*0.9+2*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_show_lb: swt_RscCheckBox
				{
					idc=235;
					y="(3.5*0.9+3*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SHOW LB'] spawn swt_markers_cb_butt";
				};
				class text_show_lb: swt_RscStructuredText_sett
				{
					idc=236;
					text="$STR_SWT_M_ADVL";
					y="(3.5*0.9+3*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class third_block: first_block
				{
					style="64 + 2";
					x="0.15 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="((3.5*0.9)+(4.5*0.9)) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					text="$STR_SWT_M_F";
					h="(7.5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					SizeEx="0.8 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_save_text: swt_RscCheckBox
				{
					idc=237;
					y="((3.5*0.9)+(4.5*0.9) + 0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SAVE TEXT'] spawn swt_markers_cb_butt";
				};
				class text_save_text: swt_RscStructuredText_sett
				{
					idc=238;
					text="$STR_SWT_M_SAVET";
					y="((3.5*0.9)+(4.5*0.9) + 0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_save_mark: swt_RscCheckBox
				{
					idc=245;
					y="((3.5*0.9)+(4.5*0.9) + 2*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SAVE MARK'] spawn swt_markers_cb_butt";
				};
				class text_save_mark: swt_RscStructuredText_sett
				{
					idc=246;
					text="$STR_SWT_M_SAVEM";
					y="((3.5*0.9)+(4.5*0.9) + 2*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_fast_load: swt_RscCheckBox
				{
					idc=239;
					y="((3.5*0.9)+(4.5*0.9)+3*0.9)* ((((safezoneW/safezoneH) min 1.2) / 1.2) / 25)";
					onButtonClick="[_this,'FAST LOAD'] spawn swt_markers_cb_butt";
				};
				class text_fast_load: swt_RscStructuredText_sett
				{
					idc=240;
					text="$STR_SWT_M_FASTL";
					y="((3.5*0.9)+(4.5*0.9)+3*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_show_back: swt_RscCheckBox
				{
					idc=243;
					y="((3.5*0.9)+(4.5*0.9) + 4*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'SHOW BACK'] spawn swt_markers_cb_butt";
				};
				class text_show_back: swt_RscStructuredText_sett
				{
					idc=244;
					text="$STR_SWT_M_BACKGROUND";
					y="((3.5*0.9)+(4.5*0.9) + 4*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_log: swt_RscCheckBox
				{
					idc=247;
					y="((3.5*0.9)+(4.5*0.9) + 5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'LOG'] spawn swt_markers_cb_butt";
				};
				class text_log: swt_RscStructuredText_sett
				{
					idc=248;
					text="$STR_SWT_M_LOG";
					y="((3.5*0.9)+(4.5*0.9) + 5*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class cb_markinfo: swt_RscCheckBox
				{
					idc=249;
					y="((3.5*0.9)+(4.5*0.9) + 6*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onButtonClick="[_this,'MARK INFO'] spawn swt_markers_cb_butt";
				};
				class text_markimfo: swt_RscStructuredText_sett
				{
					idc=250;
					text="$STR_SWT_M_MARKINFO";
					y="((3.5*0.9)+(4.5*0.9) + 6*0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class swt_text_saved: first_block
				{
					idc=-1;
					text="$STR_SWT_M_SAVEDTEXT";
					x="0.3 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="((3.5*0.9)+(4.5*0.9)+(7.5*0.9)) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					h="2.5 * 0.9 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class swt_edit_saved: RscEdit
				{
					idc=551;
					text="";
					x="0.45 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="((3.5*0.9)+(4.5*0.9)+(7.5*0.9) + 0.9) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="9.2 * (((safezoneW/safezoneH) min 1.2)/40)";
					h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					onKeyUp="swt_markers_fast_text_T_saved = ctrlText (_this select 0);swt_marker_settings_params set [9, swt_markers_fast_text_T_saved]; profileNamespace setVariable ['ap_swt_marker_settings_params', swt_marker_settings_params];saveProfileNamespace;";
					color[]={1,1,1,1};
				};
				class swt_text_markersmap: first_block
				{
					idc=650;
					text="$STR_SWT_M_SAVEDM";
					x="10.2 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="0 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="10.8 * (((safezoneW/safezoneH) min 1.2)/40)";
					h="(9 + 9*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class swt_text_markerspr: first_block
				{
					idc=651;
					text="$STR_SWT_M_INPROF";
					x="10.4 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="10.4 * (((safezoneW/safezoneH) min 1.2)/40)";
					h="(4+4*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class swt_ButtonSAVE: swt_RscButtonMenu
				{
					idc=347;
					text="$STR_SWT_M_SAVE";
					x="10.6 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="2 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					size="0.85 * (((((safezoneW/safezoneH) min 1.2)/1.2)/25) * 1)";
					OnButtonClick="_this call swt_markers_fnc_save_markers";
				};
				class swt_ButtonLOAD: swt_ButtonSAVE
				{
					idc=348;
					text="$STR_SWT_M_LOAD";
					y="(3 + 1*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					OnButtonClick="[_this] call swt_markers_fnc_load_markers";
				};
				class swt_ButtonUnload: swt_ButtonSAVE
				{
					idc=346;
					text="$STR_SWT_M_UNLOAD";
					y="(4 + 2*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					OnButtonClick="profileNamespace setVariable ['ap_swt_markers_save_arr',[]]; saveProfileNamespace;";
				};
				class swt_text_clip: first_block
				{
					idc=652;
					text="$STR_SWT_M_CLIP";
					x="10.4 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="(5 + 3*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="10.4 * (((safezoneW/safezoneH) min 1.2)/40)";
					h="(4+4*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
				};
				class swt_ButtonSaveClp: swt_ButtonSAVE
				{
					idc=351;
					text="$STR_SWT_M_SAVE";
					y="(6 + 3*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					OnButtonClick="'CLIP' call swt_markers_fnc_save_markers";
				};
				class swt_Edit: RscEdit
				{
					idc=653;
					text="$STR_SWT_M_ENTERARRAY";
					x="10.6 * (((safezoneW/safezoneH) min 1.2)/40)";
					y="(7 + 4*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					w="10 * (((safezoneW/safezoneH) min 1.2)/40)";
					h="1 * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					size="0.85*(((((safezoneW/safezoneH) min 1.2)/1.2)/25) * 1)";
				};
				class swt_ButtonClpLoad: swt_ButtonSAVE
				{
					idc=654;
					text="$STR_SWT_M_LOAD";
					y="(8 + 5*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					OnButtonClick="[_this,ctrlText ((ctrlParent (_this select 0)) displayCtrl 653)] call swt_markers_fnc_load_markers";
				};
				class swt_Buttondef: swt_ButtonSAVE
				{
					idc=345;
					text="$STR_SWT_M_DEF";
					y="(9 + 10*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					colorBackground[]={0.95700002,0,0,0.80000001};
					color[]={0,0,0,1};
					OnButtonClick="call swt_def; (ctrlParent (_this select 0)) closeDisplay 0;";
				};
				class swt_ButtonResync: swt_ButtonSAVE
				{
					idc = 349;
					text = "$STR_SWT_M_RESYNC";
					y = "(10 + 11*0.15) * ((((safezoneW/safezoneH) min 1.2)/1.2)/25)";
					colorBackground[]={0.95700002,0,0,0.80000001};
					color[] = {0,0,0,1};
					OnButtonClick = "call swt_markers_resync_markers";
				};
			};
		};
	};
};
