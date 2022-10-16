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

save2.set("name", "stoobert stoozington the third");

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
	.set_protection(SSAVE_PROTECTION.ENCODE)
	.save("2");
	
save3
	.set_protection(SSAVE_PROTECTION.ENCRYPT)
	.save("3");
	
#endregion