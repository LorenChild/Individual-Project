/// @description pause screen controls

// escape to exit
if keyboard_check_pressed(vk_escape){
	room_goto(rm_levels);
}

// enter to continue
if keyboard_check_pressed(vk_enter){
	room_goto_previous();
}
