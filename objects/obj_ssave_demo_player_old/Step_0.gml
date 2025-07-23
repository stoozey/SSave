playtime += (delta_time / 1000000);

var _moveSpeed = 4;
var _xAxis = ((keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A"))));
var _yAxis = ((keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W"))));
x += (_xAxis * _moveSpeed);
y += (_yAxis * _moveSpeed);

switch (_xAxis)
{
	case 1: sprite_index = spr_ssave_demo_player_right; break;
	case -1: sprite_index = spr_ssave_demo_player_left; break;
}

switch (_yAxis)
{
	case 1: sprite_index = spr_ssave_demo_player_down; break;
	case -1: sprite_index = spr_ssave_demo_player_up; break;
}

var _moving = ((_xAxis | _yAxis) != 0);
if (_moving)
{
	image_speed = 0.33;
}
else
{
	image_speed = 0;
	image_index = 0;
}