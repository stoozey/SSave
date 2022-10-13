function __ssave_class_header() constructor
{
	#macro __SSAVE_HEADER_SIZE 64
	
	static write_to_buffer = function(_buffer, _ssave)
	{
		buffer_write(_buffer, buffer_string, "SSAVE");

		buffer_write(_buffer, buffer_string, __SSAVE_VERSION);
		buffer_write(_buffer, buffer_u8, _ssave.get_protection());
		
		buffer_seek(_buffer, buffer_seek_start, __SSAVE_HEADER_SIZE);
	}
	
	static read_from_buffer = function(_buffer)
	{
		buffer_seek(_buffer, buffer_seek_start, 0);
		
		var _ssav = buffer_read(_buffer, buffer_string);
		if (_ssav != "SSAVE")
			return __throw_not_an_ssave();

		var _protection;
		var _version = buffer_read(_buffer, buffer_string);
		switch (_version)
		{
			default:
			case "1.0.0":
				_protection = buffer_read(_buffer, buffer_u8);
				break;
		}
		
		buffer_seek(_buffer, buffer_seek_start, __SSAVE_HEADER_SIZE);
		
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
	
	static __throw_not_an_ssave = function()
	{
		throw "File is not a real SSave file";
	}
	
	__version = __SSAVE_VERSION;
	__protection = SSAVE_PROTECTION.NONE;
}