#macro SLOT_WIDTH 128
#macro SLOT_HEIGHT 64
#macro SLOT_Y_BUFFER 8

var i = 0;
repeat (TOTAL_SLOTS) {
	// panel
	var _x1 = 0;
	var _y1 = ((SLOT_HEIGHT + SLOT_Y_BUFFER) * i);
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