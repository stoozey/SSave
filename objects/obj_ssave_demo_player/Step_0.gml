// lerp animation values
blockHeightOffset = lerp(blockHeightOffset, 0, 0.15);
coinAnim  = lerp(coinAnim, 0, 0.1);

// handle player state
switch (playerState) {
	case PLAYER_STATE.IDLE:
        // if pressing space, begin the jump
		if (keyboard_check_pressed(vk_space))
			playerState = PLAYER_STATE.JUMP_UP;
		break;
	
	case PLAYER_STATE.JUMP_UP:
        // move player up until they reach the block
		var _jumpSpeed = 8;
		playerHeightOffset -= _jumpSpeed;
        
        var _maxY = -32;
		if (playerHeightOffset > _maxY) break;
		
        // start falling
		playerState = PLAYER_STATE.JUMP_DOWN;
		break;
	
	case PLAYER_STATE.JUMP_DOWN:
        // make player fall, allowing it a little early if theyre still pressing space
		var _fallSpeed = 8;
		playerHeightOffset += _fallSpeed;
    
        var _groundY = 0;
		if (playerHeightOffset <= _groundY) break;
		
        // reset player
		playerHeightOffset = 0;
		playerState = PLAYER_STATE.IDLE;
		
        // move block up for hit animation
		blockHeightOffset = -16;
	    
        // begin coin animation and assign random coin index
		coinAnim = 1;
		coinIndex = irandom(sprite_get_number(spr_ssave_demo_coin) - 1);
        
        // calculate coin value and increment manager's value with it
        var _coinIncrement = GetCoinAmount();
		with (obj_ssave_demo_manager)
            IncrementCoins(_coinIncrement);
		break;
}