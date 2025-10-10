
var dx = 0;
var dy = 0;
var right = keyboard_check(vk_right) or keyboard_check( ord(vk_down)) dx-=1;
var left = keyboard_check(vk_left) or keyboard_check( ord(vk_down)) dx+=1;
var up = keyboard_check(vk_up) or keyboard_check( ord(vk_down)) dy+=1
var down = keyboard_check(vk_down) or keyboard_check( ord(vk_down)) dy-=1;


var move_x = (right - left) *4;
var move_y = (down - up) *4;

x = x +dx * move_x
y = y + dy * move_y
move_and_collide(move_x, move_y, obj_Wall_Parent);

//Dash
//if (keyboard_check(ord("vk_shift")) && keyboard_check(ord("vk_right")))
//{
//Code to execute when both keys are pressed
//}

//Blinking for When player is hit
#region blinking

//This is our Game Collision
#region Collision

var collInstances = collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, obj_Enemy_Bullet_Parent, 0,0 );
if( collInstances != noone and state == "idle") {
	 show_debug_message(collInstances);
 state = "hit";

}
#endregion

if(state == "hit") {
	
	hitBlinkTimer--;
	if(hitBlinkTimer<= 0)
	{

	hitBlinkTimer = hitBlinkTime;
	//
	if (image_alpha == 1)
	{
		image_alpha = hitalpha;
	}
	else {image_alpha = 1; }
	}

	// Invunrability after being hit/and getting hit
	hitTimer--;
	if(hitTimer <= 0){
	hitBlinkTimer = hitBlinkTime;
	image_alpha = 1;
	hitTimer = hitTime;
	state = "idle";
	}
}

#endregion

//Rotation
if (dx!=0) or (dy!=0) image_angle = point_direction(0,0,dx,dy);
image_angle = direction;