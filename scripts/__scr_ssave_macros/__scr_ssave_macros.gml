enum SSAVE_TYPE
{
	STRING,
	REAL,
	BOOLEAN,
	STRUCT,
	ARRAY,
	BUFFER,
}

enum SSAVE_PROTECTION
{
	NONE,		// Save data is stored in plaintext json - good if you don't care about tampering
	ENCODE,		// Save data is stored in base64 encoded json - good if you want *most* players to not know how to tamper
	ENCRYPT,	// Save data is encrypted with a key - good if you want *most* players to be unable to tamper. This is NOT secure enough for sensitive data
}

#macro __SSAVE_FILE_EXTENSION "ssave"
#macro __SSAVE_VERSION "1.4.0"