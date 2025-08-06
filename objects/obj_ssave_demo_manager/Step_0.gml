// increment playtime
playtime += (delta_time / 1_000_000);

// check for keys 1-3 and load the matching save slot
var _key = 1;
repeat (3) {
	if (keyboard_check_pressed(ord(_key)))
		Load(_key);
	
	_key++;
}