/// @description Sends the player to other portal if it touches it, reversing its vertical and horizontal speeds 

// if player touches portal and portals are on
if place_meeting(x, y, obj_level_1_player) and (global.portalsOn = 1){
	// plays sound effect - 'false' means it doesn't loop
	audio_play_sound(snd_level_1_portal, 0, false);
	// turning portals off
	global.portalsOn = 0;
	//moving player to position of other portal
	with obj_level_1_player{
		x = instance_nearest(x, y, obj_level_1_portal_2).x;
		y = instance_nearest(x, y, obj_level_1_portal_2).y;
		//reversing player's vertical and horizontal speeds
		vsp = -vsp;
		hsp = -hsp;
	}
	
}

// turning portals back on when player has left them
if (global.portalsOn = 0){
	with obj_level_1_player{
		if (!place_meeting(x, y, obj_level_1_portal_1)) and (!place_meeting(x, y, obj_level_1_portal_2)){
			global.portalsOn = 1;
		}
	}
}
