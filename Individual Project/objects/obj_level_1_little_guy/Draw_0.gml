/// @description So it draws text when in contact with player object

// So it actually appears and isnt just overwritten by draw event
draw_self();

// drawing text when touching player
if place_meeting(x, y, obj_level_1_player){
	// setting text colour to white
	draw_set_color(c_white);
	// drawing text
	draw_text(x - 15, y - 50, "Yeah, I'm stuck here too...")
}
