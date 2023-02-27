/// @description Making it explode and disappar when hitting the player or a wall

//checking if its hit the player or a wall
if place_meeting(x, y, obj_level_1_player) or place_meeting(x, y, obj_wall){
	// making it stop moving
	speed = 0;
	//playing animation
	image_speed = 1;
}

//destroying itsself when animation has finished
if image_index >= (image_number-1) instance_destroy(self);
