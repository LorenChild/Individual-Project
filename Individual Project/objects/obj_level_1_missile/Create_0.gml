/// @description setting speed and direction

// variable for missile's speed - using in-built variable since it automatically moves that speed each turn
speed = 10;

// setting missile's direction to the player - only when created so its not a targeted missile, just aimed
direction = point_direction(x, y, obj_level_1_player.x, obj_level_1_player.y);

// making it point in the direction its going
image_angle = direction;

// making it so explosion animation does not play immediately
image_speed = 0;