/*

	All killstreaks

*/
function Killstreak_GetKills(id)
{
	switch(id)
	{
		case 1: return 2;
		case 2: return 3;
		case 3: return 3;
		case 4: return 4;
		case 5: return 5;
		case 6: return 5;
		case 7: return 5;
		case 8: return 6;
		case 9: return 7;
		case 10: return 7;
		case 11: return 8;
		case 12: return 9;
		case 13: return 9;
		case 14: return 10;
		case 15: return 10;
		case 16: return 11;
		case 17: return 12;
		case 18: return 13;
		case 19: return 14;
		case 20: return 15;
		case 21: return 20;
		default: return -1;
	}
}
function Killstreak_GetName(id)
{
	switch(id)
	{
		case 1: return "UAV Radar";
		case 2: return "Counter UAV";
		case 3: return "Armour vests";
		case 4: return "Care package";
		case 5: return "Predator missile";
		case 6: return "Remote sentry";
		case 7: return "Zombie drop";
		case 8: return "A10 Airstrike";
		case 9: return "Stealth Bomber";
		case 10: return "Tank";
		case 11: return "Support Juggernaut";
		case 12: return "Emergency Airdrop";
		case 13: return "AC-130";
		case 14: return "Chopper Gunner";
		case 15: return "White Phosphorus";
		case 16: return "Zombie Giant Drop";
		case 17: return "Osprey Gunner";
		case 18: return "Assault Juggernaut";
		case 19: return "EMP";
		case 20: return "M.O.A.B Broken Arrow";
		case 21: return "Tactcal Nuke";
		default: return null;
	}	
}
function Killstreak_Give(player,id)
{
	::Message(::GREEN+"Player "+player.Name+" just got an "+Killstreak_GetName(id));
	::Stream.StartWrite();
	::Stream.WriteByte(1);
	::Stream.WriteInt(id);
	::Stream.SendStream(player);
}

function Killstreak_Activate(player,killstreak,coords)
{
	switch(killstreak)
	{
		case -1:
		{
			return;
		}
		case 1:
		{
			UAV_Activate();
			break;
		}
		case 2:
		{
			CUAV_Activate();
			break;
		}
		case 4:
		{
			CarePackage_Activate(player);
			break;
		}
		case 18:
		{
			AssaultJuggenaut_Give(player);
			break;
		}
		case 19:
		{
			EMP_Activate();
			break;
		}
		case 21:
		{
			Nuke_Activate(player);
			break;
		}
		default: 
		{
			::Message(RED+"Error: Unknown killstreak used! Parameters:"+player+" "+killstreak+" "+coords);
			break;
		}
	}
	PLAYERS[player.ID].XP += 100;
	::MessagePlayer("XP + 100",player);
}

/*
	UAV
*/
UAV_TIMER <- -1;
function UAV_Activate()
{
	UAV_TIMER = 60;
	::Stream.StartWrite();
	::Stream.WriteByte(5);
	::Stream.SendStream(null);
}
function UAV_Update()
{
	if(UAV_TIMER != -1)
	{
		UAV_TIMER -= 1;
		if(UAV_TIMER == 0) CUAV_Activate();
	}
}
/*

	CUAV
	
*/
function CUAV_Activate()
{
	::Stream.StartWrite();
	::Stream.WriteByte(6);
	::Stream.SendStream(null);
}
/*

	Care Package

*/
CAREPACKAGE_AIRPLANE <- CreateObject(638,0,Vector(0,0,0),255).ID;
CAREPACKAGE_TIMER <- 0;
function CarePackage_Activate(player)
{
	player.GiveWeapon(107,1);
	::MessagePlayer(RED+"Use this to mark the care package's location!",player);
}
function CarePackage_Drop(player,coords)
{
	if(CAREPACKAGE_TIMER == 0)
	{
		local airplane = FindObject(CAREPACKAGE_AIRPLANE);
		airplane.Pos = coords + Vector(200,200,40);
		airplane.MoveTo(coords + Vector(-200,-200,40),15000);
		CAREPACKAGE_TIMER = 15;
		airplane.RotateToEuler(Vector(0,0,0.75*PI),0);
		CreateCarePackages(coords,1);
		::Message(RED+player+" has a airdrop incoming!");
	}
	else
	{
		player.GiveWeapon(107,1);
		::MessagePlayer(RED+"Care package not avalable, try again!",player);
	}
}
function CarePackage_Update()
{
	if(CAREPACKAGE_TIMER > 0) CAREPACKAGE_TIMER -= 1;
}
function CreateCarePackages(coords,q)
{
	for(local i =0 ; i < q;i++)
	{
		CreateCarePackage(coords+Vector(1*(q-1),1*(q-1),0));
	}
}
function CreateCarePackage(coords)
{
	local r = rand() % 10, id = 335;
	//335 - killstreak (80 %)
	//405 - ammo (10 %)
	//368 - armour (10 %)
	if(r == 9) id = 368;
	if(r == 8) id = 405;
	CreatePickup(id,0,1,coords+Vector(0,0,2),255,true);
}

