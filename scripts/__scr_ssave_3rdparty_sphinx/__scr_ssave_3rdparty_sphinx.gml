/*

Sphinx by Juju Adams
https://github.com/JujuAdams/Sphinx

Version 1.0.0 - 2021-06-08

*/

#macro SPHINX_MAXIMUM_XOR_BYTES  infinity

function __ssave_3rdparty_sphinx_decrypt_buffer(_buffer, _key)
{
    return __ssave_3rdparty_sphinx_decrypt_buffer_ext(_buffer, 0, buffer_get_size(_buffer), _key);
}

function __ssave_3rdparty_sphinx_decrypt_buffer_ext(_buffer, _offset, _size, _key)
{
    var _tempBuffer = buffer_create(_size, buffer_fixed, 1);
    buffer_copy(_buffer, _offset, _size, _tempBuffer, 0);
    
    var _i = 0;
    var _state = _key;
    repeat(min(SPHINX_MAXIMUM_XOR_BYTES, _size))
    {
        //Basic XORShift32, nothing fancy
        _state ^= _state << 13;
        _state ^= _state >> 17;
        _state ^= _state <<  5;
        
        buffer_poke(_tempBuffer, _i, buffer_u8, buffer_peek(_tempBuffer, _i, buffer_u8) ^ (_state & 0xFF));
        ++_i;
    }
    
    var _decompressed = buffer_decompress(_tempBuffer);
    buffer_delete(_tempBuffer);
    
    return _decompressed;
}

function __ssave_3rdparty_sphinx_encrypt_buffer(_buffer, _key)
{
    return __ssave_3rdparty_sphinx_encrypt_buffer_ext(_buffer, 0, buffer_get_size(_buffer), _key);
}

function __ssave_3rdparty_sphinx_encrypt_buffer_ext(_buffer, _offset, _size, _key)
{
    var _compressed = buffer_compress(_buffer, _offset, _size);
    
    var _compressed_size = buffer_get_size(_compressed);
    var _i = 0;
    var _state = _key;
    repeat(min(SPHINX_MAXIMUM_XOR_BYTES, _compressed_size))
    {
        //Basic XORShift32, nothing fancy
        _state ^= _state << 13;
        _state ^= _state >> 17;
        _state ^= _state <<  5;
        
        buffer_poke(_compressed, _i, buffer_u8, buffer_peek(_compressed, _i, buffer_u8) ^ (_state & 0xFF));
        
        ++_i;
    }
    
    return _compressed;
}
