//Calls the ID getter on load
execVM "scripts\MapRestrictorIDGet.sqf";

//Also tunning the script due to the local channels. Might impact performance.
//Will Delete markers in all channels due to this, so removes the previous need of having to disable them in 'description.ext'.
execVM "scripts\DrawMapRestrictor.sqf";