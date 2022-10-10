function SSave(_name = "data") constructor
{
	static get_value = function(_name)
	{
		var _value = __values[$ _name];
		if (_value != undefined)
			_value = _value.get();
		
		return _value;
	}
	
	static add_value = function(_name, _type, _defaultValue)
	{
		var _value = new __ssave_class_value(_name, _type, _defaultValue);
		__values[$ _name] = _value;
	}
	
	static save = function(_filePrefix = "")
	{
		try
		{
			var _filename = __get_filename(_filePrefix);
			var _save = __generate_output_struct();
			var _json = json_stringify(_save);
			var _file = file_text_open_write(_filename);
				file_text_write_string(_file, _json);
			file_text_close(_file);
		
			__ssave_print("saved file to: ", _filename);
			return true;
		}
		catch (_e)
		{
			__ssave_print("error saving file ", _filename, " | ", _e.message);
			return false;
		}
	}
	
	static load = function(_filePrefix = "")
	{
		try
		{
			var _filename = __get_filename(_filePrefix);
			if (!file_exists(_filename)) return false;
		
			var _file = file_text_open_read(_filename);
				var _json = file_text_read_string(_file);
			file_text_close(_file);
		
			var _save = json_parse(_json);
			var _varNames = variable_struct_get_names(_save);
			var i = 0;
			repeat (array_length(_varNames))
			{
				var _varName = _varNames[i++];
				var _value = __values[$ _varName];
				var _jsonValue = _save[$ _varName];
				_value.set(_jsonValue);
			}
		
			delete _save;
			return true;
		}
		catch (_e)
		{
			__ssave_print("error loading file ", _filename, " | ", _e.message);
			return false;
		}
	}
	
	static __generate_output_struct = function()
	{
		var _save = { };
		var _names = variable_struct_get_names(_copy);
		var i = 0;
		repeat (array_length(_names))
		{
			var _name = _names[i++];
			_save[$ _name] = get_value(_name);
		}
		
		return _save;
	}
	
	static __get_filename = function(_prefix = "")
	{
		return (SSAVE_DIRECTORY + "/" + _prefix + __name + "." + __SSAVE_FILE_EXTENSION);
	}
	
	__name = _name;
	__values = { };
}