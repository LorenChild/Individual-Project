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
		room_goto(roomList[global.menuSelected]);
	} else{
		game_end();
	}
}
