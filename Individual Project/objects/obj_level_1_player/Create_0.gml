/// @description Setting up movement variables

// gravity
grv = 0.2;
// current horizontal speed
hsp = 0;
// current vertical speed
vsp = 0;
//walk speed
hspWalk = 3.5;
// jump speed - negative because measures y axis from top
vspJump = -6;
//are we touching the ground
canJump = 0;
// value to reset canJump to when ground touched
canJumpResetValue = 5;
// starting death restart point - x + y values
checkpointX = 640;
checkpointY = 736;