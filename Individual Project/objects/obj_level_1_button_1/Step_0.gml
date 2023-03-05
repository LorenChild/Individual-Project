/// @description So it goes down and destroys barrier when touched by player

// if player touches button when if it hasn't been pressed yet...
if (place_meeting(x, y, obj_level_1_player)) and (image_index = 0){
	// plays sound effect - 'false' means it doesn't loop
	audio_play_sound(snd_level_1_button, 0, false);
	//plays button pressed animation
	image_speed = 1;
	// destroying barrier
	instance_destroy(obj_level_1_barrier_1);
}

// stops button pressed animation on last frame
if image_index >= image_number-1{
  image_speed = 0;
}
