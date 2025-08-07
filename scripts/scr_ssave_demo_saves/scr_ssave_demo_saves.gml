/*
 * define save file
 * the argument in the SSave constructor denotes the filename will start with "save"
 */
function SaveFile() : SSave("save") constructor
{
	add_value("playtime", SSAVE_TYPE.REAL, 0);
	add_value("totalCoins", SSAVE_TYPE.REAL, 0);
    
    /*
     * examples of other value types:
	 add_value("someString, SSAVE_TYPE.STRING, "hi");
	 add_value(someStruct, SSAVE_TYPE.STRUCT, {});
	 add_value("someArray", SSAVE_TYPE.ARRAY, []);
     
     * it's also possible to use buffers as values
     * if you're going to use buffers, keep in mind the `SSAVE_COPY_BUFFER_ON_SET` config option
     var _buffer = buffer_create(4, buffer_fixed, 2);
     buffer_write(_buffer, buffer_u16, 69);
     buffer_write(_buffer, buffer_u16, 420);
     add_value("someBuffer", SSAVE_TYPE.BUFFER, _buffer);
    */
}

/*
 * define config file
 * the argument in the SSave constructor denotes the filename will start with "config"
 */
function ConfigFile() : SSave("config") constructor
{
	add_value("lastLoadedSlot", SSAVE_TYPE.REAL, 1);
	add_value("soundsEnabled", SSAVE_TYPE.BOOLEAN, true);
}