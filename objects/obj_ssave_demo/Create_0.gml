// See scr_ssave_demo for ConfigFile/SaveFile implementation

#region example config

config = new ConfigFile();
config.load();

config.set("subtitles", false);

config.save();

#endregion

#region multiple of the same SSave

// 1
save1 = new SaveFile();
save1.load("1");

save1.set("level", 69);

// 2
save2 = new SaveFile();
save2.load("2");

save2.set("name", "stoobert stoozington the third");

// 3
save3 = new SaveFile();
save3.load("3");

save3.set("awesome", true); // :)

// dont forget to save!!!
save1.save("1");
save1.save("2");
save1.save("3");
#endregion