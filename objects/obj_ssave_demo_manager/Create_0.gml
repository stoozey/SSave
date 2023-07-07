#region example ConfigFile

ssave_get(ConfigFile)
	.set("subtitles", false)
	.save();

#endregion

#region example SaveFile - multiple of the same SSave

// 1
ssave_get(SaveFile, "1")  // supports chaining
	.set("level", 69)
	.set("inventory", [ "sword", "helmet" ]);

// 2
ssave_get(SaveFile, "2")
	.set("name", "stoobert stoozington the third");

// 3
ssave_get(SaveFile, "3")
	.set("awesome", true);

#endregion
	
#region example of SSAVE_PROTECTION
	
ssave_get(SaveFile, "1")
	.set_protection(SSAVE_PROTECTION.NONE)
	.save();
	
ssave_get(SaveFile, "2")
	.set_protection(SSAVE_PROTECTION.ENCODE)
	.save();
	
ssave_get(SaveFile, "3")
	.set_protection(SSAVE_PROTECTION.ENCRYPT)
	.save();
	
#endregion