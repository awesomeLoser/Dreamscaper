
var pickX = random_range(obj_Action_Box.bbox_left + -150, obj_Action_Box.bbox_top - 50 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_left - random_range(obj_Action_Box.bbox_bottom + -90, obj_Action_Box.bbox_top + -220 ), layer, bullet_Inst, {
	gravity : 0.04,
	gravity_direction : 0,
	
	image_xscale : 0.4,
	image_yscale : 0.4,
	
	
});

var pickX = random_range(obj_Action_Box.bbox_left + 200, obj_Action_Box.bbox_top - 720 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_left - random_range(obj_Action_Box.bbox_bottom + -90, obj_Action_Box.bbox_top + -220 ), layer, bullet_Inst, {

image_angle: 180,
	gravity : 0.04,
	gravity_direction : 180,
	
	image_xscale : 0.4,
	image_yscale : 0.4,
	
	
});


bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(15, 65);
alarm[0] = spawnTime;