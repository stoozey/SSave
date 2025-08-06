#macro TOTAL_SLOTS 3

// load save values into this object
Load = function(_slotIndex) {
    if ((_slotIndex <= 0) || (_slotIndex > TOTAL_SLOTS)) return;
	
    // before we update slot index, save the previous one
    if (currentSlotIndex != -1) {
        Save();
    }
    
    // update slot index
    currentSlotIndex = _slotIndex;
	
    // read from save
	var _save = ssave_get(SaveFile, _slotIndex);
	playtime = _save.get("playtime");
	totalCoins = _save.get("totalCoins");
	
    // write to config
	ssave_get(ConfigFile)
		.set("lastLoadedSlot", currentSlotIndex)
		.save();
}

// get the save matching our slot index, then write the objects values to it
Save = function() {
    // showcase different protection levels depending on slot index
    var _protection;
    switch (currentSlotIndex) {
        default: _protection = SSAVE_PROTECTION.NONE; break;
        case 2: _protection = SSAVE_PROTECTION.ENCODE; break;
        case 3: _protection = SSAVE_PROTECTION.ENCRYPT; break;
    }
    
	ssave_get(SaveFile, currentSlotIndex)
        .set_protection(_protection)
		.set("playtime", playtime)
		.set("totalCoins", totalCoins)
		.save();
}

// increment coins, used in `obj_ssave_demo_player`
IncrementCoins = function(_amount) {
    totalCoins += _amount;
}

playtime = 0;
totalCoins = 0;

currentSlotIndex = -1;

// load default slot
Load(1);