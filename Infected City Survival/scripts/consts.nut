RED <- "[#ff0000]";
WHITE <- "[#ffffff]";
GREEN <- "[#00ff00]";
BLUE <- "[#0000ff]";
YELLOW <- "[#ffff00]";

PLAYERS <- array(100,null);

//todo: Global variables, and constats are here.


function GetTok(string, separator, n, ...)
{
	local m = vargv.len() > 0 ? vargv[0] : n, tokenized = split(string, separator), text = "";
	if (n > tokenized.len() || n < 1) return null;
	for (; n <= m; n++)
	{
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	}
	return text;
}
function GetWep(id)
{
	if(id == 100) return "Medkit";
	if(id == 101) return "ACR";
	if(id == 102) return "P90";
	if(id == 103) return "Glock-18";
	else return GetWeaponName(id);
}