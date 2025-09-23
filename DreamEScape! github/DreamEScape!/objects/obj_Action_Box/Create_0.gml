//Use layerset for debugging

var layerSet = "Dirtywork";

inst_WallTop     = instance_create_layer(0,0, layerSet, obj_Wall_Hor);
inst_WallBottom  = instance_create_layer(0,0, layerSet, obj_Wall_Hor);
inst_WallLeft    = instance_create_layer(0,0, layerSet, obj_Wall_Ver);
inst_WallRight   = instance_create_layer(0,0, layerSet, obj_Wall_Ver)