if (SSAVE_USE_MANAGER)
	global.__ssave_manager = new SSaveManager();

///@desc Wrapper for SSaveManager.get
///@param {function} ssaveConstructor The constructor for the ssave file
///@param {string} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
///@returns {SSave}
function ssave_get(_ssaveConstructor, _filePrefix = undefined)
{
	if (!SSAVE_USE_MANAGER)
		throw ("SSave config value \"SSAVE_USE_MANAGER\" is false");
	
	return global.__ssave_manager.get(_ssaveConstructor, _filePrefix);
}

///@desc Wrapper for SSaveManager.remove
///@param {function} ssaveConstructor The constructor for the ssave file
///@param {string} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
function ssave_remove(_ssaveConstructor, _filePrefix = undefined)
{
	if (!SSAVE_USE_MANAGER)
		throw ("SSave config value \"SSAVE_USE_MANAGER\" is false");
	
	return global.__ssave_manager.remove(_ssaveConstructor, _filePrefix);
}

///@desc Gets all ssaves being managed by SSaveManager
///@param {function} [ssaveConstructor] The constructor for the ssave file to get all of. Returns *all* ssaves, independant of the constructor, if this is undefined
///@returns {Array<SSave>} Array of ssaves
function ssave_get_all(_ssaveConstructor = undefined)
{
	if (!SSAVE_USE_MANAGER)
		throw ("SSave config value \"SSAVE_USE_MANAGER\" is false");
	
	var _ssavesList = ds_list_create();
	with (global.__ssave_manager)
	{
		var i = 0;
		var _ssaveConstructors = ((_ssaveConstructor == undefined) ? variable_struct_get_names(__ssaves) : [ _ssaveConstructor ]);
		repeat (array_length(_ssaveConstructors))
		{
			var _constructorName = _ssaveConstructors[i++];
			var _ssaves = __ssaves[$ _constructorName];
			
			var j = 0;
			repeat (ds_list_size(_ssaves))
			{
				var _ssave = _ssaves[| j++];
				ds_list_add(_ssavesList, _ssave);
			}
		}
	}
	
	return __ssave_ds_list_to_array(_ssavesList);
}

///@desc Calls ssave.save() on all SSaveManager ssaves
///@param {function} [ssaveConstructor] The constructor for the ssave file type to save. Saves *all* ssaves, independant of the constructor, if this is undefined
function ssave_save_all(_ssaveConstructor = undefined)
{
	if (!SSAVE_USE_MANAGER)
		throw ("SSave config value \"SSAVE_USE_MANAGER\" is false");
	
	var _ssaves = ssave_get_all(_ssaveConstructor);
	var i = 0;
	repeat (array_length(_ssaves))
		_ssaves[i++].save();
}

function SSaveManager() constructor
{
	///@desc Gets an ssave, creating it if it doesnt exist already
	///@param {function} ssaveConstructor The constructor for the ssave file
	///@param {string} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
	///@returns {SSave}
	static get = function(_ssaveConstructor, _filePrefix = undefined)
	{
		if (_filePrefix == undefined) _filePrefix = SSAVE_FILE_PREFIX_DEFAULT;
		
		var _ssave = __find(_filePrefix, _ssaveConstructor);
		if ((_ssave == undefined) && (_ssaveConstructor != undefined))
		{
			_ssave = new _ssaveConstructor();
			_ssave.load(_filePrefix);
			
			__register(_ssave, _ssaveConstructor);
		}
		
		return _ssave;
	}
	
	///@desc Removes and deletes an ssave
	///@param {function} ssaveConstructor The constructor for the ssave file
	///@param {string} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
	static remove = function(_ssaveConstructor, _filePrefix = undefined)
	{
		if (_filePrefix == undefined) _filePrefix = SSAVE_FILE_PREFIX_DEFAULT;
		
		var _index = __find_index(_filePrefix, _ssaveConstructor);
		if (_index == -1) return;
		
		__deregister_by_index(_index, _ssaveConstructor);
	}
	
	#region internal
	
	static __get_ssaves = function(_ssaveConstructor)
	{
		if (!variable_struct_exists(__ssaves, _ssaveConstructor))
		{
			var _ssaves = ds_list_create();
			__ssaves[$ _ssaveConstructor] = _ssaves;
		}
		
		return __ssaves[$ _ssaveConstructor];
	}
	
	static __find = function(_filePrefix, _ssaveConstructor)
	{
		var _index = __find_index(_filePrefix, _ssaveConstructor);
		if (_index == -1) return undefined;
		
		var _ssaves = __get_ssaves(_ssaveConstructor);
		return _ssaves[| _index];
	}
	
	static __find_index = function(_filePrefix, _ssaveConstructor)
	{
		var _ssaves = __get_ssaves(_ssaveConstructor);
		
		var i = 0;
		repeat (ds_list_size(_ssaves))
		{
			var _ssave = _ssaves[| i];
			if (_ssave.get_file_prefix() == _filePrefix)
				return i;
			
			i++;
		}
		
		return -1;
	}
	
	static __register = function(_ssaveToRegister, _ssaveConstructor)
	{
		var _ssaves = __get_ssaves(_ssaveConstructor);
		var _index = ds_list_find_index(_ssaves, _ssaveToRegister);
		if (_index != -1) return;
		
		var _filePrefix = _ssaveToRegister.get_file_prefix();
		var _existingIndex = __find_index(_filePrefix, _ssaveConstructor);
		if (_existingIndex != -1)
		{
			var _existingSsave = _ssaves[| _existingIndex];
			ds_list_delete(_ssaves, _existingIndex);
			
			delete _existingSsave;
		}
		
		ds_list_add(_ssaves, _ssaveToRegister);
	}
	
	static __deregister_by_index = function(_index, _ssaveConstructor)
	{
		var _ssaves = __get_ssaves(_ssaveConstructor);
		if ((_index < 0) || (_index >= ds_list_size(_ssaves))) return;
		
		var _ssave = _ssaves[| _index];
		ds_list_delete(_ssaves, _index);
		
		delete _ssave;
	}
	
	#endregion
	
	__ssaves = { };
}