/// @description Saving players last checkpoint and barriers that exist, when level 1 is exited

// saving player 1 info when room is left
// creating a local variable of an empty list to add the info I want to save to
var level1info = [];
// adding players last checkpoint to list - x and y values
array_push(level1info, checkpointX);
array_push(level1info, checkpointY);
// adding barriers that exist to the list - 0 if they don't, 1 if they do
array_push(level1info, instance_number(obj_level_1_barrier_1));
array_push(level1info, instance_number(obj_level_1_barrier_2));
array_push(level1info, instance_number(obj_level_1_barrier_3));
// turning data into a JSON string (because buffers can't be arrays) and making it a buffer to save it
var str = json_stringify(level1info);
var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
buffer_write( buffer, buffer_string, str);
//saving the buffer to a file
buffer_save( buffer, "level1info.save");
// deleting buffer because its no longer needed
buffer_delete(buffer);

