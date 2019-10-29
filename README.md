# Arma 3 Map Restriction Dev Branch, Bugs to be expected
This script and files make it possible for the server to restrict who can place markers down/draw on the map depending on which group is allowed to draw on it.

When the "DisableMapRestrictor" global variable is set to true, the script will not start delete markers untill the value is set to false. To stop removing markers, change the value back to false.

## How to use:
1. Copy the Repository or download the zip.
2. Copy the functions folder to your mission folder.
3. Copy the 'intiServer.sqf' and the 'initPlayerLocal.sqf' files to your mission folder.
4. If the files already exist then paste the codes, found in **Custom installation**, in the correct files.
5. Run your mission in a dedicated enviroment (should work fine on singleplayer aswell).

If the files are in the mission folder paste the following lines of code in them:
### Custom installation:
If the files 'intiServer.sqf', the 'Description.ext' and the 'initPlayerLocal.sqf' already exist on in your missions folder add for each file the following lines of code to the file:

#### initServer.sqf:
This part of the code will be run on the server and sets all the public variables so that they can be changed throughout the mission and scripts.
```
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

onPlayerConnected 
{
   missionNamespace setVariable [_name, _idstr, true];
};

//Runs the script
[] spawn kast_fnc_KeepMapClean;

```
#### initPlayerLocal.sqf:

```
//Removes the markers in the local channels
[] spawn kast_fnc_KeepMapClean;

```

### description.ext:
```
class CfgFunctions
{
	class kasteelharry
	{
		tag = "kast";

		class functions
		{
			file = "functions";
			class KeepMapClean;
		};
	};
};
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
- Running this script in a singleplayer enviroment will result in the game to crash.

## Upcoming Features:
- Instead of deleting makers, players can't place markers in the first place.