/*

	Predator Missile

*/
PREDMIS_OBJ <- ::CreateObject(273,0,Vector(0,0,0),255).ID;
PREDMIS_PLR <- -1;

function PredatorMissile_Activate(player,coords)
{
	if(PREDMIS_PLR == -1)
	{
		PREDMIS_PLR = player.ID;
		FindObject(PREDMIS_OBJ).RotateToEuler(Vector(0,3.1415926/2,0),0);
		FindObject(PREDMIS_OBJ).Pos = coords + Vector(0,0,100);
	}
	
}
function PredatorMissile_Update()
{
	if(PREDMIS_PLR != -1)
	{
		local p = FindObject(PREDMIS_OBJ).Pos;
		FindObject(PREDMIS_OBJ).Pos.z -= 1;
		FindPlayer(PREDMIS_PLR).SetCameraPos(FindObject(PREDMIS_OBJ).Pos+Vector(0,0,10),FindObject(PREDMIS_OBJ).Pos);
		if(p.z < 10)
		{
			for(local i =0 ; i < 100;i++)
			{
				local victim = FindPlayer(i);
				if(victim != null)
				{
					if(DistanceFromPoint(p.x,p.y,victim.Pos.x,victim.Pos.y) < 50)
					{
						onPlayerKill(FindPlayer(PREDMIS_PLR),victim,-3,1);
						victim.Health = 0;
						victim.Armour = 0;
					}
				}
			}
			for(local j =0 ; j < 1000; j++)
			{
				if(FindVehicle(j) != null)
				{
					local v = FindVehicle(j);
					if(::DistanceFromPoint(v.Pos.x,v.Pos.y,p.x,p.y) < 50)
					{
						v.Health = 0;
						v.KillEngine();
					}
				}
			}
			::CreateExplosion( 0, 7, p, PREDMIS_PLR, true);
			::FindObject(PREDMIS_OBJ).Pos = Vector(0,0,0);
			::FindPlayer(PREDMIS_PLR).RestoreCamera();
			PREDMIS_PLR = -1;
		}
	}
}

/*

	Osprey Gunner

*/
OSPREY_TIMER <- 0;
function Osprey_Activate(player)
{
	
}
/*

	Assault Juggernaut

*/
function AssaultJuggenaut_Give(player)
{
	player.Health = 255;
	player.Armour = 255;
	//player.Skin = ???;
	PLAYERS[player.ID].JuggernautHealth = 10000;
	player.GiveWeapon(11,1);
	player.GiveWeapon(12,11);
	player.GiveWeapon(18,66);
	player.GiveWeapon(26,330);
	player.GiveWeapon(33,9999);
}

/*

	EMP

*/
EMP_TIMER <- 0;
function EMP_Activate()
{
	for(local i =0 ; i < 1000;i++)
	{
		local v = FindVehicle(i);
		if(v != null) v.Kill();
	}
	::Stream.StartWrite();
	::Stream.WriteByte(2);
	::Stream.WriteInt(30);
	::Stream.SendStream(null);
		
	//Disable al HUDs for 2 minutes		
		
	::Stream.StartWrite();
	::Stream.WriteByte(3);
	::Stream.SendStream(null);
	EMP_TIMER += 120;
}
function EMP_Update()
{
	if(EMP_TIMER > 0) EMP_TIMER -= 1;
	if(EMP_TIMER == 0)
	{
		//Enable HUDs
		::Stream.StartWrite();
		::Stream.WriteByte(4);
		::Stream.SendStream();
		EMP_TIMER = -1;
	}
}

