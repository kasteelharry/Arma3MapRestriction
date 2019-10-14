//MapRestrictorEssentials

//Runs the script from mission start, can also be run through debug console.
//Make it active by using 'missionNamespace setVariable ["DisableMapRestrictor", false, true];'
execVM "scripts\DrawMapRestrictor.sqf";

//Global variable used in the script:
missionNamespace setVariable ["WhiteListedIDs", [], true];//Direct Play ID's in here
missionNamespace setVariable ["DisableMapRestrictor", true, true];//Start or stop cleaning the map
missionNameSpace setVariable ["WhitelistedGroup",_AllowedToDrawGroup, true];//sets the groupname that is allowed to draw on map. Changeable ingame by same line

//Prevents shit + click waypoint creation
//Not tested!
player onMapSingleClick {_shift};

/*
Will work from version 1.96 and onwards:
onPlayerConnected 
{
    missionNamespace setVariable [format["1%", _name], _idstr, true];
};

Removes the need for the @MapRestrictorIDGet.sqf script due to it getting the Direct Play ID on connecting to the server

*/