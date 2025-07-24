function ConfigFile() : SSave("config") constructor
{
	add_value("lastLoadedSlot", SSAVE_TYPE.REAL, 0);
	add_value("soundsEnabled", SSAVE_TYPE.BOOLEAN, true);
}

function SaveFile() : SSave("save") constructor
{
	add_value("name", SSAVE_TYPE.STRING, "");
	add_value("playtime", SSAVE_TYPE.REAL, 0);
	add_value("totalCoins", SSAVE_TYPE.REAL, 0);
}