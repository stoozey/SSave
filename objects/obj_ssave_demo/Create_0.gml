Save = function()
{
	with (obj_ssave_demo_player)
	{
		static config = ssave_get(ConfigFile);
		
		ssave_get(SaveFile, config.get("saveIndex"))
        .set("x", x)
        .set("y", y)
        .set("name", name)
		.set("playtime", playtime)
		.save();
	}
}

instance_create_depth(0, 0, 0, obj_ssave_demo_player);