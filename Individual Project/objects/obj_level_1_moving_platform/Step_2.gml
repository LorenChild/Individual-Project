/// @description Controlling platform movement

////checks if player object is on platform and if so, makes player object move with the platform
//if place_meeting(x, y+1, obj_level_1_player){
//	with(obj_level_1_player){
//		vsp = lvsp;
//	}
//}

// Checks if platform changing direction
if place_meeting(x, y + vsp, obj_level_1_moving_platform_changing_direction){
	vsp = -vsp;
}

//local variable because it only needs to last a turn
var lvsp = vsp;

if place_meeting(x, y + lvsp, obj_level_1_player){
	lvsp = 0;
}

//platform movement
y += lvsp;