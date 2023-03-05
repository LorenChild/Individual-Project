/// @description controlling saw movement - but only if game not paused

// if game isn't paused...
if global.paused = 0{
	// adding vertical speed to y value - moving the saw
	y += vsp;

	// adding the vertical speed increase value to the vertical speed value
	vsp += vspi;

	// deciding if the vspi value needs to switch from positive to negative or vise versa
	if (vsp >= 2.2) or (vsp <= -2.2){
		vspi = -vspi;
	}
}

