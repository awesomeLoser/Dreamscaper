
var pickX = random_range(obj_Player_Soul.bbox_left+ 0, obj_Player_Soul.bbox_right - 20 );

var  bullet = instance_create_layer(pickX, obj_Player_Soul.bbox_top - 80, layer, bullet_Inst, {
	gravity : 0,

	gravity_direction : 270,
	
	image_xscale : 0.3,
	image_yscale : 0.3,
	
		gravity : 0.8,
});


bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(15, 30);
alarm[0] = spawnTime;