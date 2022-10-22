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
	add_value("inventory", SSAVE_TYPE.ARRAY, [ "sword", "helmet" ]);
	add_value("awesome", SSAVE_TYPE.BOOLEAN, false);
	
	var _exampleBuffer = buffer_create(512, buffer_fixed, 1);
	buffer_write(_exampleBuffer, buffer_u16, 21);
	buffer_write(_exampleBuffer, buffer_string, "nope");
	add_value("example_buffer", SSAVE_TYPE.BUFFER, _exampleBuffer);
}