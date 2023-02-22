/// @description pressing escape, fullscreen

// pressing escape
if keyboard_check_pressed(vk_escape){
	if (room = rm_levels) or (room = rm_select_character) or (room = rm_settings){
		room_goto(rm_menu);
	//checking if the room is a level room and if so sends to pause page
	} else if(room = rm_level_1){
		//so not created if already there
		if !instance_exists(obj_pause_screen){
			instance_create_layer(0, 0, "pause_screen_layer", obj_pause_screen);
			// changing paused variable so game knows whether to run level code
			global.paused = 1;
		}
	}
}

// switching to and from fullscreen
if keyboard_check_pressed(vk_f11){
	if fullscreen = true{
		fullscreen = false;
	} else{
		fullscreen = true;
	}
}

window_set_fullscreen(fullscreen);

