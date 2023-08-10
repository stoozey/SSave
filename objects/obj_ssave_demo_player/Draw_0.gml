draw_sprite_ext(sprite_index, image_index, x, y, 4, 4, 0, c_white, 1);

draw_text(x, y - 18, "Name: " + name);
draw_text(x, y - 36, "Playtime: " + string(playtime));