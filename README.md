
<p align="center">
<div align="center">
  <img src="https://imgur.com/7c0Libn.png" alt="SSave - A simple save file system for GameMaker" _target="blank" height=200/>
  </div>
  <div align="center">
   A simple save file system for GameMaker
   <p>Available for download on <a href="https://stoozey.itch.io/ssave">Itch.io</a> and <a href="https://marketplace.yoyogames.com/assets/11246">GameMaker Marketplace</a>.</p>
   </div>
</p>

While save files can be simple, there are a lot of issues that come from just simply saving and loading raw data.
SSave tackles these problems whilst also having quality-of-life features that make creating save data easier and more secure.

### ***Why use SSave?***

- Values are typed to prevent game-breaking issues occurring from wrongly typed saved data
- You can create any number of save file types (like a config file, separate from your save file)
- You can create multiple versions of a save file type (a common use case for this is having multiple slots of save files)
- Old saves automatically sync with any new data you add to your project that wasn't originally in the save file.
    You can be 100% sure that a value in your save file is ALWAYS there, even if removed from the file
- Don't want users to tamper with your files? You can both encode or encrypt your files. This information is handled internally, so you can load a protected file without needing to do any extra work
- Buffers are a supported value type! 
