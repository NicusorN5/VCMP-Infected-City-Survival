MAP_FILE <- "Map.nut";

dofile(MAP_FILE,true);
Map();

MAP_EDIT_PLR <- -1;
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
		if(FindMarker(i)) FindMarker(i).Delete();
	}
}
function SaveMap()
{
	system("del "+MAP_FILE);
	for(local i =0 ; i < 3000;i++)
	{
		local o = FindObject(i);
		if(o) TXTAddLine("CreateObject("+o.Model+","+o.World+","+o.Pos+","+o.Alpha+")");
	}
	for(local i =0 ; i < 2000;i++)
	{
		local o = FindObject(i);
		if(o) TXTAddLine("CreatePickup("+o.Model+","+o.World+"","+o.Pos+","+o.Alpha+",true)");
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
