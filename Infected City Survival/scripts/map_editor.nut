MAP_FILE <- "Map.nut";

dofile(MAP_FILE,true);
try{
Map();
}
catch(e) { print("<WARNING>Map doesnt exist.")}

MAP_EDIT_PLR <- -1; //Propably won't be used...
MAP_EDIT_OBJECTID <- -1;
enum ObjectTypes
{
	NoEntity = 0,
	Obj = 1,
	Pickup = 2,
	CheckPoint = 3,
	Car = 4,
	MapMarker = 5,
}
MAP_EDIT_OBJT <- ObjectTypes.NoEntity;

function LoadMap()
{
	CleanMap();
	ReloadScripts();
}
function CleanMap()
{
	for(local i =0; i < 5000; i++)
	{
		if(FindObject(i)) FindObject(i).Delete();
		if(FindPickup(i)) FindPickup(i).Delete();
		if(FindVehicle(i)) FindVehicle(i).Delete();
		if(FindCheckpoint(i)) FindCheckpoint(i).Delete();
		if(FindMarker(i)) DestroyMarker(i);
	}
}
function CreateMapItem(type,player,...) 
{
	if(!player) return -1; //'Null Pointer Reference' to player.
	local pos = player.Pos;
	if(type < 0 && type > 5) return -2; //Type is 'Out Of Range'
	switch(type)
	{
		case ObjectTypes.NoEntity: return 1 ; //OK.
		case ObjectTypes.Obj: //create object. 
		{
			local model = vargv[0];
			local alpha = vargv[1];
			if(vargv[1] == null) return -3; //Not enough Paramaters.
			local obj = CreateObject(model,player.World,player.Pos,alpha);
			local ID = obj.ID;
			if(!ID) return 0; // Unkonwn error.
			MAP_EDIT_OBJECTID = ID;
			MAP_EDIT_OBJT = type;
			return 1;
		}
		case ObjectTypes.Pickup: //create pickup. 
		{
			local model = vargv[0];
			local quantity = vargv[1];
			local alpha = vargv[2];
			if(vargv[2] == null) return -3; 
			local obj = CreatePickup(model,player.World,quantity,player.Pos,alpha);
			local ID = obj.ID;
			if(!ID) return 0;
			MAP_EDIT_OBJECTID = ID;
			MAP_EDIT_OBJT = type;
			return 1;
		}
		case ObjectTypes.CheckPoint: //create checkpoint. 
		{
			local c1 = vargv[0];
			local c2 = vargv[1];
			local c3 = vargv[2];
			local r = vargv[4];
			if(vargv[4] == null) return -3; 
			local obj = CreatePickup(model,player.World,true,player.Pos,ARGB(c1,c2,c3,c4),r);
			local ID = obj.ID;
			if(!ID) return 0; // Unkonwn error.
			MAP_EDIT_OBJECTID = ID;
			MAP_EDIT_OBJT = type;
			return 1;
		}
		case ObjectTypes.Car:
		{
			local model = vargv[0];
			local c1 = vargv[1];
			local c2 = vargv[2];
			if(vargv[0] == null) return -3;
			local car = CreateVehicle(model,world,pos,player.Angle,c1,c2);
			if(!ID) return 0;
			MAP_EDIT_OBJECTID = ID;
			MAP_EDIT_OBJT = type;
			return 1;
		}
	}
}
function SaveMap()
{
	system("del "+MAP_FILE);
	for(local i =0 ; i < 3000;i++)
	{
		local o = FindObject(i);
		if(o) {
			TXTAddLine("CreateObject("+o.Model+","+o.World+",Vector"+o.Pos+","+o.Alpha+");");
		}
	}
	for(local i =0 ; i < 2000;i++)
	{
		local p = FindPickup(i);
		if(p) TXTAddLine("CreatePickup("+p.Model+","+p.World+","+p.Quantity+",Vector"+p.Pos+","+p.Alpha+",true);");
	}
	for(local i =0 ; i < 2000;i++)
	{
		local c = FindCheckpoint(i);
		if(c) TXTAddLine("CreateCheckpoint(null,"+c.World+",true,Vector"+c.Pos+","+c.Color+","+c.Radius+",true);");
	}
	for(local i =0 ; i < 1000; i++)
	{
		local v = FindVehicle(i);
		if(v) TXTAddLine("CreateVehicle("+v.Model+","+v.World+",Vector"+v.Pos+",0,"+v.Colour1+","+v.Colour2+");");
	}
}
function TXTAddLine(filename, text)
{
 local fhnd = file(filename, "a+");
 foreach(char in text)
  fhnd.writen(char, 'c'); 
 
 fhnd.writen('\n', 'c');
 fhnd=null;
}
