/// @description Making button appear darker when level isn't unlocked

// If levels unlocked is less than number of level
if ((global.levelsUnlocked + 1) < 2){
	// switching to second, darker frame
	image_index = 1;
} else{
	// so it stays on first frame if not
	image_index = 0;
}