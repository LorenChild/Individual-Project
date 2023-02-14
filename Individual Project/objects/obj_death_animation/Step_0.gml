/// @description Object playes animation once when created then destroys its self
//checks if animation is on last frame and, if so, destroys its self
if image_index >= image_number - 1
{
  instance_destroy(self);
}

