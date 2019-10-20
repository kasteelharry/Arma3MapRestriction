//These lines need to be placed in initPlayerLocal.sqf.


////////////////////////////////////////
////                                ////
////        DO NOT CHANGE!          ////
////                                ////
////////////////////////////////////////

//Calls the ID getter on load and then start deleting markers in the local channels.
execVM "scripts\MapRestrictorIDGet.sqf";
execVM "scripts\DrawMapRestrictor.sqf";