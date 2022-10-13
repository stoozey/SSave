
<p align="center">
<div align="center">
  <img src="https://imgur.com/7c0Libn.png" alt="SSave - A simple save file system for GameMaker" height=200/>
  </div>
  <div align="center">
   A simple save file system for GameMaker
   <p>Available for download <a href="https://stoozey.itch.io/ssave"> on Itch.io</a>.</p>
   </div>
</p>

While at first save files can seem simple, there are a lot of issues that come from just simply saving and loading raw data.
SSave tackles these problems whilst also having quality-of-life features that make creating save data easier and more secure.

### ***Why use SSave?***

- Values are typed to prevent game-breaking issues occurring from wrongly typed saved data
- You can create any number of save file types (like a config file, separate from your save file)
- You can create multiple versions of a save file type (a common use case for this is having multiple slots of save files)
- Old saves automatically sync with any new data you add to your project that wasn't originally in the save file.
    You can be 100% sure that a value in your save file is ALWAYS there, even if removed from the file
- Don't want users to tamper with your files? SSave supports both encoding AND encrypting. This information is stored in the file header and handled internally, so you can load a protected file without needing to do any extra work.
