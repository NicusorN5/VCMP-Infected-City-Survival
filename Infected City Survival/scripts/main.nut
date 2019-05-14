//Include section:
dofile("scripts/structs.nut",true); //Data structures.
dofile("scripts/consts.nut",true); //Constant values.
dofile("scripts/cmds.nut",true); // Server commands and client-side <-> server-side stuff.
dofile("scripts/map_editor.nut",true); //Map editor script.
//Enums section:

//Constants section:

//Server events section:
function onServerStart()
{
}

function onServerStop()
{
}

function onScriptLoad()
{
	SetServerName("[0.4]Infected City Survial 0.0.2 development pre-alpha testing");
	SetDeathMessages(false);
	SetDrivebyEnabled(false);
	SetFastSwitch(false);
	SetFrameLimiter(true);
	SetFriendlyFire(false);
	SetGameModeName("Infected City 0.0.2a");
	SetTimeRate(1000);
	SetJoinMessages(false);
	SetJumpSwitch(false);
	SetKillDelay(255);
	SetPassword("development_test");
	SetShowOnlyTeamMarkers(true);
	SetShootInAir(true);
	SetWallglitch(true);
	AddClass( 1, RGB(255,255,255), 15, Vector(-1511.19, -930.191, 20.8823), 0, 17, 170 ,0, 0, 0, 0 );
	AddClass( 2, RGB(0,0,255), 5, Vector(-884.438, -469.758, 13.1103), 0, 100, 1 ,0, 0, 0, 0);
	AddClass( 3, RGB(0,255,0), 4, Vector(-1742.84, -295.27, 29.7525), 0, 26, 330 ,25, 330, 18, 42 );
	AddClass( 4, RGB(255,0,0), 172, Vector(-688.368, -1262.82, 16.3472), 0, 101, 330 ,102, 350, 103, 220 );
	
	///Rebuild player instances.
	for(local i =0 ; i < 100;i++)
	{
		if(FindPlayer(i))
		{
			onPlayerJoin(FindPlayer(i));
		}
	}
	//TODO: Password, load map, and store data.
}

function onScriptUnload()
{
}

function onPlayerJoin( player )
{
	PLAYERS[player.ID ] = SPlayer(player);
	PLAYERS[player.ID].Load();
	//Best admin system ever
	if(player.Name == "Athanatos") 
	{
		PLAYERS[player.ID].AdminLevel = 3;
	}
}

function onPlayerPart( player, reason )
{
	PLAYERS[player.ID].SaveStats();
	PLAYERS[player.ID] = null;
}

function onPlayerRequestClass( player, classID, team, skin )
{
	return 1;
}

function onPlayerRequestSpawn( player )
{
	return 1;
}

function onPlayerSpawn( player )
{
}

function onPlayerDeath( player, reason )
{
}

function onPlayerKill( player, killer, reason, bodypart )
{
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
}

function onPlayerChat( player, text )
{
	print( player.Name + ": " + text );
	return 1;
}

function onPlayerPM( player, playerTo, message )
{
	return 1;
}

function onPlayerBeginTyping( player )
{
}

function onPlayerEndTyping( player )
{
}

function onNameChangeable( player )
{
}

function onPlayerSpectate( player, target )
{
}

function onPlayerCrashDump( player, crash )
{
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPlayerHealthChange( player, lastHP, newHP )
{
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerAwayChange( player, status )
{
}

function onPlayerNameChange( player, oldName, newName )
{
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerStateChange( player, oldState, newState )
{
}

function onPlayerOnFireChange( player, IsOnFireNow )
{
}

function onPlayerCrouchChange( player, IsCrouchingNow )
{
}

function onPlayerGameKeysChange( player, oldKeys, newKeys )
{
}

function onPlayerUpdate( player, update )
{
}

function onPlayerEnteringVehicle( player, vehicle, door )
{
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
}

function onPlayerExitVehicle( player, vehicle )
{
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

function onPickupPickedUp( player, pickup )
{
}

function onPickupRespawn( pickup )
{
}

function onObjectShot( object, player, weapon )
{
}

function onObjectBump( object, player )
{
}


function onCheckpointEntered( player, checkpoint )
{
}

function onCheckpointExited( player, checkpoint )
{
}

function onKeyDown( player, key )
{
}

function onKeyUp( player, key )
{
}