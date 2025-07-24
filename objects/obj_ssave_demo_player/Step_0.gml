blockHeightOffset = lerp(blockHeightOffset, 0, 0.15);
coinAnim  = lerp(coinAnim, 0, 0.1);

switch (playerState) {
	case PLAYER_STATE.IDLE:
		if (keyboard_check_pressed(vk_space))
			playerState = PLAYER_STATE.JUMP_UP;
		break;
	
	case PLAYER_STATE.JUMP_UP:
		var _jumpSpeed = 8;
		playerHeightOffset -= _jumpSpeed;
		if (playerHeightOffset > -32) break;
		
		playerState = PLAYER_STATE.JUMP_DOWN;
		break;
	
	case PLAYER_STATE.JUMP_DOWN:
		var _gravity = 8;
		playerHeightOffset += _gravity;
		if (playerHeightOffset <= -8) break;
		
		playerHeightOffset = 0;
		playerState = PLAYER_STATE.IDLE;
		
		blockHeightOffset = -16;
		
		var _totalCoins = sprite_get_number(spr_ssave_demo_coin);
		coinAnim = 1;
		coinIndex = irandom(_totalCoins - 1);
		obj_ssave_demo.totalCoins += GetCoinAmount();
		break;
}