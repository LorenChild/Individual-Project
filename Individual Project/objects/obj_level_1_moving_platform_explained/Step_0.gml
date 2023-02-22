/// @description timer and checking for player contact mechanisms

// checking for player contact if no contact already
if place_meeting(x, y, obj_level_1_player) and (playerContact = 0){
	playerContact = 1;
}

// timer for how long text keeps being drawn begins decreasing after player contact with object
if (playerContact = 1) timer -= 1;

// contact variable changes when timer runs out so text stops being drawn
if (timer <= 0) playerContact = 2;