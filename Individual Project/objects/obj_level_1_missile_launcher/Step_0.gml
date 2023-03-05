/// @description making missile launcher point at player and periodically create bullets if player is in range

// Checking if player is in range (aka distance from it using pythagoras is smaller than a number)
if abs(sqrt((sqr(obj_level_1_player.x-x)) + (sqr(obj_level_1_player.y-y)))) < range{
	// making missile launcher point at player
	image_angle = point_direction(x, y, obj_level_1_player.x, obj_level_1_player.y);
	//counting down on the countdown woo - but only if the game isn't paused
	if (global.paused = 0) countdown-=1;
	// creating a missile and resetting the countdown when countdown runs out AND game is not paused
	if (countdown <= 0) and (global.paused = 0){
		// plays sound effect - 'false' means it doesn't loop
		audio_play_sound(snd_level_1_missile, 0, false);

		instance_create_layer(x, y, "Instances_2", obj_level_1_missile);
		countdown = countdownResetValue;
	}
}


