///@desc The base constructor for the SSave file (this should be inherited from a new class - e.g "	SaveFile() : SSave() constructor")
///@param {String} [name] The name of the file that gets saved
///@param {Real} [protection] The amount of protection that the data receives (of enum type SSAVE_PROTECTION)
function SSave(name = "data", protection = SSAVE_PROTECTION_DEFAULT) constructor
{
	///@desc Gets a value in the ssave
	///@param {String} name The name of the value
	///@returns {Any} Returns the currently held value of that name
	static get = function(name)
	{
		var _valueData = __get_value_data(name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(name);
		
		return _valueData.get();
	}
	
	///@desc Gets the default value in the ssave
	///@param {String} name The name of the value
	///@returns {Any} Returns the default value defined in the save constructor
	static get_default = function(name)
	{
		var _valueData = __get_value_data(name);
		if (_valueData == undefined)
			return __throw_name_doesnt_exist(name);
		
		return _valueData.get_default();
	}
	
	///@desc Updates a value in the ssave
	///@param {String} name The name of the value
	///@param {Any} value The value to be set
	///@returns {Struct.SSave} Returns self for chaining
	static set = function(name, value)
	{
		var _valueData = __get_value_data(name);
		if (_valueData == undefined)
			__throw_name_doesnt_exist(name);
		else
			_valueData.set(value);
		
		return self;
	}
	
	///@desc Resets a value in the ssave to it's default value
	///@param {String} name The name of the value
	///@returns {Struct.SSave} Returns self for chaining
	static reset = function(name)
	{
		var _default = get_default(name);
		set(name, _default);
		return self;
	}
	
	///@desc Resets all values in the ssave to their default values
	///@returns {Struct.SSave} Returns self for chaining
	static reset_all = function()
	{
		var i = 0;
		var _names = variable_struct_get_names(__values);
		repeat (array_length(_names))
		{
			var _name = _names[i++];
			reset(_name);
		}
		
		return self;
	}
	
	///@ignore (This is intended to be called inside the constructor, see the demo for example)
	///@desc Adds a new value to the ssave
	///@param {String} name The name of the value
	///@param {Real} type The SSAVE_TYPE type of the value
	///@param {Any} defaultValue The default value
	static add_value = function(name, type, defaultValue)
	{
		var _value = new __ssave_class_value(name, type, defaultValue);
		__values[$ name] = _value;
	}
	
	///@desc Saves the ssave
	///@returns {Bool} Returns success
	static save = function()
	{
		var _filename = __get_filename();
		return __save_to_file(_filename);
	}
	
	///@desc Loads the ssave
	///@param {Any} [filePrefix] When not undefined, set_file_prefix is called with this as its argument
	///@returns {Bool} Returns success
	static load = function(filePrefix = undefined)
	{
		if (filePrefix != undefined)
			set_file_prefix(filePrefix);
		
		var _filename = __get_filename();
		return __load_from_file(_filename);
	}
	
	///@desc Returns the current SSAVE_PROTECTION type
	///@returns {Real} Current SSAVE_PROTECTION type
	static get_protection = function()
	{
		return __protection;
	}
	
	///@desc Updates the current SSAVE_PROTECTION type
	///@param {Real} protection The new SSAVE_PROTECTION type
	///@returns {Struct.SSave} Returns self for chaining
	static set_protection = function(protection)
	{
		__protection = protection;
		return self;
	}
	
	///@desc Sets the prefix of the filename (useful for storing multiple of the same type of SSave, see the demo for example)
	///@param {String|Real} filePrefix The prefix (will be converted into a string)
	///@returns {Struct.SSave} Returns self for chaining
	static set_file_prefix = function(filePrefix)
	{
		__filePrefix = string(filePrefix);
	}
	
	///@desc Gets the current file prefix
	///@returns {String} The file prefix
	static get_file_prefix = function()
	{
		return __filePrefix;
	}
	
	///@desc Gets the file prefix + ssave name
	///@returns {String} The full name
	static get_full_name = function()
	{
		return (__filePrefix + __name);
	}
	
	#region internals
	
	///@ignore
	static __save_to_file = function(_filename)
	{
		var _success, _buffer = undefined, _data = undefined;
		try
		{
			var _save = __generate_output_struct();
			var _json = json_stringify(_save);
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
			
			var _dataSize = buffer_get_size(_data);
			var _bufferSize = (__SSAVE_HEADER_SIZE + _dataSize);
			_buffer = buffer_create(_bufferSize, buffer_fixed, 1);
			var _header = new __ssave_class_header();
			_header.write_to_buffer(_buffer, self);
			buffer_copy(_data, 0, _dataSize, _buffer, buffer_tell(_buffer));
			buffer_save(_buffer, _filename);
	
			__ssave_print("saved file to: ", _filename);
			_success = true;
		}
		catch (_e)
		{
			__ssave_print("error saving file \"", _filename, "\" | ", _e.message);
			_success = false;
		}
		finally
		{
			if ((_buffer != undefined) && (buffer_exists(_buffer)))
				buffer_delete(_buffer);
			
			if ((_data != undefined) && (buffer_exists(_data)))
				buffer_delete(_data);
		}
		
		return _success;
	}
	
	///@ignore
	static __load_from_file = function(_filename)
	{
		if (!file_exists(_filename)) return false;
		
		var _success, _buffer = undefined, _data = undefined;
		try
		{
			_buffer = buffer_load(_filename);
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
					_data = buffer_create(_dataSize, buffer_fixed, 1);
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
			__decode_output_struct(_save);
			
			var _varNames = variable_struct_get_names(_save);
			var i = 0;
			repeat (array_length(_varNames))
			{
				var _varName = _varNames[i++];
				var _valueData = __values[$ _varName];
				var _value = _save[$ _varName];
				_valueData.set(_value);
			}
			
			__ssave_print("loaded file : ", _filename);
			
			delete _save;
			_success = true;
		}
		catch (_e)
		{
			__ssave_print("error loading file \"", _filename, "\" | ", _e.message);
			_success = false;
		}
		finally
		{
			if ((_buffer != undefined) && (buffer_exists(_buffer)))
				buffer_delete(_buffer);
			
			if ((_data != undefined) && (buffer_exists(_data)))
				buffer_delete(_data);
		}
		
		return _success;
	}
	
	///@ignore
	static __get_value_data = function(_name)
	{
		return __values[$ _name];
	}
	
	///@ignore
	static __get_filename = function()
	{
		return (__ssave_get_save_directory() + get_full_name() + "." + __SSAVE_FILE_EXTENSION);
	}
	
	///@ignore
	static __generate_output_struct = function()
	{
		var _save = { };
		var _names = variable_struct_get_names(__values);
		var i = 0;
		repeat (array_length(_names))
		{
			var _name = _names[i++];
			var _valueData = __get_value_data(_name);
			switch (_valueData.get_type())
			{
				default:
					_save[$ _name] = _valueData.get();
					break;
				
				case SSAVE_TYPE.BUFFER:
					var _buffer = _valueData.get();
					var _bufferSize = buffer_get_size(_buffer);
					_save[$ _name] = buffer_base64_encode(_buffer, 0, _bufferSize);
					break;
			}
		}
		
		return _save;
	}
	
	///@ignore
	static __decode_output_struct = function(_save)
	{
		var i = 0;
		var _names = variable_struct_get_names(_save);
		repeat (array_length(_names))
		{
			var _override = undefined;
			var _name = _names[i++];
			var _valueData = __get_value_data(_name);
			var _value = _save[$ _name];
			switch (_valueData.get_type())
			{
				default:
					break;
				
				case SSAVE_TYPE.BUFFER:
					_override = buffer_base64_decode(_value);
					__ssave_print("buffer size is ", buffer_get_size(_override));
					break;
			}
			
			if (_override != undefined)
				_save[$ _name] = _override;
		}
	}
	
	///@ignore
	static __throw_name_doesnt_exist = function(_name)
	{
		throw ("SSave value name \"" + _name + "\" doesn't exist--did you get the name wrong?");
	}
	
	///@ignore
	__name = name;
	///@ignore
	__protection = protection;
	
	///@ignore
	__values = { };
	///@ignore
	__filePrefix = SSAVE_FILE_PREFIX_DEFAULT;
	
	#endregion
}