
var pickX = random_range(obj_Player_Soul.bbox_left+ 0, obj_Player_Soul.bbox_right - 20 );

var  bullet = instance_create_layer(pickX, obj_Player_Soul.bbox_top - 140, layer, bullet_Inst, {
	gravity : 0.06,

	gravity_direction : 270,
	
	image_xscale : 0.2,
	image_yscale : 0.2,
	
	
});


bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(5, 15);
alarm[0] = spawnTime;