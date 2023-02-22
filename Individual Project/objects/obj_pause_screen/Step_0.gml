/// @description pause screen controls

// escape to exit
if keyboard_check_pressed(vk_escape){
	//unpausing variable
	global.paused = 0;
	room_goto(rm_levels);
}

// enter to continue - gets rid of obstructing object (self)
if keyboard_check_pressed(vk_enter){
	//unpausing variable
	global.paused = 0;
	instance_destroy(self);
}

