/// @description stopping animation at first

// So animation doesn't play at first (until it's touched by player)
image_speed = 0;

// setting animation to last save if button has already been pressed according to saved data
if (file_exists("level1info.save")){
	// loading buffer from file
	var buffer = buffer_load("level1info.save");
	// saving buffer as string
	var str = buffer_read(buffer, buffer_string);
	// deleting buffer because we now have it saved as a string
	buffer_delete(buffer);
	// making data string back into an array
	var arr = json_parse(str);
	// checking if button's barrier doesn't exist (its data in the saved array is a 0) and setting button to pressed if so
	if (arr[3] = 0) image_index = image_number-1;
}