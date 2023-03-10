/// @description controlling saw movement - but only if game not paused

// if game isn't paused...
if global.paused = 0{
	// adding horizontal speed to x value - moving the saw
	x += hsp;

	// adding the horizontal speed increase value to the horizontal speed value
	hsp += hspi;

	// deciding if the hspi value needs to switch from positive to negative or vise versa
	if (hsp >= 4.7) or (hsp <= -4.7){
		hspi = -hspi;
	}
}
