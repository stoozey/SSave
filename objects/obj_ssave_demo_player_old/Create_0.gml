Load = function()
{
    static config = ssave_get(ConfigFile);
	var _saveIndex = config.get("saveIndex");
    var _save = ssave_get(SaveFile, _saveIndex);
    x = _save.get("x");
    y = _save.get("y");
    playtime = _save.get("playtime");
}

nameRequestId = -1;
playtime = 0;

Load();