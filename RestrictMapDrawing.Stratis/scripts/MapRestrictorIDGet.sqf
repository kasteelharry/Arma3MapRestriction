/* 
	Filename @MapRestrictorIDGet.sqf 
	Author @kasteelharry
	Licensed under GNU Affero General Public License v3.0

	Copyright @kasteelharry
	All rights reserved 


	Only neccesary till update 1.96 when _idstring is officially implemented in the main branch for onPlayerConnected and playerConnected EventHandler 
	Can be removed from arma 3 version 1.96 and higher 
	This script gathers the raw Direct Play ID by forcing player to place a marker on the map when they load in.

	Needs to be called from the initPlayerLocal.sqf to have it only run once on loading in.

	Features to be added: A database that makes it possible to save them for future use.

	Special thanks to @Larrow on the Bohemia Forums for creating a function that this script is highly based upon.
*/


fnc_MapPopUp = {

	openMap [true, true];

	titleText ["<t color='#ff0000' size='5'>Please place a marker on the map!</t><br/><t size='3'>It's the only way to get out of this screen, even I the Zeus can't get you out...</t><br/>", "PLAIN", -1, true, true];
	
	//loop that forces the map open on first spawn
	while {!visibleMap} do {
		openMap [true, true]
	};

	
	waitUntil{!isNull findDisplay 12};

	//Makes a list with the markers before every action happens, list is global.
	OldMarkerArray = allMapMarkers;

	((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDblClick",
	{
		params ["_mapCtrl","_button", "_mouseX", "_mouseY"];

		_button call fnc_ButtonClicked;
		


	}];
	
};


fnc_ButtonClicked = {
	
	_button = _this;
	
	if (_button isEqualTo 0) then 
	{
		
		//Create new thread 
		_nul = [] spawn
		{

			waitUntil {! isNull findDisplay 54};
			
			(findDisplay 54) displayAddEventHandler [ "Unload", 
			{
				_exitCode = param [ 1 ];

				//Runs when the marker creation has been succesful
				if (_exitCode isEqualTo 1) then
				{
					//New thread to be able to pull the new map markers list from the server
					[] spawn {
						
						_NewMarkerArray = allMapMarkers;
						_NewMarker = _NewMarkerArray - OldMarkerArray;
						{
					
							_g = toArray _x;
							_g resize 15;
							//Checks if marker is userplaced.
							if (toString _g == "_USER_DEFINED #") then 
							{

								_y = _x splitString "#/ ";

								//grabs the Direct Play ID
								_idstring = _y select 1;
								
								//Sets the Direct Play ID under a variable with the players name
								missionNamespace setVariable [(name player), _idstring, true];

							};
						} forEach _NewMarker;
	
					};

					
					titleText ["", "PLAIN"];

					//Closes the forced map
					openMap [false, false];

					//Removes the eventhandler
					((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
				};
			}];
		};

	};
};

//Starts the functions
call fnc_MapPopUp;

//Removes the handlers just out of good measure.
waitUntil {isNull findDisplay 12};
((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
