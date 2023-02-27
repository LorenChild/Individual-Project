/// @description making missile launcher point at player and periodically create bullets if player is in range

// Checking if player is in range (aka distance from it using pythagoras is smaller than a number)
if abs(sqrt((sqr(obj_level_1_player.x-x)) + (sqr(obj_level_1_player.y-y)))) < range{
	// making missile launcher point at player
	image_angle = point_direction(x, y, obj_level_1_player.x, obj_level_1_player.y);
	//counting down on the countdown woo
	countdown-=1;
	// creating a missile and resetting the countdown when countdown runs out
	if countdown <= 0{
		instance_create_layer(x, y, "Instances_2", obj_level_1_missile);
		countdown = countdownResetValue;
	}
}


