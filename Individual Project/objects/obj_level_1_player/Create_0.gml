/// @description Setting up movement variables + functions

// gravity
grv = 0.2;
// current horizontal speed
hsp = 0;
// current vertical speed
vsp = 0;
//walk speed
hspWalk = 3.5;
// jump speed - negative because measures y axis from top
vspJump = -6;
//are we touching the ground
canJump = 0;
// value to reset canJump to when ground touched
canJumpResetValue = 5;
// player's starting position - loading last checkpoint if save file exists
if (file_exists("level1info.save")){
	// loading buffer from file
	var buffer = buffer_load("level1info.save");
	// saving buffer as string
	var str = buffer_read(buffer, buffer_string);
	// deleting buffer because we now have it saved as a string
	buffer_delete(buffer);
	// making data string back into an array
	var arr = json_parse(str);
	// setting x and y values so player starts at saved position
	x = arr[0];
	y = arr[1];
	// starting death restart point - x + y values
	checkpointX = arr[0];
	checkpointY = arr[1];
// starting death restart point - x + y values
} else{
	checkpointX = 640;
	checkpointY = 736;
}

// state machine - creating state functions
// normal state
stateNormal = function()
{
	// stopping water sound effect (or it would keep playing forever after entering water)	
	if audio_is_playing(snd_level_1_water){
		audio_stop_sound(snd_level_1_water);
	}
	
	// restarting room if delete pressed
	if keyboard_check_pressed(vk_delete){
		// resetting all things to as they were at the start - player coords and barriers existing
		checkpointX = 640;
		checkpointY = 736;
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
		// readding barriers if they're gone
		if (!instance_exists(obj_level_1_barrier_1)) instance_create_layer(560, 64, "Instances_1", obj_level_1_barrier_1);
		if (!instance_exists(obj_level_1_barrier_2)) instance_create_layer(624, 64, "Instances_1", obj_level_1_barrier_2);
		if (!instance_exists(obj_level_1_barrier_3)) instance_create_layer(1280, 592, "Instances_1", obj_level_1_barrier_3);
		// restarting room
		room_restart();
	}
	
	//calculating player movement
	
	// Getting inputs - using local variables
	var keyRight = keyboard_check(vk_right);
	var keyLeft = keyboard_check(vk_left);
	var keyJump = keyboard_check_pressed(vk_up);

	//work out where to move horizontally
	hsp = (keyRight - keyLeft) * hspWalk;

	//work out where to move vertically
	vsp = vsp + grv;
	
	// if on moving vertical platform
	// making (platform) vertical movement variable a local variable because they can be used in with statements
	var pvsp = 0;
	with obj_level_1_moving_platform{
		// making local variable the platform's vertical speed
		pvsp = vsp;
	}
	// Second moving platform
	var pvsp2 = 0;
	with obj_level_1_moving_platform_2{
		// making local variable the platform's vertical speed
		pvsp2 = vsp;
	}
	// collisions with moving platforms - before collisions with wall object so wall collisions take precidence
	if place_meeting(x, y + vsp, obj_level_1_moving_platform) or place_meeting(x, y + vsp, obj_level_1_moving_platform_2){
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_level_1_moving_platform)) and (!place_meeting(x, y + vsp, obj_level_1_moving_platform_2)) y += vsp;
		}
		vsp = 0;
	}
	// so player moves with moving platform if on platform - before jump so can jump while on platform
	if place_meeting(x, y+0.1, obj_level_1_moving_platform){
		canJump = canJumpResetValue;
		vsp = pvsp;
	}
	// second moving platform
	if place_meeting(x, y+0.1, obj_level_1_moving_platform_2){
		canJump = canJumpResetValue;
		vsp = pvsp2;
	}

	//work out if we should jump
	if canJump-- > 0 and keyJump and vsp>vspJump{
		// += not just = so movement relative to inertial frame such as that of moving platform
		vsp += vspJump;
		canJump = 0;
	}

	//collide and move
	// for x collision can calculate wall and moving platform collisions together, as platform moves vertically so shouldn't mess up horizontal collisions
	if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform) or place_meeting(x + hsp, y, obj_level_1_broken_platform) or place_meeting(x + hsp, y, obj_level_1_moving_platform_2) or place_meeting(x + hsp, y, obj_level_1_barrier_1) or place_meeting(x + hsp, y, obj_level_1_barrier_2) or place_meeting(x + hsp, y, obj_level_1_barrier_3){
		while (abs(hsp) > 0.1){
			hsp *= 0.5;
			if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) and (!place_meeting(x + hsp, y, obj_level_1_broken_platform)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_1)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_3)) x += hsp;
		}
		hsp = 0;
	}
	x += hsp;

	if place_meeting(x, y + vsp, obj_wall) or place_meeting(x, y + vsp, obj_level_1_broken_platform) or place_meeting(x, y + vsp, obj_level_1_barrier_1) or place_meeting(x, y + vsp, obj_level_1_barrier_2) or place_meeting(x, y + vsp, obj_level_1_barrier_3){
		if (vsp > 0) canJump = canJumpResetValue;
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_wall)) and (!place_meeting(x, y + vsp, obj_level_1_broken_platform)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_1)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_2)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_3)) y += vsp;
		}
		vsp = 0;
	} 

	// if bounce pad touched
	if place_meeting(x, y, obj_level_1_bounce_pad){
		vsp = vspJump*1.65;
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_level_1_bounce_pad, 0, false);
	}

	//actually moving (verticallllly)
	y += vsp;

	// death - if hitting kill-y thing
	if place_meeting(x, y, obj_level_1_lava) or place_meeting(x, y, obj_level_1_spikes_ceiling) or place_meeting(x, y, obj_level_1_moving_saw_1) or place_meeting(x, y, obj_level_1_moving_saw_2) or place_meeting(x, y, obj_level_1_moving_saw_3) or place_meeting(x, y, obj_level_1_stationary_saw) or place_meeting(x, y, obj_level_1_moving_saw_4) or place_meeting(x, y, obj_level_1_moving_saw_5) or place_meeting(x, y, obj_level_1_moving_saw_6) or place_meeting(x, y, obj_level_1_missile){
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_level_1_dying, 0, false);
		// starts death animation then sends object to checkpoint coords and resets speed variables
		instance_create_layer(x, y, "Instances", obj_death_animation);
		x = checkpointX;
		y = checkpointY;
		vsp = 0;
		hsp = 0;
	}
}

