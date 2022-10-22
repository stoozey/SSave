show_message_async("Go to \"%localappdata%\\" + game_project_name + "\" to see the files that have been saved!");

// See scr_ssave_demo for ConfigFile/SaveFile implementation

#region example ConfigFile

config = new ConfigFile();
config.load();

config.set("subtitles", false);

config.save();

#endregion

#region example SaveFile - multiple of the same SSave

// 1
save1 = new SaveFile();
save1.load("1");

save1 // supports chaining
	.set("level", 69)
	.set("inventory", [ "sword", "tophat" ]);

// 2
save2 = new SaveFile();
save2.load("2");

var _buffer = save2.get("example_buffer");
show_message(buffer_read(_buffer, buffer_u16));
show_message(buffer_read(_buffer, buffer_string));

save2.set("name", "stoobert stoozington the third");

var _exampleBuffer = buffer_create(256, buffer_fixed, 1);
buffer_write(_exampleBuffer, buffer_u16, 13369);
buffer_write(_exampleBuffer, buffer_string, "helloooooo");
save2.set("example_buffer", SSAVE_TYPE.BUFFER, _exampleBuffer);


// 3
save3 = new SaveFile();
save3.load("3");

save3.set("awesome", true);

#endregion
	
#region example of SSAVE_PROTECTION
	
save1
	.set_protection(SSAVE_PROTECTION.NONE)
	.save("1");
	
save2
	.set_protection(SSAVE_PROTECTION.NONE)
	.save("2");
	
save3
	.set_protection(SSAVE_PROTECTION.ENCRYPT)
	.save("3");
	
#endregion