
var pickX = random_range(obj_Action_Box.bbox_left + -155, obj_Action_Box.bbox_top - 150 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_left - random_range(obj_Action_Box.bbox_bottom + -90, obj_Action_Box.bbox_top + -220 ), layer, bullet_Inst, {
	gravity : 0.03,
	gravity_direction : 0,
	
	image_xscale : 1,
	image_yscale : 1,
	
	
});

bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(15, 65);
alarm[0] = spawnTime;