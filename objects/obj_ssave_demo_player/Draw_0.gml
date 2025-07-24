#macro FLOOR_X 320
#macro FLOOR_Y 256

#macro PLAYER_X (FLOOR_X - (sprite_get_width(spr_ssave_demo_player_idle) * 0.25))
#macro PLAYER_BASE_Y (FLOOR_Y - sprite_get_height(spr_ssave_demo_player_idle))
#macro BLOCK_Y (PLAYER_BASE_Y - 38)
#macro COIN_ANIM_HEIGHT 64

#macro COIN_X (FLOOR_X + (sprite_get_width(spr_ssave_demo_coin) * 0.5))
#macro COIN_BASE_Y (BLOCK_Y - sprite_get_height(spr_ssave_demo_block))

// player
var _subImg = (current_time / 250);
var _playerY = (PLAYER_BASE_Y + playerHeightOffset);
var _spriteIndex;
switch (playerState) {
	case PLAYER_STATE.IDLE: _spriteIndex = spr_ssave_demo_player_idle; break;
	case PLAYER_STATE.JUMP_UP: _spriteIndex = spr_ssave_demo_player_jump_up; break;
	case PLAYER_STATE.JUMP_DOWN: _spriteIndex = spr_ssave_demo_player_jump_down; break;
}

draw_sprite(_spriteIndex, _subImg, PLAYER_X, _playerY);

// block
var _blockY = (BLOCK_Y + blockHeightOffset);
draw_sprite(spr_ssave_demo_block, 0, FLOOR_X, _blockY);

// coin
var _coinAnimInverted = (1 - coinAnim); 
var _coinY = (COIN_BASE_Y - (COIN_ANIM_HEIGHT * _coinAnimInverted));
var _coinScale = (1 + (coinAnim * 0.5 + (0.5 * coinIndex)));
var _coinAngle = (-45 + (60 * coinAnim * ((coinIndex % 2 == 0) ? 1 : -1)));
draw_sprite_ext(spr_ssave_demo_coin, coinIndex, COIN_X, _coinY, _coinScale, _coinScale, _coinAngle, c_white, coinAnim);

// text
draw_set_colour(c_black);
draw_set_alpha(coinAnim * 1.5);
	var _textAmount = GetCoinAmount();
	var _textY = (BLOCK_Y - 16 - (64 * _coinAnimInverted));
	var _textScale = (1 + (coinAnim * (coinIndex + 1)));
	draw_text_transformed(FLOOR_X + 76, BLOCK_Y - 16, ("+" + string(_textAmount)), _textScale, _textScale, -20);
draw_set_alpha(1);
draw_set_colour(c_white);
