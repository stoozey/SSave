#macro TOTAL_SLOTS 3

// load save values into this object
Load = function(_slotIndex) {
    if ((_slotIndex == currentSlotIndex) || (_slotIndex <= 0) || (_slotIndex > TOTAL_SLOTS)) return;
	
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
}

// get the save matching our slot index, then write the objects values to it
Save = function() {
	// retrieve the save
	var _save = ssave_get(SaveFile, currentSlotIndex);
	
    // showcase different protection levels depending on slot index
    switch (currentSlotIndex) {
        default: _save.set_protection(SSAVE_PROTECTION.NONE); break;
        case 2: _save.set_protection(SSAVE_PROTECTION.ENCODE); break;
        case 3: _save.set_protection(SSAVE_PROTECTION.ENCRYPT); break;
    }
    
	// update the save's values with what's stored in our object, then save to disk
	_save
		.set("playtime", playtime)
		.set("totalCoins", totalCoins)
		.save();
}

// increment coins, used in `obj_ssave_demo_player`
IncrementCoins = function(_amount) {
    totalCoins += _amount;
	
	var _config = ssave_get(ConfigFile);
	if (_config.get("soundsEnabled"))
		audio_play_sound(snd_ssave_demo_coin, 0, false);
}

playtime = 0;
totalCoins = 0;

currentSlotIndex = -1;

// load the last saved slot
var _lastLoadedSlot = ssave_get(ConfigFile).get("lastLoadedSlot");
Load(_lastLoadedSlot);