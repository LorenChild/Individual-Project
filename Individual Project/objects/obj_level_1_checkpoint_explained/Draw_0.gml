/// @description drawing text explaining game mechanic
// draw event overwrites drawing of sprite so object appears invisible other than the text

// drawing text if object has been in contact with player and timer hasn't run out
if (playerContact = 1){
	//drawing text + setting text colour to yellow + decreasing alpha slightly to make yellow faded
	draw_text_colour(400, 545, "Checkpoint!", c_yellow, c_yellow, c_yellow, c_yellow, 0.7);
}