function __ssave_print()
{
	var _string = "########## SSave: ";
    var _i = 0;
    repeat (argument_count)
        _string += string(argument[_i++]);
	
    show_debug_message(_string);
}

function __ssave_get_save_directory()
{
	if (SSAVE_DIRECTORY == "") return SSAVE_DIRECTORY;
	
	var _lastChar = string_char_at(SSAVE_DIRECTORY, string_length(SSAVE_DIRECTORY));
	if ((_lastChar == "/") || (_lastChar == "\\")) return SSAVE_DIRECTORY;
	
	return (SSAVE_DIRECTORY + "/");
}

function __ssave_ds_list_to_array(_list, _destroyList = true)
{
	var _listSize = ds_list_size(_list);
	var _array = array_create(_listSize);
	var i = 0;
	repeat (_listSize)
	{
		_array[i] = _list[| i];
		i++;
	}
	
	if (_destroyList)
		ds_list_destroy(_list);
	
	return _array;
}

function __ssave_string_to_buffer(_string)
{
	var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
	
	return _buffer;
}

function __ssave_encrypt(_json)
{
	var _buffer = __ssave_string_to_buffer(_json);
    var _encrypted = __ssave_3rdparty_sphinx_encrypt_buffer(_buffer, SSAVE_ENCRYPTION_KEY)
	buffer_delete(_buffer);
	
	return _encrypted;
}

function __ssave_decrypt(_buffer)
{
	var _decrypted = __ssave_3rdparty_sphinx_decrypt_buffer(_buffer, SSAVE_ENCRYPTION_KEY);
	var _json = buffer_read(_decrypted, buffer_text);
	return _json;
}