/// @description selecting and entering level

// so correct level is entered when enter pressed, but only is that level is unlocked
if keyboard_check_pressed(vk_enter) and global.levelsUnlocked >= global.levelSelected{
	// plays sound effect - 'false' means it doesn't loop
	audio_play_sound(snd_select, 0, false);
	room_goto(levelList[global.levelSelected])
} else if keyboard_check_pressed(vk_enter) and global.levelsUnlocked < global.levelSelected{
	// playing sound effect if you click on a level which isn't unlocked - 'false' means it doesn't loop
	audio_play_sound(snd_levels_not_unlocked, 0, false);
}

// switching which one's selected when buttons pressed
if (keyboard_check_pressed(vk_down)) and (global.levelSelected < 1){
	global.levelSelected += 1;
}
if (keyboard_check_pressed(vk_up)) and (global.levelSelected > 0){
	global.levelSelected -= 1;
}

//make arrow move
with (obj_arrow){
	y = 320 + (global.levelSelected*96);
}