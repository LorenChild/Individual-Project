/// @description Creating variables that last between levels and changing text in top bar

// list of possible player sprites (big and small)
global.playerCharacterList = [spr_player_red, spr_player_orange, spr_player_yellow, spr_player_green, spr_player_blue, spr_player_pink, spr_player_purple, spr_player_checkered];
global.playerCharacterListSmaller = [spr_player_red_smaller, spr_player_orange_smaller, spr_player_yellow_smaller, spr_player_green_smaller, spr_player_blue_smaller, spr_player_pink_smaller, spr_player_purple_smaller, spr_player_checkered_smaller];

//selected / picked player sprite
// loading from save file if it exists
if (file_exists("playercharacterselected.save")){
	// loading buffer from file
	var buffer = buffer_load("playercharacterselected.save");
	// saving buffer as string
	var str = buffer_read(buffer, buffer_string);
	// deleting buffer because we now have it saved as a string
	buffer_delete(buffer);
	// making data string back into an array
	var playerCharacterSelected = json_parse(str);
	// setting player characters picked and selected to ones from save file, so the character you play as remains the same as before and the boxes in the character select page appear around the character currently selected
	global.playerCharacterSelected = playerCharacterSelected;
	global.playerCharacterPicked = playerCharacterSelected;
// otherwise selected character is default one, the red one, with index 0
} else{
	global.playerCharacterSelected = 0;
	global.playerCharacterPicked = 0;
}


// variable for which option in the menu page is selected
global.menuSelected = 0;

// changing to and from fullscreen
fullscreen = true;

// variables for levels unlocked / selected
global.levelSelected = 0;
// loading levels unlocked variable from gamesave if there is one
if (file_exists("levelsunlocked.save")){
	// loading buffer from file
	var buffer = buffer_load("levelsunlocked.save");
	// saving buffer as a string
	var levelsUnlocked = buffer_read(buffer, buffer_string);
	//deleting buffer because its no longer needed as we have it as a string
	buffer_delete(buffer);
	// turning loaded string into an integer and setting it as the levels unlocked variable
	global.levelsUnlocked = int64(levelsUnlocked);
} else{
	// saving levels unlocked as none if no save file already exists
	global.levelsUnlocked = 0;
}

// checks whether a level is paused
global.paused = 0;

// setting text shown in top bar to the name of the game
window_set_caption("Game Name");