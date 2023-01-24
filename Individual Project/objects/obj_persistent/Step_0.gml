/// @description pressing escape, fullscreen

// pressing escape
if keyboard_check_pressed(vk_escape){
	if (room = rm_levels) or (room = rm_select_character) or (room = rm_settings){
		room_goto(rm_menu);
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

