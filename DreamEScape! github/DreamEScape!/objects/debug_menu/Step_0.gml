//get inputs
var up_key = keyboard_check_pressed(vk_up);
var down_key = keyboard_check_pressed(vk_down);
var accept_key = keyboard_check_pressed(ord("Z"));

//store number of options in current menu
op_length = array_length(option[menu_level]);


//move through the menu
pos += down_key - up_key;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length -1};

//using the options

if accept_key {
	
	var _sml = menu_level;
	
	switch(menu_level) {
	
		//pause menu
			case 0:
			switch(pos) {
				
			case 0: room_goto(room_bullet_fight); break;
			
			case 1: room_goto(test_room_cutscene_test); break;
			
			case 2: room_goto(test_room_rpg_battles); break;
			
			case 3: room_goto(dialouge_walk_test); break;
			
			case 4: room_goto(save_test_LV1); break;
			}
		 break;
	 
		 //settings
		 case 1:
		  switch(pos) {
			  //window size
			  case 0:
		  
			  break;
		  
			    //brightness
			  case 1:
		  
			  break;
		  
			    //controls
			  case 2:
		  
			  break;
		  
			    //back
			  case 3:
			  menu_level = 0; 
			  break;
		  }
	  }
		
	//set position back
	if _sml != menu_level {pos = 0};

	//correct option length
	op_length = array_length(option[menu_level]);

	}
	
//audio when u move in the menu add sound later
	//if (pos != last_selected) audio_play_sound(YOUR SOUND NAME, 1, false);
//last_selected = pos;