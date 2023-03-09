/// @description Ends level and goes to next room when touched by player object

// if touched by player object
if place_meeting(x, y, obj_level_1_player){
	// increasing levels unlocked variable to make level 2 also unlocked, unless its already unlocked
	if (global.levelsUnlocked < 1) global.levelsUnlocked = 1;
	// changing level selected variable, so when you go back into the levels screen the button points to level 2
	global.levelSelected = 1;
	// resetting start coords when player touches end so that's what data is saved, and when level is reentered player is at start
	with obj_level_1_player{
		checkpointX = 640;
		checkpointY = 736;
	}
	// going to next level
	room_goto(rm_level_2);
}
