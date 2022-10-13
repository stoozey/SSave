///@desc The base constructor for the SSave file (this should be inherited from a new class - e.g "SaveFile() : SSave() constructor")
///@param {string} [name The name of the file that gets saved
///@param {SSAVE_PROTECTION} protection] The amount of protection that the data receives
function SSave(_name = "data", _protection = SSAVE_PROTECTION_DEFAULT) constructor
{
	///@desc Gets a value in the ssave
	///@param {string} name The name of the value
	static get = function(_name)
	{
		var _valueData = __get_value_data(_name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(_name);
		
		return _valueData.get();
	}
	
	///@desc Updates a value in the ssave
	///@param {string} name The name of the value
	///@param {any} value The value to be set
	static set = function(_name, _value)
	{
		var _valueData = __get_value_data(_name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(_name);
		
		_valueData.set(_value);
	}
	
	///@desc Adds a new value to the ssave (This is intended to be called inside the constructor, see the demo for example)
	///@param {string} name The name of the value
	///@param {SSAVE_TYPE} type The type of the value
	///@param {any} defaultValue The default value
	static add_value = function(_name, _type, _defaultValue)
	{
		var _value = new __ssave_class_value(_name, _type, _defaultValue);
		__values[$ _name] = _value;
	}
	
	///@desc Saves the ssave to file
	///@param {string} [filePrefix] A prefix to the filename (useful for storing multiple of the same type of SSave, see the demo for example)
	static save = function(_filePrefix = "")
	{
		var _filename = __get_filename(_filePrefix);
		return __save_to_file(_filename);
	}
	
	///@desc Loads the ssave from a file
	///@param {string} [filePrefix] The prefix of the filename (useful for storing multiple of the same type of SSave, see the demo for example)
	static load = function(_filePrefix = "")
	{
		var _filename = __get_filename(_filePrefix);
		return __load_from_file(_filename);
	}
	
	///@desc Returns the current SSAVE_PROTECTION type
	static get_protection = function()
	{
		return __protection;
	}
	
	///@desc Updates the current SSAVE_PROTECTION type
	///@param {SSAVE_PROTECTION} protection The new SSAVE_PROTECTION type
	static set_protection = function(_protection)
	{
		__protection = _protection;
	}
	
	#region internal
	
	static __save_to_file = function(_filename)
	{
		try
		{
			var _save = __generate_output_struct();
			var _json = json_stringify(_save);
			var _data;
			switch (__protection)
			{
				default:
				case SSAVE_PROTECTION.NONE:
					_data = __ssave_string_to_buffer(_json);
					break;
				
				case SSAVE_PROTECTION.ENCODE:
					var _jsonEncoded = base64_encode(_json);
					_data = __ssave_string_to_buffer(_jsonEncoded);
					break;
				
				case SSAVE_PROTECTION.ENCRYPT:
					_data = __ssave_encrypt(_json);
					break;
			}
			
			var _buffer = buffer_create(1024, buffer_grow, 1);
			var _header = new __ssave_class_header();
			_header.write_to_buffer(_buffer, self);
			buffer_copy(_data, 0, buffer_get_size(_data), _buffer, buffer_tell(_buffer));
			buffer_save(_buffer, _filename);
		
			__ssave_print("saved file to: ", _filename);
			return true;
		}
		catch (_e)
		{
			__ssave_print("error saving file \"", _filename, "\" | ", _e.message);
			return false;
		}
	}
	
	static __load_from_file = function(_filename)
	{
		try
		{
			if (!file_exists(_filename)) return false;
			
			var _buffer = buffer_load(_filename);
			var _header = new __ssave_class_header();
			_header.read_from_buffer(_buffer);
			
			var _json;
			switch (_header.get_version())
			{
				default:
				case "1.0.0":
				{
					var _bufferPos = buffer_tell(_buffer);
					var _dataSize = (buffer_get_size(_buffer) - _bufferPos);
					var _data = buffer_create(1024, buffer_grow, 1);
					buffer_copy(_buffer, _bufferPos, _dataSize, _data, 0);

					switch (_header.get_protection())
					{
						default:
						case SSAVE_PROTECTION.NONE:
							_json = buffer_read(_data, buffer_text);
							break;
				
						case SSAVE_PROTECTION.ENCODE:
							var _encodedJson = buffer_read(_data, buffer_text);
							_json = base64_decode(_encodedJson);
							break;
				
						case SSAVE_PROTECTION.ENCRYPT:
							_json = __ssave_decrypt(_data);
							break;
					}
					
					break;
				}
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
		
			__ssave_print("loaded file : ", _filename);
			
			delete _save;
			return true;
		}
		catch (_e)
		{
			__ssave_print("error loading file \"", _filename, "\" | ", _e.message);
			return false;
		}
	}
	
	static __get_value_data = function(_name)
	{
		return __values[$ _name];
	}
	
	static __get_filename = function(_prefix = "")
	{
		return (SSAVE_DIRECTORY + _prefix + __name + "." + __SSAVE_FILE_EXTENSION);
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
	
	static __throw_name_doesnt_exist = function(_name)
	{
		throw ("SSave value name \"" + _name + "\" doesn't exist--did you get the name wrong?");
	}
	
	__name = _name;
	__protection = _protection;
	
	__values = { };
	
	#endregion
}