/// @description Calculating player movement

// Getting inputs - using local variables
var keyRight = keyboard_check(vk_right);
var keyLeft = keyboard_check(vk_left);
var keyJump = keyboard_check_pressed(vk_space);

//work out where to move horizontally
hsp = (keyRight - keyLeft) * hspWalk;

//work out where to move vertically
vsp = vsp + grv;

//work out if we should jump
if canJump-- > 0 and keyJump{
	vsp = vspJump;
	canJump = 0;
}

//collide and move
if place_meeting(x + hsp, y, obj_wall) or place_meeting(x + hsp, y, obj_level_1_moving_platform){
	while (abs(hsp) > 0.1){
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, obj_wall)) and (!place_meeting(x + hsp, y, obj_level_1_moving_platform)) x += hsp;
	}
	hsp = 0;
}
x += hsp;

if place_meeting(x, y + vsp, obj_wall){
	if (vsp > 0) canJump = 5;
	while (abs(vsp) > 0.1){
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, obj_wall)) y += vsp;
	}
	vsp = 0;
} else {
	// else so that collisions with walls take precidence
	if place_meeting(x, y + vsp, obj_level_1_moving_platform){
	canJump = 5;
	while (abs(vsp) > 0.1){
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, obj_level_1_moving_platform)) y += vsp;
	}
	vsp = 0;
	}
	// if on moving vertical platform
	if place_meeting(x, y+0.1, obj_level_1_moving_platform){
		// making vertical movement variable a local variable because they can be used in with statements
		var lvsp = vsp;
		with obj_level_1_moving_platform{
			lvsp = vsp;
		}
		if (vsp!=lvsp) vsp += lvsp;
	}

}
// if bounce pad touched
if place_meeting(x, y, obj_level_1_bounce_pad){
	vsp = vspJump*2;
}

//actually moving
y += vsp;

// death - if hitting kill-y thing
if place_meeting(x, y, obj_level_1_lava) or place_meeting(x, y, obj_level_1_spikes_ceiling){
	// restarts room for now - checkpoint system implemented later
	room_restart();
}
