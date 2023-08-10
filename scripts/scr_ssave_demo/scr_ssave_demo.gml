function ConfigFile() : SSave("config") constructor
{
	add_value("saveIndex", SSAVE_TYPE.REAL, 0);
}

function SaveFile() : SSave("save") constructor
{
	add_value("name", SSAVE_TYPE.STRING, "");
	add_value("playtime", SSAVE_TYPE.REAL, 0);
	add_value("x", SSAVE_TYPE.REAL, 512);
	add_value("y", SSAVE_TYPE.REAL, 300);
}