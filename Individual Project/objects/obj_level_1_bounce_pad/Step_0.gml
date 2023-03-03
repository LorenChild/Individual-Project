/// @description So it switches to second frame for a few seconds when player touches it

// If touching the player - checks a bit to left and right of collision box too because sometimes it launched you before it could count as pressed
if (place_meeting(x+1, y, obj_level_1_player)) or (place_meeting(x-1, y, obj_level_1_player)){
	// sets pressed value to a value which will be counted down from to control the duration it stays pressed for - sets it to being pressed
	pressed = 13;
} 

// if bounce pad has been pressed, variable is counted down like a timer so it stops being pressed (gets to 0) after a few seconds
if (pressed >= 1) pressed -= 1;

// bounce pad has been pressed
if pressed >= 1{
	// setting image index to second frame
	image_index = 1;
} else{
	// so it stays on the first frame when not touching the player
	image_index = 0;
}