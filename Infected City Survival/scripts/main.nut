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
	SetServerName("[0.4]Infected City Survial 0.0.1 development pre-alpha testing");
	SetDeathMessages(false);
	SetDisableDriveby(false);
	SetFastSwitch(false);
	SetFrameLimiter(true);
	SetFriendlyFire(true);
	SetGameModeName("Infected City 0.0a");
	SetTimeRate(1000);
	SetJoinMessages(false);
	SetJumpSwitch(false);
	SetKillDelay(255);
	SetServerPassword("cod modern warfare 3");
	SetShowOnlyTeamMarkers(true);
	SetShootInAir(true);
	//TODO: Password, load map, and store data.
}

function onScriptUnload()
{
}

function onPlayerJoin( player )
{
	PLAYERS[player.ID ] = SPlayer(player);
	PLAYERS[player.ID].Load();
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