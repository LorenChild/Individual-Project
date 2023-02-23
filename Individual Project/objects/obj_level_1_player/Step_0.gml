/// @description choosing which code to run

// only runs movement code if game isnt paused
if global.paused = 0{
	// runs swimming movement code if player in water, else runs normal movement code
	if place_meeting(x, y, obj_level_1_water){
		stateSwimming();
	} else stateNormal();
}


