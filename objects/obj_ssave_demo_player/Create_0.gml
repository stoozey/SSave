Load = function()
{
    static config = ssave_get(ConfigFile);
    var _save = ssave_get(SaveFile, config.get("saveIndex"));
    x = _save.get("x");
    y = _save.get("y");
    playtime = _save.get("playtime");
    
    var _name = _save.get("name");
    while (_name == "")
        _name = get_string("Enter name for this save file:", "Geoffrey");
    
    name = _name;
}

name = "";
playtime = 0;

Load();