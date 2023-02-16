/// @description Sends the player to other portal if it touches it, reversing its vertical and horizontal speeds 

// if player touches portal and portals are on
if place_meeting(x, y, obj_level_1_player) and (global.portalsOn = 1){
	// turning portals off
	global.portalsOn = 0;
	//moving player to position of other portal
	with obj_level_1_player{
		x = instance_nearest(x, y, obj_level_1_portal_1).x;
		y = instance_nearest(x, y, obj_level_1_portal_1).y;
		//reversing player's vertical and horizontal speeds
		vsp = -vsp;
		hsp = -hsp;
	}
}

