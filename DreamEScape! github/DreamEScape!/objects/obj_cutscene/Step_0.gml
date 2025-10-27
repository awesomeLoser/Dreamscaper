
//show_debug_message("cutscene step = " + string(cutscene_step));
if (cutscene_test == true)
{


    // Step 1: Spawn sequence and wait for it to finish
    if (cutscene_step == 0)
    {
		
        if (seq == noone)
        {
			show_debug_message("Snoone");
            seq = layer_sequence_create(layer, global.current_speakblock.x, global.current_speakblock.y, seq_test);  
			layer_sequence_create(layer, global.current_speakblock.x, global.current_speakblock.y, seq_test);
            show_debug_message("Sequence spawned");
			show_debug_message("cutscene step = " + string(cutscene_step));
        }
        if (seq_test_Moment.sequence_dead = true)
        {
			show_debug_message("sequence ded");
		   
			show_debug_message("cutscene step = " + string(cutscene_step));
            // sequence finished, move to next step
        }
    }

    // Step 2: Spawn new textbox after sequence ends
    if (cutscene_step == 1)
    {
        if (!instance_exists(obj_textbox)) 
        {
			show_debug_message("cutscene step = " + string(cutscene_step));
            global.current_speakblock.text_id = "cutscene_2"; // new text ID
			show_debug_message("text id = " + string(global.current_speakblock.text_id));
            create_textbox(global.current_speakblock.text_id);
            cutscene_step++; // move to next step
        }
    }

    // Step 3: End cutscene after new textbox is done
    if (cutscene_step == 2)
    {
		show_debug_message("cutscene step = " + string(cutscene_step));
        if (!instance_exists(obj_textbox))
        {
			
            can_talk = true;
            in_cutscene = false;
			cutscene_test = false;
            instance_destroy(global.current_speakblock);
            show_debug_message("Cutscene finished");
        }
    }
}
