/// @description navigation and moving the arrow

// switching which one's selected when buttons pressed
if (keyboard_check_pressed(vk_down)) and (global.menuSelected < 3){
	global.menuSelected += 1;
}
if (keyboard_check_pressed(vk_up)) and (global.menuSelected > 0){
	global.menuSelected -= 1;
}

//make arrow move
with (obj_arrow){
	y = 320 + (global.menuSelected*96);
}

// carrying out correct thing if enter is pressed
if (keyboard_check_pressed(vk_enter)){
	if (global.menuSelected < 3) {
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_select, 0, false);
		
		room_goto(roomList[global.menuSelected]);
	} else{
		
		//saving game
		// creating a local variable of the information I want to save
		var levelsUnlocked = global.levelsUnlocked;
		// making it a buffer - better for transferring data accross platforms (its what they did in the video I watched)
		var buffer = buffer_create(string_byte_length(levelsUnlocked) + 1, buffer_fixed, 1);
		buffer_write( buffer, buffer_string, levelsUnlocked);
		//saving the buffer to a file
		buffer_save( buffer, "levelsunlocked.save");
		// deleting buffer because its no longer needed
		buffer_delete(buffer);
		
		// outputs little message in gamemaker to show code ran
		show_debug_message("Game Saved! " + string(levelsUnlocked));
		
		// leaving game
		game_end();
	}
}