stateSwimming = function()
{
	// playing water sound effect if it isn't already playing
	if !audio_is_playing(snd_level_1_water){
		// playing the sound - 'true' means audio loops
		audio_play_sound(snd_level_1_water, 0, true);
	}
	
	// restarting room if delete pressed
	if keyboard_check_pressed(vk_delete){
		// resetting all things to as they were at the start - player coords and barriers existing
		checkpointX = 640;
		checkpointY = 736;
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
		// readding barriers if they're gone
		if (!instance_exists(obj_level_1_barrier_1)) instance_create_layer(560, 64, "Instances_1", obj_level_1_barrier_1);
		if (!instance_exists(obj_level_1_barrier_2)) instance_create_layer(624, 64, "Instances_1", obj_level_1_barrier_2);
		if (!instance_exists(obj_level_1_barrier_3)) instance_create_layer(1280, 592, "Instances_1", obj_level_1_barrier_3);
		// restarting room
		room_restart();
	}

	//calculating player movement
	
	// Getting inputs - using local variables
	var keyRight = keyboard_check(vk_right);
	var keyLeft = keyboard_check(vk_left);
	var keyJump = keyboard_check_pressed(vk_up);

	//work out where to move horizontally - dividing walk speed to player moves slower
	hsp = (keyRight - keyLeft) * (hspWalk/2);

	//work out where to move vertically - dividing gravity so player falls slower in water
	vsp = vsp + (grv/3);
	
	// if on moving vertical platform
	// making (platform) vertical movement variable a local variable because they can be used in with statements
	var pvsp = 0;
	with obj_level_1_moving_platform{
		// making local variable the platform's vertical speed
		pvsp = vsp;
	}
	// Second moving platform
	var pvsp2 = 0;
	with obj_level_1_moving_platform_2{
		// making local variable the platform's vertical speed
		pvsp2 = vsp;
	}
	// collisions with moving platforms - before collisions with wall object so wall collisions take precidence
	if place_meeting(x, y + vsp, obj_level_1_moving_platform) or place_meeting(x, y + vsp, obj_level_1_moving_platform_2){
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_level_1_moving_platform)) and (!place_meeting(x, y + vsp, obj_level_1_moving_platform_2)) y += vsp;
		}
		vsp = 0;
	}
	// so player moves with moving platform if on platform - before jump so can jump while on platform
	if place_meeting(x, y+0.1, obj_level_1_moving_platform){
		canJump = canJumpResetValue;
		vsp = pvsp;
	}
	// second moving platform
	if place_meeting(x, y+0.1, obj_level_1_moving_platform_2){
		canJump = canJumpResetValue;
		vsp = pvsp2;
	}

	//work out if we should jump - canJump doesn't need to be above zero so player can jump in mid-water - swimming - and jump value doesn't need to be regulated
	if keyJump {
		// += not just = so movement relative to inertial frame such as that of moving platform - jump speed divided so jump is smaller in water
		vsp += (vspJump/2);
		canJump = 0;
	}

	//collide and move
	// for x collision can calculate wall and moving platform collisions together, as platform moves vertically so shouldn't mess up horizontal collisions
	if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform) or place_meeting(x + hsp, y, obj_level_1_broken_platform) or place_meeting(x + hsp, y, obj_level_1_moving_platform_2) or place_meeting(x + hsp, y, obj_level_1_barrier_1) or place_meeting(x + hsp, y, obj_level_1_barrier_2) or place_meeting(x + hsp, y, obj_level_1_barrier_3){
		while (abs(hsp) > 0.1){
			hsp *= 0.5;
			if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) and (!place_meeting(x + hsp, y, obj_level_1_broken_platform)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_1)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_3)) x += hsp;
		}
		hsp = 0;
	}
	x += hsp;

	if place_meeting(x, y + vsp, obj_wall) or place_meeting(x, y + vsp, obj_level_1_broken_platform) or place_meeting(x, y + vsp, obj_level_1_barrier_1) or place_meeting(x, y + vsp, obj_level_1_barrier_2) or place_meeting(x, y + vsp, obj_level_1_barrier_3){
		if (vsp > 0) canJump = canJumpResetValue;
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_wall)) and (!place_meeting(x, y + vsp, obj_level_1_broken_platform)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_1)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_2)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_3)) y += vsp;
		}
		vsp = 0;
	} 

	// no bounce pads in the water

	//actually moving (verticallllly) - divided to player slows down upon entering the water (looks good)
	y += vsp/3;

	// death - if hitting kill-y thing
	if place_meeting(x, y, obj_level_1_lava) or place_meeting(x, y, obj_level_1_spikes_ceiling) or place_meeting(x, y, obj_level_1_moving_saw_1) or place_meeting(x, y, obj_level_1_moving_saw_2) or place_meeting(x, y, obj_level_1_moving_saw_3) or place_meeting(x, y, obj_level_1_stationary_saw) or place_meeting(x, y, obj_level_1_moving_saw_4) or place_meeting(x, y, obj_level_1_moving_saw_5) or place_meeting(x, y, obj_level_1_moving_saw_6) or place_meeting(x, y, obj_level_1_missile){
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_level_1_dying, 0, false);
		// starts death animation then sends object to checkpoint coords and resets speed variables
		instance_create_layer(x, y, "Instances", obj_death_animation);
		x = checkpointX;
		y = checkpointY;
		vsp = 0;
		hsp = 0;
	}
}