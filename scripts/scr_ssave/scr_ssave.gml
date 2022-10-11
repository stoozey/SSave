function SSave(_name = "data", _protection = SSAVE_PROTECTION_DEFAULT) constructor
{
	static get = function(_name, _defaultValue)
	{
		var _valueData = get_value_data(_name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(_name);
		
		return _valueData.get();
	}
	
	static set = function(_name, _value)
	{
		var _valueData = get_value_data(_name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(_name);
		
		_valueData.set(_value);
	}
	
	static get_value_data = function(_name)
	{
		return __values[$ _name];
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
			var _data;
			switch (__protection)
			{
				default:
				case SSAVE_PROTECTION.NONE:
					_data = _json;
					break;
				
				case SSAVE_PROTECTION.ENCODE:
					_data = base64_encode(_json);
					break;
				
				case SSAVE_PROTECTION.ENCRYPT:
					_data = SphinxEncryptString(_json, SSAVE_ENCRYPTION_KEY);
					break;
			}
			
			var _header = new __ssave_class_header();
			var _headerBuffer = _header.generate_buffer(self);
			var _headerBufferEncoded = buffer_base64_encode(_headerBuffer, 0, buffer_get_size(_headerBuffer));
			buffer_delete(_headerBuffer);
			
			var _file = file_text_open_write(_filename);
				file_text_write_string(_file, _headerBufferEncoded);
				file_text_writeln(_file);
				file_text_write_string(_file, _json);
			file_text_close(_file);
		
			__ssave_print("saved file to: ", _filename);
			return true;
		}
		catch (_e)
		{
			__ssave_print("error saving file \"", _filename, "\" | ", _e.message);
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
				var _headerEncoded = file_text_readln(_file);
				var _data = file_text_read_string(_file);
			file_text_close(_file);
			
			var _header = new __ssave_class_header();
			var _headerBuffer = buffer_base64_decode(_headerEncoded);
			_header.load_from_buffer(_headerBuffer);
			buffer_delete(_headerBuffer);
			
			var _json;
			switch (_header.get_protection())
			{
				default:
				case SSAVE_PROTECTION.NONE:
					_json = _data;
					break;
				
				case SSAVE_PROTECTION.ENCODE:
					_json = base64_decode(_data);
					break;
				
				case SSAVE_PROTECTION.ENCRYPT:
					_json = SphinxDecryptString(_data, SSAVE_ENCRYPTION_KEY);
					break;
			}
			
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
			__ssave_print("error loading file \"", _filename, "\" | ", _e.message);
			return false;
		}
	}
	
	static get_protection = function()
	{
		return __protection;
	}
	
	static __throw_name_doesnt_exist = function(_name)
	{
		throw ("SSave value name \"" + _name + "\" doesn't exist--did you get the name wrong?");
	}
	
	static __generate_output_struct = function()
	{
		var _save = { };
		var _names = variable_struct_get_names(__values);
		var i = 0;
		repeat (array_length(_names))
		{
			var _name = _names[i++];
			_save[$ _name] = get(_name);
		}
		
		return _save;
	}
	
	static __get_filename = function(_prefix = "")
	{
		return (SSAVE_DIRECTORY + _prefix + __name + "." + __SSAVE_FILE_EXTENSION);
	}
	
	__name = _name;
	__protection = _protection;
	
	__values = { };
}