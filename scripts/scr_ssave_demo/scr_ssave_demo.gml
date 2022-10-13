function ConfigFile() : SSave("config") constructor
{
	add_value("volume_music", SSAVE_TYPE.REAL, 0.75);
	add_value("volume_sfx", SSAVE_TYPE.REAL, 1);
	
	add_value("subtitles", SSAVE_TYPE.BOOLEAN, true);
}

function SaveFile() : SSave("save") constructor
{
	add_value("level", SSAVE_TYPE.REAL, 1);
	add_value("name", SSAVE_TYPE.STRING, "stoozey_");
	add_value("awesome", SSAVE_TYPE.BOOLEAN, false);
}