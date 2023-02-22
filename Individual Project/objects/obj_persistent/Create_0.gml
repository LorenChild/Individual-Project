/// @description Creating variables that last between levels

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
global.levelsUnlocked = 0;

// checks whether a level is paused
global.paused = 0;