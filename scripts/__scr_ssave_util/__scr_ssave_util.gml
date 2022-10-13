function __ssave_print()
{
	var _string = "########## SSave: ";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    return show_debug_message(_string);
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