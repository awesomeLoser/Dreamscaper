var right = keyboard_check(vk_right);
var left  = keyboard_check(vk_left);
var up    = keyboard_check(vk_up);
var down  = keyboard_check(vk_down);


var dx = 0;
var dy = 0;

var move_x = (right - left) *1.5;
var move_y = (down - up) *1.5;

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

if (state == "hit") {

    if (instance_exists(collInstances)) {
        var damage = 0;

        // Make sure the instance has the "dmg" variable
        if (variable_instance_exists(collInstances, "dmg")) {
            damage = collInstances.dmg;
        }

        if (!is_hit) {
            instance_destroy(collInstances);
        }

        if (array_length(oBattle.partyUnits) > 0 && !is_hit) {
            oBattle.partyUnits[0].hp -= damage;
            is_hit = true;
        }
    }

	
	//global: party{} _char.hp
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
	is_hit = false;
	}
  
}

#endregion

//Rotation
if (dx!=0) or (dy!=0) image_angle = point_direction(0,0,dx,dy);
image_angle = direction;