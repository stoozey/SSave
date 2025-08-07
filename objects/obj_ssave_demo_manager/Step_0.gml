// increment playtime
playtime += (delta_time / 1_000_000);

// check for keys 1-3 and load the matching save slot
var _key = 1;
repeat (3) {
	if (keyboard_check_pressed(ord(_key)))
		Load(_key);
	
	_key++;
}

// toggle sound effects when pressing "M" key
if (keyboard_check_pressed(ord("M"))) {
	var _config = ssave_get(ConfigFile);
	var _soundsEnabled = _config.get("soundsEnabled");
	_config.set("soundsEnabled", !_soundsEnabled);
}