/// @description Ends level and goes to next room when touched by player object

// if touched by player object
if place_meeting(x, y, obj_level_1_player){
	// going to next level
	room_goto(rm_level_2);
}

