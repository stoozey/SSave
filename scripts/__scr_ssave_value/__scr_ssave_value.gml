function __ssave_class_value(_name, _type, _defaultValue) constructor
{
	static get = function()
	{
		return (__value ?? __defaultValue);
	}
	
	static set = function(_value)
	{
		if (!__is_type(_value))
			return __ssave_print("Tried to set the value of ", __name, " to something other than it's type. Ignoring request.");
		
		switch (__type)
		{
			case SSAVE_TYPE.BOOLEAN:
				_value = (_value >= 1);
				break;
		}
		
		__value = _value;
	}
	
	static __is_type = function(_value)
	{
		switch (__type)
		{
			default:
				return false;
			
			case SSAVE_TYPE.ARRAY:
				return is_array(_value);
			
			case SSAVE_TYPE.BOOLEAN:
				return (is_bool(_value) || is_real(_value));
			
			case SSAVE_TYPE.REAL:
				return is_real(_value);
			
			case SSAVE_TYPE.STRING:
				return is_string(_value);
			
			case SSAVE_TYPE.STRUCT:
				return is_struct(_value);
		}
	}
	
	static __type_caster_default = function(_value)
	{
		return _value;
	}
	
	__name = _name;
	__type = _type;
	__defaultValue = _defaultValue;
	__value = undefined;
	
	// Make sure the default value is actually valid
	if (!__is_type(__defaultValue))
		throw ("SSave value \"" + __name + "\" has a default value which isn't of the correct type"); 
}