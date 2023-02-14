/// @description Controlling platform movement

// Checks if platform changing direction
if place_meeting(x, y + vsp, obj_level_1_moving_platform_changing_direction){
	vsp = -vsp;
}

//local variable because it only needs to last a turn
var lvsp = vsp;

// so platform stops right next to player if player is in its way
if place_meeting(x, y + lvsp, obj_level_1_player){
	while (abs(lvsp) > 0.1){
		lvsp *= 0.5;
		if (!place_meeting(x, y + lvsp, obj_level_1_player)) y += lvsp;
	}
	lvsp = 0;
}

//platform movement
y += lvsp;