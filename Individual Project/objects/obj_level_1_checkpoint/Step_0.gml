/// @description Making it so player resets to the checkpoint when dead after touching it

// if the player touches the checkpoint
if place_meeting(x, y, obj_level_1_player){
	// getting local variables of the position of the checkpoint becuase they can be used in with statements
	var currentCheckpointX = x;
	var currentCheckpointY = y;
	// changing checkpoint coordinate variables in player object which player resets to
	with obj_level_1_player{
		checkpointX = currentCheckpointX;
		checkpointY = currentCheckpointY;
	}
	// making it so checkpoint turns bright white by switching to second frame when touching the player and turning the image alpha up
	image_index = 1;
	image_alpha = 1;
} else{
	// so checkpoint appears normal when not touching player
	image_index = 0;
	image_alpha = 0.2;
}

