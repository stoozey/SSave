#macro SSAVE_DIRECTORY ""    // The directory that saves are saved to
#macro SSAVE_FILE_PREFIX_DEFAULT ""    // When no file prefix is supplied, this is used by default

#macro SSAVE_USE_MANAGER true    // Whether or not the SSaveManager is used (disable this if you want to manage your saves yourself via some sort of persistent object or script)

#macro SSAVE_PROTECTION_DEFAULT SSAVE_PROTECTION.NONE        // How the save data is protected in the output file by default (can be overriden via `SSave.set_protection()`)
#macro SSAVE_ENCRYPTION_KEY 69420133769696969694204872936    // When using SSAVE_PROTECTION.ENCRYPT, this is the key used to encrypt it

#macro SSAVE_COPY_BUFFER_ON_SET true            // When using SSave.set() with a buffer, the supplied buffer is copied (so you can delete your original)
#macro SSAVE_ERROR_ON_SET_INVALID_TYPE false    // When using SSave.set() with an invalid type, throw an error (if false, it will print a warning instead)