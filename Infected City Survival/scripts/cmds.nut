function onPlayerCommand( player, cmd, text )
{
	cmd = cmd.tolower();
	local plr = PLAYERS[player.ID];
	switch(cmd) 
	{
		case "help":
		{
			switch(text)
			{
				case "1":
				{
					MessagePlayer(RED+"Help Page 1: General Gameplay",player);
					MessagePlayer(WHITE+"Kill other players, zombies, monsters, steal items, find resources in order to survive.",player);
					MessagePlayer(WHITE+"There are 5 roles: civillian, soldier,medic,agent and zombie.",player);
					MessagePlayer(WHITE+"Use /help 2 for the next page.",player);
					break;
				}
				case "2":
				{
					MessagePlayer(RED+"Help Page 2: Civillian role",player);
					MessagePlayer(WHITE+"Short: defend yourself from threats like players and monsters.",player);
					MessagePlayer(WHITE+"As a civillian you have to find a safe place, claim it, and defend it and yourself.",player);
					MessagePlayer(WHITE+"To claim a base you can see /help 7",player);
					MessagePlayer(WHITE+"Use /help 3 for the next page.",player);
					break;
				}
				case "3":
				{
					MessagePlayer(RED+"Help Page 3: Soldier role",player);
					MessagePlayer(WHITE+"Short: Your objective is to secure, contain and protect the city.",player);
					MessagePlayer(WHITE+"Your main objective is protecting the military base from zombies and agents.",player);
					MessagePlayer(WHITE+"Your secondary objective is keeping the city clean.",player);
					MessagePlayer(WHITE+"Use /help 4 for the next page.",player);
					break;
				}
				case "4":
				{
					MessagePlayer(RED+"Help Page 4: Medic role",player);
					MessagePlayer(WHITE+"Short: Your  objective is healing players.",player);
					MessagePlayer(WHITE+"Your main objective is healing the players from infections and wounds.",player);
					MessagePlayer(WHITE+"You will have to defent the hospitals too.",player);
					MessagePlayer(WHITE+"Use /help 5 for the next page.",player);
					break;
				}
				case "5":
				{
					MessagePlayer(RED+"Help Page 5: Agent role",player);
					MessagePlayer(WHITE+"Short: Infect the city.",player);
					MessagePlayer(WHITE+"Your main objective is spreading zombies around the map.",player);
					MessagePlayer(WHITE+"Use /help 6 for the next page.",player);
					break;
				}
				case "6":
				{
					MessagePlayer(RED+"Help Page 6: Zombie role",player);
					MessagePlayer(WHITE+"Short: Infect other players.",player);
					MessagePlayer(WHITE+"Your main objective is infecting other players.",player);
					MessagePlayer(WHITE+"You can get this role only by dying from an infection made by a zombie.",player);
					MessagePlayer(WHITE+"Use /help 7 for the next page.",player);
					break;
				}
				case "7":
				{
					MessagePlayer(RED+"Help Page 7: Aerial support<1/2>",player);
					MessagePlayer(WHITE+"Soldiers and agents will be seen using them mostly.",player);
					MessagePlayer(WHITE+"There are 6 aerial support vehicles:",player);
					MessagePlayer(WHITE+"1.) UAV Radar - shows zombies on the map.",player);
					MessagePlayer(WHITE+"2.) Predator missile - Fire a predator missile from above.",player);
					MessagePlayer(WHITE+"3.) Reaper AGM - Fire multiple missiles from above.",player);
					MessagePlayer(WHITE+"4.) Airstrike - Fire multiple missiles from above.",player);
					MessagePlayer(WHITE+"5.) Osprey Gunner - Drop packages with loot and defend them.",player);
					MessagePlayer(WHITE+"6.) Emercency airdrop - Drop packages in a area.",player);
					MessagePlayer(WHITE+"Use /help 8 for the next page.",player);
					break;
				}
				case "8":
				{
					MessagePlayer(RED+"Help Page 8: Aerial support<2/2>",player);
					MessagePlayer(WHITE+"You can get aerial support by:",player);
					MessagePlayer(WHITE+"1.) Buying them in the weapon shop",player);
					MessagePlayer(WHITE+"2.) Care packages from emergency airdrops and Osprey gunners.",player);
					MessagePlayer(WHITE+"Use /help 9 for the next page.",player);
					break;
				}
				case "9":
				{
					MessagePlayer(RED+"Help Page 9: Bases",player);
					MessagePlayer(WHITE+"Bases are actually properties.",player);
					MessagePlayer(WHITE+"You can claim a base by:",player);
					MessagePlayer(WHITE+"1.) Raiding a base: kill the owners, and using /claimbase ",player);
					MessagePlayer(WHITE+"2.) Use /claimbase on a unclaimed base.",player);
					break;
				}
				case "10":
				{
					MessagePlayer(RED+"Help Page 10: Other stuff",player);
					MessagePlayer(WHITE+"If you are confused use /tutorial.",player);
					break;
				}
				default: 
				{
					MessagePlayer(WHITE+"Use /help <1-10>",player);
					break;
				}
			}
			break;
		}
		case "tutorial":
		{
			//Show the player the places, and explain everything.
			MessagePlayer(WHITE+"NOT IMPLEMENTED.",player);
			break;
		}
		case "claimbase":
		{
			//Use a timer = 1 minute, and make the player protect the base.
			MessagePlayer(WHITE+"NOT IMPLEMENTED.",player);
			break;
		}
		
		
		///ADMIN CMDS:
		case "reloadscripts":
		{
			if(plr.AdminLevel != 3) return 0;
			Message(WHITE+"Reloading map.");
			LoadMap();
			break;
		}
		case "pos":
		{
			if(plr.AdminLevel != 3) return 0;
			Message(""+player.Pos);
			break;
		}
		case "createobj":
		{
			local args = array(10,"");
			for(local i =0 ; i < 10;i++)
			{
				local t = GetTok(text," ",i+1);
				if(t) args[i] = t;
				else args[i] = "0";
			}
			if(plr.AdminLevel != 3) return 0;
			try
			{
				local ret = CreateMapItem(args[0].tointeger(),player,args[1].tointeger(),args[2].tointeger(),args[3].tointeger(),args[4].tointeger(),args[5].tointeger());
				MessagePlayer(ret+"",player);
			}
			catch(e) 
			{
				MessagePlayer("DEBUG: Error on command: createobj :"+e,player);
			}
			break;
		}
		case "movobj":
		{
			if(plr.AdminLevel != 3) return 0;
			local args = array(3,"");
			for(local i =0 ; i <  3; i++)
			{
				try
				{
					args[i] = GetTok(text," ",1).tofloat();
				}
				catch(e) 
				{
					MessagePlayer("args["+i+"] Error:"+e,player);
				}
			}
			MoveMapItem(args[0],args[1],args[2]);
			break;
		}
		case "undoobj":
		{
			if(plr.AdminLevel != 3) return 0;
			UndoMapItem();
			break;
		}
		case "savemap":
		{
			if(plr.AdminLevel != 3) return 0;
			SaveMap();
			break;
		}
		case "goto":
		{
			player.Pos = FindPlayer(text).Pos;
			break;
		}
		case "bring":
		{
			 FindPlayer(text).Pos = player.Pos ;
			break;
		}
		default:
		{
			MessagePlayer(RED+"Invalid command! See /cmds.",player);
			break;
		}
	}
	return 1;
}

enum StreamData
{
	//TODO: implement stream data enum.
}
function onClientScriptData( player )
{
	local num = Stream.ReadInt();
	local str = Stream.ReadString();
	switch(num)
	{
		default: break;
	}
}