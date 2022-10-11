function __ssave_class_header() constructor
{
	static generate_buffer = function(_ssave)
	{
		var _buffer = buffer_create(1024, buffer_grow, 1);
		buffer_write(_buffer, buffer_string, "SSAVE");
		buffer_write(_buffer, buffer_u64, 0);
	
		buffer_write(_buffer, buffer_string, __SSAVE_VERSION);
		buffer_write(_buffer, buffer_u8, _ssave.get_protection());
	
		return _buffer;
	}
	
	static load_from_buffer = function(_buffer, _destroyBuffer = true)
	{
		var _ssav = buffer_read(_buffer, buffer_string);
		if (_ssav != "SSAVE")
			return __throw_not_an_ssav();
		
		var _align = buffer_read(_buffer, buffer_u64);
		if (_align != 0)
			return __throw_not_an_ssav();
		
		var _protection;
		var _version = buffer_read(_buffer, buffer_string);
		switch (_version)
		{
			default:
			case "1.0.0":
				_protection = buffer_read(_buffer, buffer_u8);
				break;
		}
		
		__version = _version;
		__protection = (_protection ?? __protection);
	}
	
	static get_version = function()
	{
		return __version;
	}
	
	static get_protection = function()
	{
		return __protection;
	}
	
	static __throw_not_an_ssav = function()
	{
		throw "File is not a real SSave file";
	}
	
	__version = __SSAVE_VERSION;
	__protection = SSAVE_PROTECTION.NONE;
}