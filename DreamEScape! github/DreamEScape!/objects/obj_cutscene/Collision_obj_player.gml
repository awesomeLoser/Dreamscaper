
if instance_exists(obj_player) 
&& !instance_exists(obj_textbox) 
&& can_talk
{
		global.current_speakblock = id;
        create_textbox(text_id);
		in_cutscene = true;
        can_talk = false; // lock talking until textbox is done
		

		if (text_id == "cutscene")
		{
		cutscene_test = true	
		}
}

