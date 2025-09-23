var right = keyboard_check(vk_right) or keyboard_check( ord(vk_down));
var left = keyboard_check(vk_left) or keyboard_check( ord(vk_down));
var up = keyboard_check(vk_up) or keyboard_check( ord(vk_down));
var down = keyboard_check(vk_down) or keyboard_check( ord(vk_down));


var move_x = (right - left) *1.5;
var move_y = (down - up) *1.5;

move_and_collide(move_x, move_y, obj_Wall_Parent);
