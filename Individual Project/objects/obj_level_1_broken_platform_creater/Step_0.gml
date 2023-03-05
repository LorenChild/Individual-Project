/// @description So countdown goes down and then creates a new broken platform when it runs out - aka makes the broken platform reappear

// decreaing the countdown value each frame / step / whatever its called
countdown -= 1;

// so it creates a new broken platform then destroys itsself when countdown runs out
if (countdown < 0){
	// plays sound effect - 'false' means it doesn't loop
	audio_play_sound(snd_level_1_broken_platform, 0, false);
	
	instance_create_layer(x, y, layer, obj_level_1_broken_platform);
	instance_destroy(self);
}
 

