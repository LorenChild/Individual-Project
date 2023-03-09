/// @description Creating variables that last between levels and changing text in top bar

// list of possible player sprites (big and small)
global.PLAYER_CHARACTER_LIST = [spr_player_red, spr_player_orange, spr_player_yellow, spr_player_green, spr_player_blue, spr_player_pink, spr_player_purple, spr_player_checkered];
global.PLAYER_CHARACTER_LIST_SMALLER = [spr_player_red_smaller, spr_player_orange_smaller, spr_player_yellow_smaller, spr_player_green_smaller, spr_player_blue_smaller, spr_player_pink_smaller, spr_player_purple_smaller, spr_player_checkered_smaller];
//selected / picked player sprite
global.player_character_selected = 0;
global.player_character_picked = 0;

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