/*

	M.O.A.B Broken Arrow

*/
function MOAB_Activate(player,coords)
{
	for(local i =0 ; i < 1000;i++)
	{
		local v = FindVehicle(i);
		if(v != null)
		{
			if(::DistanceFromPoint(v.Pos,coords) <= 1000)
			{
				v.Explode();
			}
		}
	}
	for(local i =0 ; i < 100;i++)
	{
		local victim = FindPlayer(i);
		if(victim != null)
		{
			if(DistanceFromPoint(victim.Pos,coords) <= 1000)
			{
				::Stream.StartWrite();
				::Stream.WriteByte(2);
				::Stream.SendStream(victim);
				onPlayerKill(FindPlayer(NUKE_CALLER),victim,-2,0)
				victim.Kill();
			}
		}
	}
}

/*

	Tactical Nuke Killstreak!

*/
NUKE_TIMER <- -100;
NUKE_CALLER <- -1;

function Nuke_Activate(player)
{
	NUKE_TIMER = 10;
	NUKE_CALLER = player.ID;
}
function Nuke_Update()
{
	if(NUKE_TIMER == -100) return;
	NUKE_TIMER -= 1;
	if(NUKE_TIMER >= 0)
	{
		::PlaySoundAllPlayers(50003);
		::Message(::RED+"Tactical nuke countdown: "+NUKE_TIMER);
	}
	if(NUKE_TIMER == 5)
	{
		//Slow down the game.
		::SetGamespeed(0.5);
	}
	if(NUKE_TIMER == 1)
	{
		//Fade player's screen to white (send packet).
		::Stream.StartWrite();
		::Stream.WriteByte(2);
		::Stream.WriteInt(60);
		::Stream.SendStream(null);
	}
	if(NUKE_TIMER == 0)
	{
		//kaboom
		::Stream.StartWrite();
		::Stream.WriteByte(3);
		::Stream.SendStream(null);
		::SetGamespeed(1);
		for(local i =0 ; i < 1000;i++)
		{
			local v = FindVehicle(i);
			if(v != null) v.Kill();
		}
		for(local i =0 ; i < 100;i++)
		{
			local victim = FindPlayer(i);
			if(victim != null)
			{
				::onPlayerKill(FindPlayer(NUKE_CALLER),victim,-1,0)
				victim.Kill();
			}
		}
	}
	if(NUKE_TIMER < 0)
	{
		::SetTime(0,0);
		::SetWeather(94);
		::SetTimeRate(0);
	}
	if(NUKE_TIMER == -60)
	{
		::Stream.StartWrite();
		::Stream.WriteByte(4);
		::Stream.SendStream(null);
		::SetTime(12,0);
		::SetWeather(4);
		::SetTimeRate(1000);
		NUKE_TIMER = -100;
	}
}
function CPlayer::Kill()
{
	this.Eject();
	this.Health = 0;
	this.Armour = 0;
	this.Immunity = 0;
}

function PlaySoundAllPlayers(sound)
{
	for(local i =0 ; i < 100;i++)
	{
		if(FindPlayer(i) != null) {
			FindPlayer(i).PlaySound(sound);
			FindPlayer(i).PlaySound(sound);
			FindPlayer(i).PlaySound(sound);
		    FindPlayer(i).PlaySound(sound);
		}
	}
}

function MapCoordsToWorld(sx,sy,x,y)
{
	local b = GetWorldBounds();
	print(b.MinX+" "+b.MaxX+" "+b.MinY+" "+b.MaxY); 
	
	local rx = x / sx;
	local ry = y / sy;
	
	local rnx = 3900 * rx;
	local rny = 3900 * ry;
	
	print(rx+" "+ry + " "+rnx+" "+rny);
	
	local r = Vector(b.MinX + rnx,b.MinY + rny,12);
	print(r);
	return r;
}