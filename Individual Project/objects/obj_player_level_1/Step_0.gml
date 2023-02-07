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
if place_meeting(x + hsp, y, obj_wall){
	while (abs(hsp) > 0.1){
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, obj_wall)) x += hsp;
	}
	hsp = 0;
}
x += hsp;

if place_meeting(x, y + vsp, obj_wall){
	if (vsp > 0) canJump = 10;
	while (abs(vsp) > 0.1){
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, obj_wall)) y += vsp;
	}
	vsp = 0;
}
y += vsp;
