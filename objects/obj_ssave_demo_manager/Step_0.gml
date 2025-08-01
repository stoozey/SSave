// increment playtime
playtime += (delta_time / 1_000_000);

if (keyboard_check_pressed(ord(0)))
    Load(0);
else if (keyboard_check_pressed(ord(1)))
    Load(1);
else if (keyboard_check_pressed(ord(2)))
    Load(2);