function __ssave_class_value(_name, _type, _defaultValue) constructor
{
	static get = function()
	{
		return (__value ?? __defaultValue);
	}
	
	static set = function(_value)
	{
		var _checker = __get_type_checker();
		if (!_checker(_value))
		{
			__ssave_print("Tried to set the value of ", _name, " to something other than it's type. Ignoring request.");
			return;
		}
		
		__value = _value;
	}
	
	static __get_type_checker = function()
	{
		switch (__type)
		{
			case SSAVE_TYPE.ARRAY:
				return is_array;
			
			case SSAVE_TYPE.BOOLEAN:
				return is_bool;
			
			case SSAVE_TYPE.REAL:
				return is_real;
			
			case SSAVE_TYPE.STRING:
				return is_string;
			
			case SSAVE_TYPE.STRUCT:
				return is_struct;
		}
	}
	
	__name = _name;
	__type = _type;
	__defaultValue = _defaultValue;
	__value = undefined;
	
	// Make sure the default value is actually valid
	var _checker = __get_type_checker();
	if (!_checker(__defaultValue))
		throw ("SSave value \"" + __name + "\" has a default value which isn't of the correct type"); 
}