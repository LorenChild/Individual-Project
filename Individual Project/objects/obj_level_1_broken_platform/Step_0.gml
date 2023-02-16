/// @description decreasing countdown and destroying platform if player has stepped on it

// checking if player has stepped on platform
if (place_meeting(x, y-1, obj_level_1_player)) steppedOn = 1;

// Countdown goes down if player has stepped on it
if (steppedOn = 1) countdown -= 1;

// so it creates an object to make it reappear in a few seconds and then destroys itsself when countdown runs out
if (countdown < 0){
	instance_create_layer(x, y, layer, obj_level_1_broken_platform_creater);
	instance_destroy(self);
}

