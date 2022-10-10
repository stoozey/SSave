Config = function() : SSave("config") constructor
{
	add_value("volume_music", SSaveValueType.Real, 0.75);
	add_value("volume_sfx", SSaveValueType.Real, 1);
	
	add_value("subtitles", SSaveValueType.Boolean, true);
}

Save = function() : SSave("save") constructor
{
	
}