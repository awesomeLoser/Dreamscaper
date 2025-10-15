
var pickX = random_range(obj_Player_Soul.bbox_left+ 0, obj_Player_Soul.bbox_right - 20 );

var  bullet = instance_create_layer(pickX, obj_Player_Soul.bbox_top - 140, layer, bullet_Inst, {
	gravity : 0.06,

	gravity_direction : 270,
	
	image_xscale : 0.5,
	image_yscale : 0.5,
	
	
});

var  bullet = instance_create_layer(pickX, obj_Player_Soul.bbox_top - -140, layer, bullet_Inst, {
	gravity : 0.06,

	gravity_direction : 90,
	
	image_xscale : 0.5,
	image_yscale : 0.5,
	
	
});
//Distance

var  bullet = instance_create_layer(obj_Player_Soul.bbox_right+ 200 , obj_Player_Soul.bbox_bottom - 20, layer, bullet_Inst, {
	gravity : 0.06,
	gravity_direction : 180,
	
	image_xscale : 0.5,
	image_yscale : 0.5,
	
	
});

var  bullet = instance_create_layer(obj_Player_Soul.bbox_left+ -200 , obj_Player_Soul.bbox_bottom - 20, layer, bullet_Inst, {
	gravity : 0.06,
	gravity_direction : 0,
	
	image_xscale : 0.5,
	image_yscale : 0.5,
	
	
});




bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(50, 100);
alarm[0] = spawnTime;