// Alarm 0
if (!instance_exists(self)) return; // safe guard


if (instance_exists(global.box)) {
    var pickX = random_range(global.box.bbox_left + -30, global.box.bbox_right - -30);
} else {
    var pickX = 100; // fallback
}


// Ensure we have a valid reference to the action box
var bulletY;

if (instance_exists(global.box)) {
    bulletY = global.box.bbox_top - 70;
} else {
    bulletY = 100; // fallback if box is missing
}

// Create the bullet
var bullet = instance_create_layer(
    pickX,
    bulletY,
    "Bullets",
    bullet_Inst,
    {
        gravity: 0.028,
        gravity_direction: 270,
        image_xscale: 0.4,
        image_yscale: 0.4
    }
);
bullet.is_bullet = true;

bullet.dmg = bullet_Dmg;

// Set next spawn
spawnTime = irandom_range(5, 15);
alarm[0] = spawnTime;
