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