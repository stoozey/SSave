if (SSAVE_USE_MANAGER)
	global.__ssave_manager = new SSaveManager();

///@desc Wrapper for SSaveManager.get
///@param {Function} ssaveConstructor The constructor for the ssave file
///@param {String} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
///@returns {Struct.SSave}
function ssave_get(ssaveConstructor, filePrefix = undefined)
{
	__ssave_throw_if_not_using_manager();
	
	return global.__ssave_manager.get(ssaveConstructor, filePrefix);
}

///@desc Wrapper for SSaveManager.remove
///@param {Function} ssaveConstructor The constructor for the ssave file
///@param {String} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
function ssave_remove(ssaveConstructor, filePrefix = undefined)
{
	__ssave_throw_if_not_using_manager();
	
	return global.__ssave_manager.remove(ssaveConstructor, filePrefix);
}

///@desc Gets all ssaves being managed by SSaveManager
///@param {Function} [ssaveConstructor] The constructor for the ssave file to get all of. Returns *all* ssaves, independant of the constructor, if this is undefined
///@returns {Array<Struct.SSave>} Array of ssaves
function ssave_get_all(ssaveConstructor = undefined)
{
	__ssave_throw_if_not_using_manager();
	
	var _ssavesList = ds_list_create();
	with (global.__ssave_manager)
	{
		var i = 0;
		var _ssaveConstructors = ((ssaveConstructor == undefined) ? variable_struct_get_names(__ssaves) : [ ssaveConstructor ]);
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
///@param {Function} [ssaveConstructor] The constructor for the ssave file type to save. Saves *all* ssaves, independant of the constructor, if this is undefined
function ssave_save_all(ssaveConstructor = undefined)
{
	__ssave_throw_if_not_using_manager();
	
	var _ssaves = ssave_get_all(ssaveConstructor);
	var i = 0;
	repeat (array_length(_ssaves))
		_ssaves[i++].save();
}

function SSaveManager() constructor
{
	///@desc Gets an ssave, creating it if it doesnt exist already
	///@param {Function} ssaveConstructor The constructor for the ssave file
	///@param {String} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
	///@returns {Struct.SSave}
	static get = function(ssaveConstructor, filePrefix = undefined)
	{
		filePrefix ??= SSAVE_FILE_PREFIX_DEFAULT;
		
		var _ssave = __find(filePrefix, ssaveConstructor);
		if ((_ssave == undefined) && (ssaveConstructor != undefined))
		{
			_ssave = new ssaveConstructor();
			_ssave.load(filePrefix);
			
			__register(_ssave, ssaveConstructor);
		}
		
		return _ssave;
	}
	
	///@desc Removes and deletes an ssave
	///@param {Function} ssaveConstructor The constructor for the ssave file
	///@param {String} [filePrefix] The file prefix (SSAVE_FILE_PREFIX_DEFAULT if undefined)
	static remove = function(ssaveConstructor, filePrefix = undefined)
	{	
		var index = __find_index(filePrefix ?? SSAVE_FILE_PREFIX_DEFAULT, ssaveConstructor);
		if (index == -1) return;
		
		__deregister_by_index(index, ssaveConstructor);
	}
	
	#region internal
	
	///@ignore
	static __get_ssaves = function(ssaveConstructor)
	{
		if (!variable_struct_exists(__ssaves, ssaveConstructor))
		{
			var _ssaves = ds_list_create();
			__ssaves[$ ssaveConstructor] = _ssaves;
		}
		
		return __ssaves[$ ssaveConstructor];
	}
	
	///@ignore
	static __find = function(filePrefix, ssaveConstructor)
	{
		var index = __find_index(filePrefix, ssaveConstructor);
		if (index == -1) return undefined;
		
		var _ssaves = __get_ssaves(ssaveConstructor);
		return _ssaves[| index];
	}
	
	///@ignore
	static __find_index = function(filePrefix, ssaveConstructor)
	{
		var _ssaves = __get_ssaves(ssaveConstructor);
		
		var i = 0;
		repeat (ds_list_size(_ssaves))
		{
			var _ssave = _ssaves[| i];
			if (_ssave.get_file_prefix() == filePrefix)
				return i;
			
			i++;
		}
		
		return -1;
	}
	
	///@ignore
	static __register = function(ssaveToRegister, ssaveConstructor)
	{
		var _ssaves = __get_ssaves(ssaveConstructor);
		var index = ds_list_find_index(_ssaves, ssaveToRegister);
		if (index != -1) return;
		
		var filePrefix = ssaveToRegister.get_file_prefix();
		var _existingIndex = __find_index(filePrefix, ssaveConstructor);
		if (_existingIndex != -1)
		{
			var _existingSsave = _ssaves[| _existingIndex];
			ds_list_delete(_ssaves, _existingIndex);
			
			delete _existingSsave;
		}
		
		ds_list_add(_ssaves, ssaveToRegister);
	}
	
	///@ignore
	static __deregister_by_index = function(index, ssaveConstructor)
	{
		var _ssaves = __get_ssaves(ssaveConstructor);
		if ((index < 0) || (index >= ds_list_size(_ssaves))) return;
		
		var _ssave = _ssaves[| index];
		ds_list_delete(_ssaves, index);
		
		delete _ssave;
	}
	
	///@ignore
	__ssaves = { };
	
	#endregion
}

function __ssave_throw_if_not_using_manager() {
	if (!SSAVE_USE_MANAGER)
		__ssave_throw("tried to use the SSave manager whilst config value \"SSAVE_USE_MANAGER\" is false");
}