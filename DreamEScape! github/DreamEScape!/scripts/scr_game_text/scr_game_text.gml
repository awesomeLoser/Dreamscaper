///@param _text_id
// Object variables
triggered = false;

function scr_game_text(_text_id){
	switch(_text_id) 
	{
	case "npc 1": 
	scr_text("Woah it's a cactus...", "test char")
		scr_text_color(12, 18, c_green,c_lime,c_white,c_blue )
		scr_text_float(0,4);
	scr_text("Don't look at me like that idiot!", "tsundere", -1)
	scr_text("Holy shit, it talks?", "test char")
	scr_text("W- What about it, B- BAKA!", "tsundere", -1)
			scr_text_shake(0,2); scr_text_shake(18,20)
	   scr_option("We aren't japanese...", "npc 1 - Rude")
	   scr_option("*Hug the cactus*", "npc 1 - Hug")
	   
	  break;
		
		case "npc 1 - Rude":
		scr_text("What? like there aren't any cactuses in japan?", "tsundere", -1)
		scr_text("I'ts cacti, and no", "test char")
		scr_text("I'm pretty sure I'd know what the plural is", "tsundere", -1)
		scr_text("You'd think so, wouldn't you?", "test char")
		break;
				
		case "npc 1 - Hug":
		scr_text("*You Hug the cactus*")
		scr_text("*It is incredibly painful*")
		scr_text("I't's not like I'm enjoying this or anything!", "tsundere", -1)
		scr_text("But... You don't have to stop", "tsundere", -1)
		scr_text("She doesn't seem to notice you bleeding out")
		break;
		
		
	  	case "npc 2": 
	scr_text("i dont care that this is imfamously bad code")
	scr_text("itll run damm it!")
	scr_text("and the people on reddit said it was ok")
	break;
	
		  	case "eyes test": 
		scr_text("Oooh spookey eyes...", "eyes", -1)
		scr_text("Another longer text box so i can test more stuff", "eyes", -1)
		scr_text("I wonder what rebbeca's test dialouge will be like", "eyes", -1)
        break;
		
			case "Ephialtes": 
		scr_text("Do my eyes deceive me, or is that truly a dreamer...", "metamorphosis", 1)
		scr_text("Wandering aimlessly in my domain?", "metamorphosis", 1)
		scr_text("“Welcome, Welcome little one! Welcome to the Dreamscape~! ", "metamorphosis", 1)
		scr_text("Where your dreams come to be, or.. ", "metamorphosis", 1)
		scr_text("They shatter under the heavy stress of nightmares! Hehe…", "metamorphosis", 1)
		scr_text("“...uh, hey- Kid, Stop.. hiding behind me, you're going to crease my ironed sleeves - ", "metamorphosis", 1)
		scr_text("do you know how long it takes to dress nicely in a world like this?", "metamorphosis", 1)
		scr_text("*He brushes himself off*")
		scr_text("..You're probably wondering how you got here, that’s for sure..", "metamorphosis", 1)
		scr_text("But, I can’t help but ponder the same~!”", "metamorphosis", 1)
		scr_text("Most dreamers, such as yourself, don’t directly come here to m–... to the Ring Master’s Carnival of Carnage! ", "metamorphosis", 1)
		scr_text("Hm? Oh.. Did I say 'Carnage', pfft- noo.. ", "metamorphosis",1)
		scr_text("Oh, but where are my manners.. I haven't even introduced myself~", "metamorphosis",1)
		scr_text("Ephialtes, at your service, young dreamer.. I have a hunch that you'll need me on your travels..", "metamorphosis",1)

        break;
		
	case "loop": 
	scr_text("~~~~~~ is tilde")

	break;
	
	case "first_talk": 
	scr_text("wow nice to meet u for the first time!!")
	global.current_speakblock.text_id = "second_talk";

	break;
	
	case "second_talk": 
	scr_text("ugh you again go away")

	break;

		case "cutscene": 
	scr_text("this is a cutscene")	
	global.current_speakblock.text_id = "cutscene_2"
	
	break;
	
		case "cutscene_2":
	scr_text("woah what the fuck is that")
	
	break;
	
			case "save_test_1":
	scr_text("hey woah im mr save test!")
	global.current_speakblock.text_id = "save_test_2"
	
	break;
	
				case "save_test_2":
	
	scr_text("woah hey lets hope saving works!")
	
	break;
	
				case "save_test_3":
	scr_text("Well howdy, I'm miss save test!")
	global.current_speakblock.text_id = "save_test_4"
	
	break;
	
				case "save_test_4":
	
	scr_text("hope my husband hasnt bothered you about saving too much!")
	
	break;
	
	case "bed_save_test":
	scr_text("The potential future of this odd pink world fills you with determination.")
		scr_option("Save", "save")
	   scr_option("Back", "back")
	break;
	
	case "save":
	scr_text("Game Saved!")
	save_game(0)
	break;
	
	case "back":
	scr_text("Game not saved")
	break;
	
		
	case "Mira_bed":
	scr_text("*I can't seem to fall back asleep.. ")
	global.current_speakblock.text_id = "Mira_bed_2"
	break;
	
	case "Mira_bed_2":
	global.current_speakblock.text_id = "Mira_bed_3"
	scr_text("*Staring at this bed won’t help me sleep.")
	break;
	
		case "Mira_bed_3":
	scr_text("*This isn’t deltarune, go through the door.")
	
	break;
	
	case "Mira_poster":
	scr_text("*Huh.. something looks off..")
	scr_text("*Is that... A rabbit?")
	global.current_speakblock.text_id = "Mira_poster_2"
	break;
	
		case "Mira_poster_2":
	scr_text("Carnivals aren’t really my thing.")
	break;
	
	case "Mira_window":
	scr_text("*I feel like I could have done with just one window")
	scr_text("*But then it wouldn't be even")
	global.current_speakblock.text_id = "Mira_window_2"
	break;
	
		case "Mira_window_2":
	scr_text("*Even steven")
	break;
	
	
	
			case "cut_hall":
	scr_text("*My apologies dear girl, I do try not to interfere as per the rules, but...", "metamorphosis", 1)
	scr_text("*Well. you're safe now, by any means.", "metamorphosis", 1)
	scr_text("*Interesting... You have not yet awoken..", "metamorphosis", 1)
	scr_text("*And that door..", "metamorphosis", 1)
	scr_text("*Well anyway, I'm afraid I must say my goodbyes for now.", "metamorphosis", 1)
	scr_text("*You cant follow where I'm going, Unless...", "metamorphosis", 1)
	scr_text("*Well.. I guess we'll see won't we...", "metamorphosis", 1)
	break;
	
	
	
	
	
	}
}