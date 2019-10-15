# Arma 3 Map Restriction Dev Branch, Bugs to be expected
This script and files make it possible for the server to restrict who can place markers down/draw on the map depending on which group is allowed to draw on it. The script forces players to place a marker on the map the first time they join the mission. This makes it able to create a list of Direct Play ID without having them in scientific notation (what arma usually does when getting the Direct Play ID with onplayerconnected). 

When the "DisableMapRestrictor" global variable is set to true, the script will not start delete markers untill the value is set to false. To stop removing markers, change the value back to false.

## How to use:
1. Copy the Repository or download the zip.
2. Copy the scripts folder to your mission folder.
3. Copy the 'intiServer.sqf' and the 'initPlayerLocal.sqf' files to your mission folder.
4. If the files already exist then paste the codes, found in **Custom installation**, in the correct files.
5. Run your mission in a dedicated enviroment (should work fine on singleplayer aswell).

If the files are in the mission folder paste the following lines of code in them:
### Custom installation:
If the files 'intiServer.sqf', the 'Description.exe' and the 'initPlayerLocal.sqf' already exist on in your missions folder add for each file the following lines of code to the file:

#### initServer.sqf:
This part of the code will be run on the server and sets all the public variables so that they can be changed throughout the mission and scripts.
```
//MapRestrictorEssentials
//Runs the script from mission start, can also be run through debug console.
//Make it active by using 'missionNamespace setVariable ["DisableMapRestrictor", false, true];'
//Can only run on serverside channels such aas global, disable the other channels for now to prevent marker placement in there
execVM "scripts\DrawMapRestrictor.sqf";

//Global variable used in the script:
missionNamespace setVariable ["WhiteListedIDs", [], true];//Direct Play ID's in here
missionNamespace setVariable ["DisableMapRestrictor", true, true];//Start or stop cleaning the map
missionNameSpace setVariable ["WhitelistedGroup",_AllowedToDrawGroup, true];//sets the groupname that is allowed to draw on map. Changeable ingame by same line

//Prevents shit + click waypoint creation
//Not tested!
player onMapSingleClick {_shift};

//Will work from version 1.96 and onwards:
// onPlayerConnected 
// {
//     missionNamespace setVariable [format["1%", _name], _idstr, true];
// };
//
//Removes the need for the @MapRestrictorIDGet.sqf script due to it getting the Direct Play ID on connecting to the server
```
#### initPlayerLocal.sqf:
This script gets run on the player joining the server on it's own computer.
```
//Runs the script that makes it possible to get the players id raw and not get a rounded version
execVM "scripts\MapRestrictorIDGet.sqf";
```

## Useful code
#### Start or stop the cleaning script:
To start the cleaning process run the following line of code on the debug console on server or global.
```
missionNameSpace setVariable ["DisableMapRestrictor", false, true];
```

To stop the cleaning process run the next line of code the same way as starting the process.
```
missionNameSpace setVariable ["DisableMapRestrictor", true, true];
```

#### Change whitelisted group:
Run this also global or server.
```
missionNameSpace setVariable ["WhitelistedGroup", "NAME OF GROUP", true];
```

#### Debugging:
To debug the script run the following lines of code global:
```
//from top to bottom: ID's that are whitelisted, names of the ID's, group that is whitelisted and the state of the cleaning process 
diag_log (missionNameSpace getVariable "WhiteListedIDs");
diag_log (missionNameSpace getVariable "");
diag_log (missionNameSpace getVariable "WhiteListedNames");
diag_log (missionNameSpace getVariable "");
diag_log (missionNameSpace getVariable "WhitelistedGroup");
diag_log (missionNameSpace getVariable "");
```
This will paste the list of ID's, Names and group that are whitelisted in your log and in the server log.

## Known bugs:
- Only markers in the global channel are effected.
- If players can't place markers on the map they are stuck in the map.

## Upcoming Features:
- No need for players to place a marker to grab their Direct Play ID. (Somewhere after arma 1.96 update)
- Instead of deleting makers, players can't place markers in the first place.
- Template mission on Stratis
