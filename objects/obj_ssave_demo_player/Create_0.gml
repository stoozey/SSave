/*
 * this object isn't important for anything SSave related,
 * see `obj_ssave_demo_manager` and `scr_ssave_demo_saves` for SSave implementation
 */

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

// load font
var _font = font_add("Early GameBoy.ttf", 10, true, false, 32, 128);
draw_set_font(_font);

// enlarge and centre window
var _displayWidth = display_get_width();
var _displayHeight = display_get_height();
var _baseWindowWidth = 640;
var _baseWindowHeight = 360;
var _scale = max(1, (min((_displayWidth / _baseWindowWidth), (_displayHeight / _baseWindowHeight)) - 1));
var _windowWidth = (_baseWindowWidth * _scale);
var _windowHeight = (_baseWindowHeight * _scale);
window_set_size(_windowWidth, _windowHeight);

var _windowX = ((_displayWidth - _windowWidth) * 0.5);
var _windowY = ((_displayHeight - _windowHeight) * 0.5);
window_set_position(_windowX, _windowY);