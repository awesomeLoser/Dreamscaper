// Auto-generated stubs for each available event.

function seq_hallway_mid()
{
	show_debug_message("moment ran");
    layer_sequence_destroy(self.elementID);
	seq_hallway_mid.sequence_dead = true;
	 obj_cutscene.cutscene_step = 1; 
}

function seq_hallway_mid_2()
{
	show_debug_message("moment ran ");
	seq_hallway_mid_2.sequence_dead = true
    layer_sequence_destroy(self.elementID);
	 obj_cutscene.cutscene_step = 3; 
}