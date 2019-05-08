class SPlayer //SPlayer stands for Server-Player. What a creative name
{
	constructor(p)
	{
		Player = p;
	}
	Player = ""; //uses player Name.
	Cash = 0; //useless since we use a 32 bit server xd
	Inventory = array(60,-1); //inventory items. ID is model ID.
	Cars = array(5,-1);
	Password = "";
	Hunger = 0;
	Thirst = 0;
	IP = "";
	Infected = false;
}
function SPlayer::GetInstance()
{
	return ::FindPlayer(this.Player);
} 
function SPlayer::Load() //called when player joins. Supposed to load it's data: inventory, cars, stuff like that.
{
	
}
function SPlayer::Register() //called if player is new.
{
	
}
function SPlayer::Login() //called if an player joins but with a different IP.
{
	
}
function SPlayer::UpdateM() //UpdateM - Update every Minute
{
	this.Hunger -= 1;
	this.Thirst -= 2;
	if(this.Hunger <= 0) this.Kill();
	if(this.Thirst <= 0) this.Kill();
	//Update any client-side data if any.
}
function SPlayer::Kill()
{
	local player = this.GetInstance();
	player.Health =0;
	player.Eject();
}
function SPlayer::SaveStats()
{
	
}
enum ZombieTypes
{
	Zombie = 0,
	Crawler = 1,
	Mutant = 2,
	Giant = 3,
}
function GetZombieHealthType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return 100;
		case ZombieTypes.Crawler: return 50;
		case ZombieTypes.Mutant: return 200;
		case ZombieTypes.Giant: return 1000;
		default: return 50;
	}
}

///PERSONAL COMMENT: I KNOW I COULD HAVE USED AN ARRAY, BUT I'M USED TO REPEAT MY CODE WITH COPYPASTED FUNCTIONS XDDD

//Zombies will have 2 to 4 frames as a animation
function GetZombieSkinType_FirstFrame(type)
{
	switch(type)
	{
		//408 is a place holder.
		case ZombieTypes.Zombie: return 408;
		case ZombieTypes.Crawler: return 408;
		case ZombieTypes.Mutant: return 408;
		case ZombieTypes.Giant: return 408;
		default: return 408;
	}
}
function GetZombieSkinType_SecFrame(type)
{
	switch(type)
	{
		//408 is a place holder.
		case ZombieTypes.Zombie: return 408;
		case ZombieTypes.Crawler: return 408;
		case ZombieTypes.Mutant: return 408;
		case ZombieTypes.Giant: return 408;
		default: return 408;
	}
}
function GetZombieSkinType_ThirdFrame(type)
{
	switch(type)
	{
		//408 is a place holder.
		case ZombieTypes.Zombie: return 408;
		case ZombieTypes.Crawler: return 408;
		case ZombieTypes.Mutant: return 408;
		case ZombieTypes.Giant: return 408;
		default: return 408;
	}
}
function GetZombieSkinType_FourthFrame(type)
{
	switch(type)
	{
		//408 is a place holder.
		case ZombieTypes.Zombie: return 408;
		case ZombieTypes.Crawler: return 408;
		case ZombieTypes.Mutant: return 408;
		case ZombieTypes.Giant: return 408;
		default: return 408;
	}
}

///aaa
function GetZombieCashRewardType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return 1;
		case ZombieTypes.Crawler: return 2;
		case ZombieTypes.Mutant: return 5;
		case ZombieTypes.Giant: return 10;
		default: return 1;
	}
}
function GetZombieCashRewardType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return 1;
		case ZombieTypes.Crawler: return 2;
		case ZombieTypes.Mutant: return 5;
		case ZombieTypes.Giant: return 10;
		default: return 1;
	}
}
function GetZombieNameType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return "Zombie";
		case ZombieTypes.Crawler: return "Crawler";
		case ZombieTypes.Mutant: return "Mutant";
		case ZombieTypes.Giant: return "Giant";
		default: return 1;
	}
}
function GetZombieDMGType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return 25;
		case ZombieTypes.Crawler: return 5;
		case ZombieTypes.Mutant: return 50;
		case ZombieTypes.Giant: return 80;
		default: return 1;
	}
}
function GetZombieMOVType(type)
{
	switch(type)
	{
		case ZombieTypes.Zombie: return 0.3; //gameunits.
		case ZombieTypes.Crawler: return 0.4;
		case ZombieTypes.Mutant: return 0.2;
		case ZombieTypes.Giant: return 0.1;
		default: return 1;
	}
}
class Zombie //Zombie class. No need for the type field since it's specified by the Name.
{
	constructor(pos)
	{
		local type = rand() % 4;
		Object = ::CreateObject(GetZombieSkinType_FirstFrame(type),0,pos,255);
		Name = ::GetZombieNameType(type);
		Health = ::GetZombieHealthType(type);
		Damage = ::GetZombieDMGType(type);
		Movement = ::GetZombieMOVType(type);
		Frame = 0;
	}
	Object = -1;
	Name = 0;
	Health = 0;
	Damage = 0;
	Movement = 0;
	Frame = 0;
}
function Zombie::GetObject()
{
	return ::FindObject(this.Player);
}
function Zombie::Update() //this function controls the zombie's walking.
{
	
}
///events.
function Zombie::onDamagePlayer()
{
	
}
function Zombie::onShoot()
{
	
}
function Zombie::onRespawn()
{
	
}
class Car //Made this in order to store the owner, Fuel and NOS too
{
	Vehicle = -1;
	Owner = "";
	Fuel = 0;
	NOS = 0;
	NOS_Active = false;
}
function Car::GetInstance()
{
	return ::FindVehicle(this.Player);
}
function Car::Load()
{
	//Read the data from the db and spawn the car.
}
function Car::UpdateM()
{
	this.Fuel -= 1;
	//Code to stop the car from working if fuel == 0
}
function Car::ToogleNOS()
{
	NOS = !NOS;
}
function Car::Unload()
{
	this.GetInstance().Delete();
	this.Owner = "";
	this.Fuel = 0;
	this.NOS = 0;
}