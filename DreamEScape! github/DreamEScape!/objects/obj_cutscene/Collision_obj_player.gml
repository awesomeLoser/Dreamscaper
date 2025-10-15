
if instance_exists(obj_player) 
&& !instance_exists(obj_textbox) 
&& can_talk
{

        create_textbox(text_id);
		in_cutscene = true;
        can_talk = false; // lock talking until textbox is done
   
}