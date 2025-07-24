#macro TOTAL_SLOTS 3

LoadSlot = function(_slotIndex) {
	currentSlotIndex = _slotIndex;
	
	var _save = ssave_get(SaveFile, _slotIndex);
	playtime = _save.get("playtime");
	totalCoins = _save.get("totalCoins");
	
	// can chain function calls instead of caching the config into a variable
	ssave_get(ConfigFile)
		.set("lastLoadedSlot", _slotIndex)
		.save();
}

Save = function() {
	ssave_get(SaveFile, currentSlotIndex)
		.set("playtime", playtime)
		.set("totalCoins", totalCoins)
		.save();
}

playtime = 0;
totalCoins = 0;

currentSlotIndex = 0;
LoadSlot(currentSlotIndex);