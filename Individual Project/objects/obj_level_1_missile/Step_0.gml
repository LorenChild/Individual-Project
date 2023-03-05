/// @description Making it explode and disappar when hitting the player or a wall

//checking if its hit the player or a wall
if place_meeting(x, y, obj_level_1_player) or place_meeting(x, y, obj_wall){
	// plays sound effect if sound effect not already playing - 'false' means it doesn't loop
	if (!audio_is_playing(snd_level_1_missile_explosion)) audio_play_sound(snd_level_1_missile_explosion, 0, false);
	// making it stop moving
	speed = 0;
	//playing animation
	image_speed = 1;
}

//destroying itsself when animation has finished
if image_index >= (image_number-1) instance_destroy(self);

// so missiles can't move if the game is paused
// if the missile isn't already exploding...
if (image_speed = 0){
	// if game paused...
	if (global.paused = 1){
		// stopping missile from moving
		speed = 0;
	// setting speed back to normal if game unpaused and missile not exploding
	} else speed = 10;
}