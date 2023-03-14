/// @description Ends level and goes to next room when touched by player object

// if touched by player object
if place_meeting(x, y, obj_level_1_player){
	// increasing levels unlocked variable to make level 2 also unlocked, unless its already unlocked
	if (global.levelsUnlocked < 1) global.levelsUnlocked = 1;
	// changing level selected variable, so when you go back into the levels screen the button points to level 2
	global.levelSelected = 1;
	// resetting start coords and barriers up in save file
	with obj_level_1_player{
		checkpointX = 640;
		checkpointY = 736;
	}
	// resetting info in save file
	var level1info = [640, 736, 1, 1, 1];
	// turning data into a JSON string (because buffers can't be arrays) and making it a buffer to save it
	var str = json_stringify(level1info);
	var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
	buffer_write( buffer, buffer_string, str);
	//saving the buffer to a file
	buffer_save( buffer, "level1info.save");
	// deleting buffer because its no longer needed
	buffer_delete(buffer);
	// readding barriers
	if (!instance_exists(obj_level_1_barrier_1)) instance_create_layer(560, 64, "Instances_1", obj_level_1_barrier_1);
	if (!instance_exists(obj_level_1_barrier_2)) instance_create_layer(624, 64, "Instances_1", obj_level_1_barrier_2);
	if (!instance_exists(obj_level_1_barrier_3)) instance_create_layer(1280, 592, "Instances_1", obj_level_1_barrier_3);
	// going to next level (animation before)
	room_goto(rm_level_2_opening_animation);
}
