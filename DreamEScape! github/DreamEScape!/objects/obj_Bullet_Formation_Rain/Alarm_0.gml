
var pickX = random_range(obj_Action_Box.bbox_left+ 5, obj_Action_Box.bbox_right - 5 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_top - 20, layer, bullet_Inst, {
	gravity : 0.03,
	gravity_direction : 270,
	
	image_xscale : 2,
	image_yscale : 2,
	
	
});

bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(15, 30);
alarm[0] = spawnTime;