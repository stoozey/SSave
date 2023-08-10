var i = 0;
repeat (10)
{
    if (keyboard_check_pressed(ord(i)))
    {
		Save();
		
        ssave_get(ConfigFile)
			.set("saveIndex", i);
		
        with (obj_ssave_demo_player)
            Load();
		
        break;
    }
    
    i++;
}