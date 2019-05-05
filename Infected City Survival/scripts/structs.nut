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

class Zombie //Zombie class. No need for the type field since it's specified by the Name.
{
	Object = -1;
	Name = 0;
	Health = 0;
	Damage = 0;
	Movement = 0;
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
function Car::Unload()
{
	this.GetInstance().Delete();
	this.Owner = "";
	this.Fuel = 0;
	this.NOS = 0;
}