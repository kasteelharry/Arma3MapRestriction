/*
    MapRestrictorEssentials

    Runs the script from mission start, can also be run through debug console.
    Make it active by using 'missionNamespace setVariable ["DisableMapRestrictor", false, true];'
    Needs to be called on 'initPlayerLocal.sqf' to have markers in local channels to be removed
*/


////////////////////////////////////////
////                                ////
////      Changeable variables      ////
////                                ////
////////////////////////////////////////

_AllowedToDrawGroup = ["GroupName1", "GroupName2", "etc..."];



////////////////////////////////////////
////                                ////
////        DO NOT CHANGE!          ////
////                                ////
////////////////////////////////////////

missionNamespace setVariable ["WhiteListedIDs", [], true];
missionNamespace setVariable ["DisableMapRestrictor", true, true];
missionNameSpace setVariable ["WhitelistedGroup",_AllowedToDrawGroup, true];


execVM "scripts\DrawMapRestrictor.sqf";

/*
Will work from version 1.96 and onwards:
onPlayerConnected 
{
    missionNamespace setVariable [_name, _idstr, true];
};

Removes the need for the @MapRestrictorIDGet.sqf script due to it getting the Direct Play ID on connecting to the server

*/
