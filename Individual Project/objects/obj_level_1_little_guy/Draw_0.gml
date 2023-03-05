/// @description So it draws text when in contact with player object

// So it actually appears and isnt just overwritten by draw event
draw_self();

// drawing text when touching player
if place_meeting(x, y, obj_level_1_player){
	// playing sound effect if the sound effect isn't already playing
	if !audio_is_playing(snd_level_1_little_guy){
		// playing the sound effect - 'true' means audio loops
		audio_play_sound(snd_level_1_little_guy, 0, true);
	}
	// setting text colour to white
	draw_set_color(c_white);
	// drawing text
	draw_text(x - 15, y - 70, "Yeah, I'm stuck \nhere too...")
// stopping the sound effect player no longer touching object (or it would keep playing forever)	
} else if audio_is_playing(snd_level_1_little_guy){
	audio_stop_sound(snd_level_1_little_guy);
}
