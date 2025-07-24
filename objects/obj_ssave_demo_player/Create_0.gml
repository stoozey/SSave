enum PLAYER_STATE {
	IDLE,
	JUMP_UP,
	JUMP_DOWN
}

GetCoinAmount = function() {
	return ((1 + coinIndex) * 100);
}

playerState = PLAYER_STATE.IDLE;
playerHeightOffset = 0;

blockHeightOffset = 0;

coinAnim = 0;
coinIndex = 0;

var _font = font_add("Early GameBoy.ttf", 16, true, false, 32, 128);
draw_set_font(_font);