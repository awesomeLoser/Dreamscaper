if (cutscene_test == true)
{
	if (triggered == false && scr_check_text("suprisingly. . . still a cutscene"))
{
    instance_create_layer(133, 117, "Player", overworld_enemy_test);
    triggered = true;
}

if (scr_check_text("woah what the fuck is that"))
{
	can_talk = true;
	instance_destroy(inst_1424EC99)
	
}

}