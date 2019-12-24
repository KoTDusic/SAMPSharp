// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <requests>
#include <map>

#define DIALOG_REGISTER_PASSWORD 1

new Map:SaveRequestToPlayerID;
new RequestsClient:jsonstore;

main()
{
	print("\n----------------------------------");
	print(" KoTDusic");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	jsonstore = RequestsClient("http://localhost/");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, 1);
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	new name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));
	new Request:id = RequestJSON(
	jsonstore, "Login", HTTP_METHOD_POST, "CheckIfRegistered",
	JsonObject(
		"Username", JsonString(name)
	));
	MAP_insert_val_val(SaveRequestToPlayerID, _:id, playerid);
	return 1;
}

forward CheckIfRegistered(Request:id, E_HTTP_STATUS:status, Node:node);
public CheckIfRegistered(Request:id, E_HTTP_STATUS:status, Node:node) {
	new playerid = MAP_get_val_val(SaveRequestToPlayerID, _:id);
    MAP_remove_val(SaveRequestToPlayerID, _:id);
	if(status == HTTP_STATUS_OK)
	{
		SpawnPlayer(playerid);
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_REGISTER_PASSWORD,
		DIALOG_STYLE_INPUT, "Регистрация","Введите пароль","Ок","Отмена");
	}
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_REGISTER_PASSWORD:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_REGISTER_PASSWORD,
			DIALOG_STYLE_INPUT, "Регистрация","Введите пароль","Ок","Отмена");
			printf("OnDialogResponse! %i", playerid);
			new name[MAX_PLAYER_NAME + 1];
			GetPlayerName(playerid, name, sizeof(name));
			new Request:id = RequestJSON(
			jsonstore, "Registration", HTTP_METHOD_POST, "RegistrationSended",
			JsonObject(
				"Username", JsonString(name),
				"Password", JsonString(inputtext)
			));
			MAP_insert_val_val(SaveRequestToPlayerID, _:id, playerid);
		}
	}
	return 1;
}

forward RegistrationSended(Request:id, E_HTTP_STATUS:status, Node:node);
public RegistrationSended(Request:id, E_HTTP_STATUS:status, Node:node) {
	new playerid = MAP_get_val_val(SaveRequestToPlayerID, _:id);
    MAP_remove_val(SaveRequestToPlayerID, _:id);
    if(status == HTTP_STATUS_CREATED)
	{
        printf("successfully registered %i!", playerid);
		SpawnPlayer(playerid);
    }
	else
	{
		print("not registered");
	}
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
