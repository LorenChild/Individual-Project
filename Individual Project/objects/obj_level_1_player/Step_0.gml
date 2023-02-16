/// @description Calculating player movement

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
// collisions with moving platform - before collisions with wall object so wall collisions take precidence
if place_meeting(x, y + vsp, obj_level_1_moving_platform){
	while (abs(vsp) > 0.1){
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, obj_level_1_moving_platform)) y += vsp;
	}
	vsp = 0;
}
// so player moves with moving platform if on platform - before jump so can jump while on platform
if place_meeting(x, y+0.1, obj_level_1_moving_platform){
	canJump = canJumpResetValue;
	vsp = pvsp;
}

//work out if we should jump
if canJump-- > 0 and keyJump{
	// += not just = so movement relative to inertial frame such as that of moving platform
	vsp += vspJump;
	canJump = 0;
}

//collide and move
// for x collision can calculate wall and moving platform collisions together, as platform moves vertically so shouldn't mess up horizontal collisions
if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform) or place_meeting(x + hsp, y, obj_level_1_broken_platform){
	while (abs(hsp) > 0.1){
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) and (!place_meeting(x + hsp, y, obj_level_1_broken_platform)) x += hsp;
	}
	hsp = 0;
}
x += hsp;

if place_meeting(x, y + vsp, obj_wall) or place_meeting(x, y + vsp, obj_level_1_broken_platform){
	if (vsp > 0) canJump = canJumpResetValue;
	while (abs(vsp) > 0.1){
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, obj_wall)) and (!place_meeting(x, y + vsp, obj_level_1_broken_platform)) y += vsp;
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
