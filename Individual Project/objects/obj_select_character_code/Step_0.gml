/// @description changing which character is selected + moving the selected box thing

// changing which is selected when buttons pressed
if keyboard_check_pressed(vk_down) and global.player_character_selected < 4{
	global.player_character_selected += 4;
}
if keyboard_check_pressed(vk_up) and global.player_character_selected > 3{
	global.player_character_selected -= 4;
}
if keyboard_check_pressed(vk_left) and global.player_character_selected != 0 and global.player_character_selected != 4{
	global.player_character_selected -= 1;
}
if keyboard_check_pressed(vk_right) and global.player_character_selected != 3 and global.player_character_selected != 7{
	global.player_character_selected += 1;
}

//moving selected box
with obj_select_character_selected{
	if global.player_character_selected < 4{
		y = 384;
	} else{
		y = 576;
	}
	if global.player_character_selected < 4{
		x = 192 + (320 * global.player_character_selected)
	} else{
		x = 192 + (320 * (global.player_character_selected-4))
	}
}

//moving picked box
with obj_select_character_picked{
	if global.player_character_picked < 4{
		y = 384;
	} else{
		y = 576;
	}
	if global.player_character_picked < 4{
		x = 192 + (320 * global.player_character_picked)
	} else{
		x = 192 + (320 * (global.player_character_picked-4))
	}
}

// character picked changes when enter pressed
if keyboard_check_pressed(vk_enter){
	// if selected character isn't already the same as the picked one...
	if global.player_character_picked != global.player_character_selected{
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_select_character, 0, false);
		
		// saving character selected value in a save file
		var playerCharacterSelected = global.player_character_selected;
		// turning data into a JSON string (because buffers can't be arrays) and making it a buffer to save it
		var str = json_stringify(playerCharacterSelected);
		var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
		buffer_write( buffer, buffer_string, str);
		//saving the buffer to a file
		buffer_save( buffer, "playercharacterselected.save");
		// deleting buffer because its no longer needed
		buffer_delete(buffer);

		global.player_character_picked = global.player_character_selected;
	}
}