
var pickX = random_range(obj_Action_Box.bbox_left + -400, obj_Action_Box.bbox_left + -300 );

var  bullet = instance_create_layer(pickX, obj_Action_Box.bbox_left - random_range(obj_Action_Box.bbox_bottom + 20, obj_Action_Box.bbox_top + 20 ), layer, bullet_Inst, {
	gravity : 0.04,
	gravity_direction : 0,
	
	image_xscale : 0.4,
	image_yscale : 0.4,
	
	
	
});

var pickY = random_range(obj_Action_Box.bbox_left + 400, obj_Action_Box.bbox_left + 300);

var  bullet2 = instance_create_layer(pickY, obj_Action_Box.bbox_left + random_range(obj_Action_Box.bbox_bottom + -90, obj_Action_Box.bbox_top + -300 ), layer, bullet_Inst, {

    image_angle: 180,
	gravity : 0.04,
	gravity_direction : 180,
	
	image_xscale : 0.4,
	image_yscale : 0.4,
	
	
	
});


bullet.dmg = bullet_Dmg;
//loop
spawnTime = irandom_range(15, 55);
alarm[0] = spawnTime;