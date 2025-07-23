var _saveIndex = ssave_get(ConfigFile).get("saveIndex");

draw_text(4, 4, "Press numbers 0-9 to select save file index");
draw_text(4, 20, "Current save index: " + string(_saveIndex));
draw_text(4, 36, "Go to %localappdata%/SSave to view your save files.");