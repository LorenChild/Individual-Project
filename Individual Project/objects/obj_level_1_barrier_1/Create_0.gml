/// @description Removing barrier if barrier is already removed in a save file
if (file_exists("level1info.save")){
	// loading buffer from file
	var buffer = buffer_load("level1info.save");
	// saving buffer as string
	var str = buffer_read(buffer, buffer_string);
	// deleting buffer because we now have it saved as a string
	buffer_delete(buffer);
	// making data string back into an array
	var arr = json_parse(str);
	// checking if barrier doesn't exist (its data in the saved array is a 0) and deleting it if so
	if (arr[2] = 0) instance_destroy();
}
