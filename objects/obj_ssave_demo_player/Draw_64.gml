#macro SLOT_WIDTH 139
#macro SLOT_HEIGHT 64

#region draw coins display

var _coinX = 8;
var _coinY = 8;
var _coinWidth = sprite_get_width(spr_ssave_demo_coin_ui);
var _coinHeight = sprite_get_height(spr_ssave_demo_coin_ui);
draw_sprite(spr_ssave_demo_coin_ui, 0, _coinX, _coinY);

draw_set_colour(c_black);
draw_set_valign(fa_middle);
	var _textX = (_coinX + _coinWidth + 4);
	var _textY = (_coinY + (_coinHeight * 0.5));
	var _totalCoins = obj_ssave_demo_manager.totalCoins;
	draw_text_transformed(_textX, _textY, "Total Coins: " + string(_totalCoins), 1, 1, 0);
draw_set_valign(fa_top);
draw_set_colour(c_white);

#endregion

#region draw key bindings

draw_set_colour(c_black);
	var _keyBindingsX = 8;
	var _keyBindingsY = 64;
	draw_text(_keyBindingsX, _keyBindingsY,
		"Controls:\n" +
		"Spacebar - Jump\n" +
		"1, 2, 3 - Set Save Slot\n" + 
		"M - Toggle Audio"
	);
draw_set_colour(c_white);

#region

#region draw save slot panels

var _guiWidth = display_get_gui_width();
var _guiHeight = display_get_gui_height();
var _guiCentre = (_guiWidth * 0.5);

var _panelY = (_guiHeight - SLOT_HEIGHT);

var i = 0;
repeat (TOTAL_SLOTS) {
	var _isCurrentSlot = ((i + 1) == obj_ssave_demo_manager.currentSlotIndex);
	var _alpha = ((_isCurrentSlot) ? 1 : 0.66);
	draw_set_alpha(_alpha);
	
	// panel
	var _xModifier = ((i + 1) / (TOTAL_SLOTS + 1))
	var _x1 = ((_guiWidth * _xModifier) - (SLOT_WIDTH * 0.5));
	var _y1 = _panelY;
	var _x2 = (_x1 + SLOT_WIDTH);
	var _y2 = (_y1 + SLOT_HEIGHT);
	draw_sprite_stretched(spr_ssave_demo_slot_panel, 0, _x1, _y1, SLOT_WIDTH, SLOT_HEIGHT);
	
	// star
	var _centreY = (_y2 - (SLOT_HEIGHT * 0.5));
	var _starWidth = sprite_get_width(spr_ssave_demo_save_slot_star);
	var _starWidthHalf = (_starWidth * 0.5);
	var _starXBuffer = 8;
	var _starX = (_x1 + _starXBuffer + _starWidthHalf);
	var _starY = _centreY;
	draw_sprite(spr_ssave_demo_save_slot_star, i, _starX, _starY);
	
	// text
	draw_set_colour(c_black);
	draw_set_valign(fa_middle);
		var _textXBuffer = 2;
		var _textX = (_starX + _starWidthHalf + _textXBuffer);
		var _textY = (_centreY);
		draw_text(_textX, _textY, $"Slot {i + 1}");
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
	
	i++;
}

draw_set_alpha(1);

#endregion