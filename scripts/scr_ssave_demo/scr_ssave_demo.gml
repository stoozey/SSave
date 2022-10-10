function ConfigFile() : SSave("config") constructor
{
	add_value("volume_music", SSaveValueType.Real, 0.75);
	add_value("volume_sfx", SSaveValueType.Real, 1);
	
	add_value("subtitles", SSaveValueType.Boolean, true);
}

function SaveFile() : SSave("save") constructor
{
	add_value("level", SSaveValueType.Real, 1);
	add_value("name", SSaveValueType.String, "stoozey_");
	add_value("awesome", SSaveValueType.Boolean, false);
}