//These lines need to be placed in initPlayerLocal.sqf.


////////////////////////////////////////
////                                ////
////        DO NOT CHANGE!          ////
////                                ////
////////////////////////////////////////

//Calls the ID getter on load and then start deleting markers in the local channels.
[] spawn kast_fnc_GetDirectPlayID;
[] spawn kast_fnc_KeepMapClean;