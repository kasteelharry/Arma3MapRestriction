/* Filename @MapRestrictorIDGet.sqf 
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


//This function creates the framework from which the other function expands on.
fnc_MapPopUp = {

	//opens the map
	openMap [true, true];

	//Shows text on screen informing players what to do, even a monkey could follow these instructions
	titleText ["<t color='#ff0000' size='5'>Please place a marker on the map!</t><br/><t size='3'>It's the only way to get out of this screen, even I the Zeus can't get you out...</t><br/>", "PLAIN", -1, true, true];
	
	//makes sure that the map is open on missionStart
	while {!visibleMap} do {
		openMap [true, true]
	};

	//Checks if the map is open and not quickly closed
	waitUntil{!isNull findDisplay 12};

	//Makes a list with the markers before every action happens, list is global.
	OldMarkerArray = allMapMarkers;

	//Creates eventHandler for a double mouseclick
	// Display 12 = map, 51 = marker creation screen I believe.
	((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDblClick",
	{
		params ["_mapCtrl","_button", "_mouseX", "_mouseY"];

		//Checks if it was a double click with the LMB 
		_button call fnc_ButtonClicked;
		


	}];
	
};

//This function does the checking and setting
fnc_ButtonClicked = {
	//Button is from the previous function
	_button = _this;
	//_button = 0; is the left mouse button(LMB)
	if (_button isEqualTo 0) then 
	{
		
		//Create new thread to prevent other scripts not working
		_nul = [] spawn{
			//waits until insert marker menu has appeared
			waitUntil {! isNull findDisplay 54};
			//creates a trigger for when insert marker menu gets openend
			(findDisplay 54) displayAddEventHandler [ "Unload", 
			{
				_exitCode = param [ 1 ];

				//Runs when the marker creation has been succesful
				if (_exitCode isEqualTo 1) then
				{
					//New thread to be able to pull the new map markers list from the server
					[] spawn {
						//compares the new list with the old list
						_NewMarkerArray = allMapMarkers;
						_NewMarker = _NewMarkerArray - OldMarkerArray;
						{
					
							_g = toArray _x;
							_g resize 15;
							//Checks if marker is userplaced.
							if (toString _g == "_USER_DEFINED #") then 
							{

								_y = _x splitString "#/ ";

								//grabs the Direct Play ID and not rounded up or down, thank god!
								//DO NOT PARSE THIS!
								_idstring = _y select 1;
								
								//Sets the Direct Play ID under a variable with the players name
								missionNamespace setVariable [(name player), _idstring, true];

							};
						} forEach _NewMarker;
	
					};

					//Removes the big text on the map 
					titleText ["", "PLAIN"];

					//Makes sure the map is out of view 
					openMap [false, false];

					//Removes the handler when the mouse doubleclicks on the map so markers can be created after this by the player.
					((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
				};
			}];
		};

	};
};

//Starts the script
call fnc_MapPopUp;

//Removes the handlers just out of good measure.
waitUntil {isNull findDisplay 12};
((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
