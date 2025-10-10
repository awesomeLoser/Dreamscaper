
var pickX = random_range(obj_Action_Box.bbox_left+ 5, obj_Action_Box.bbox_right - 5 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_top - 340, layer, bullet_Inst, {
	gravity : 0.08,
	gravity_direction : 270,
	
	image_xscale : 1,
	image_yscale : 1,
	
	
});

bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(5, 15);
alarm[0] = spawnTime;