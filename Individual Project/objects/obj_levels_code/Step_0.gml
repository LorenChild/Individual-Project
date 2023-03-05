/// @description selecting and entering level

// so correct level is entered when enter pressed, but only is that level is unlocked
if keyboard_check_pressed(vk_enter) and global.levelsUnlocked >= global.levelSelected{
	// plays sound effect - 'false' means it doesn't loop
	audio_play_sound(snd_select, 0, false);
	room_goto(levelList[global.levelSelected])
}

//add code for moving arrow and changing which is selected when more levels added