/// @description Setting up movement variables

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
// starting death restart point - x + y values
//checkpointX = 640;
//checkpointY = 736;
// TEMPoRARY FIRST CHECKPOINTS FOR EASE OF TESTING
checkpointX = 830;
checkpointY = 536;

// state machine - creating state functions
// normal state
stateNormal = function()
{
	//calculating player movement
	
	// Getting inputs - using local variables
	var keyRight = keyboard_check(vk_right);
	var keyLeft = keyboard_check(vk_left);
	var keyJump = keyboard_check_pressed(vk_space);

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
	if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform) or place_meeting(x + hsp, y, obj_level_1_broken_platform) or place_meeting(x + hsp, y, obj_level_1_moving_platform_2) or place_meeting(x + hsp, y, obj_level_1_barrier_1) or place_meeting(x + hsp, y, obj_level_1_barrier_2){
		while (abs(hsp) > 0.1){
			hsp *= 0.5;
			if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) and (!place_meeting(x + hsp, y, obj_level_1_broken_platform)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_1)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_2)) x += hsp;
		}
		hsp = 0;
	}
	x += hsp;

	if place_meeting(x, y + vsp, obj_wall) or place_meeting(x, y + vsp, obj_level_1_broken_platform) or place_meeting(x, y + vsp, obj_level_1_barrier_1) or place_meeting(x, y + vsp, obj_level_1_barrier_2){
		if (vsp > 0) canJump = canJumpResetValue;
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_wall)) and (!place_meeting(x, y + vsp, obj_level_1_broken_platform)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_1)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_2)) y += vsp;
		}
		vsp = 0;
	} 

	// if bounce pad touched
	if place_meeting(x, y, obj_level_1_bounce_pad){
		vsp = vspJump*1.65;
	}

	//actually moving (verticallllly)
	y += vsp;

	// death - if hitting kill-y thing
	if place_meeting(x, y, obj_level_1_lava) or place_meeting(x, y, obj_level_1_spikes_ceiling) or place_meeting(x, y, obj_level_1_moving_saw_1) or place_meeting(x, y, obj_level_1_moving_saw_2) or place_meeting(x, y, obj_level_1_moving_saw_3){
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
	//calculating player movement
	
	// Getting inputs - using local variables
	var keyRight = keyboard_check(vk_right);
	var keyLeft = keyboard_check(vk_left);
	var keyJump = keyboard_check_pressed(vk_space);

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
		vsp += (vspJump/3);
		canJump = 0;
	}

	//collide and move
	// for x collision can calculate wall and moving platform collisions together, as platform moves vertically so shouldn't mess up horizontal collisions
	if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform) or place_meeting(x + hsp, y, obj_level_1_broken_platform) or place_meeting(x + hsp, y, obj_level_1_moving_platform_2) or place_meeting(x + hsp, y, obj_level_1_barrier_1) or place_meeting(x + hsp, y, obj_level_1_barrier_2){
		while (abs(hsp) > 0.1){
			hsp *= 0.5;
			if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) and (!place_meeting(x + hsp, y, obj_level_1_broken_platform)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform_2)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_1)) and (!place_meeting(x + hsp, y, obj_level_1_barrier_2)) x += hsp;
		}
		hsp = 0;
	}
	x += hsp;

	if place_meeting(x, y + vsp, obj_wall) or place_meeting(x, y + vsp, obj_level_1_broken_platform) or place_meeting(x, y + vsp, obj_level_1_barrier_1) or place_meeting(x, y + vsp, obj_level_1_barrier_2){
		if (vsp > 0) canJump = canJumpResetValue;
		while (abs(vsp) > 0.1){
			vsp *= 0.5;
			if (!place_meeting(x, y + vsp, obj_wall)) and (!place_meeting(x, y + vsp, obj_level_1_broken_platform)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_1)) and (!place_meeting(x, y + vsp, obj_level_1_barrier_2)) y += vsp;
		}
		vsp = 0;
	} 

	// no bounce pads in the water

	//actually moving (verticallllly) - divided to player slows down upon entering the water (looks good)
	y += vsp/3;

	// death - if hitting kill-y thing
	if place_meeting(x, y, obj_level_1_lava) or place_meeting(x, y, obj_level_1_spikes_ceiling) or place_meeting(x, y, obj_level_1_moving_saw_1) or place_meeting(x, y, obj_level_1_moving_saw_2) or place_meeting(x, y, obj_level_1_moving_saw_3){
		// starts death animation then sends object to checkpoint coords and resets speed variables
		instance_create_layer(x, y, "Instances", obj_death_animation);
		x = checkpointX;
		y = checkpointY;
		vsp = 0;
		hsp = 0;
	}
}