/// @description pressing escape, fullscreen, music

// pressing escape
if keyboard_check_pressed(vk_escape){
	// plays sound effect, unless already in menu room in which case pressing escape doesn't do anything - 'false' means it doesn't loop
	if (room != rm_menu) audio_play_sound(snd_select, 0, false);
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

//music
// playing menu music in menu-type rooms if the music isn't already playing
if !audio_is_playing(snd_menu_music) and ((room = rm_menu) or (room = rm_levels) or (room = rm_select_character) or (room = rm_settings)){
	// playing the sound - 'true' means audio loops - running this code once starts the sound and keeps it playing
	audio_play_sound(snd_menu_music, 0, true);
// stopping the sound if none of the menu-type rooms are open (or it would keep playing forever)	
} else if audio_is_playing(snd_menu_music) and ((room != rm_menu) and (room != rm_levels) and (room != rm_select_character) and (room != rm_settings)){
	audio_stop_sound(snd_menu_music);
}

// playing level 1 music in level 1 room if the music isn't already playing
if !audio_is_playing(snd_level_1_music) and (room = rm_level_1){
	// playing the sound - 'true' means audio loops - running this code once starts the sound and keeps it playing
	audio_play_sound(snd_level_1_music, 0, true);
// stopping the sound if the level 1 room isn't open (or it would keep playing forever)	
} else if audio_is_playing(snd_level_1_music) and (room != rm_level_1){
	audio_stop_sound(snd_level_1_music);
}

