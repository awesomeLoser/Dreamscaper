//Draw Background Art
draw_sprite( battleBackground,0,x,y)

//Draw units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++;)
{
	with (unitRenderOrder[i])
	{
	draw_self();	
	}
}

//Draw UI Boxes
draw_sprite_stretched(sBox,0,x+75,y+156,213,60);
draw_sprite_stretched(sBox,0,x,y+156,74,60);

//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
#macro COLUMN_MP 220

//Draw Headings
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x+COLUMN_ENEMY, y+160,"ENEMY");
draw_text(x+COLUMN_NAME, y+160,"NAME");
draw_text(x+COLUMN_HP, y+160,"HP");
draw_text(x+COLUMN_MP, y+160,"MP");

//Draw Enemy Names
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top)
draw_set_color(c_white);
var _drawLimit = 3;
var _drawn = 0;
for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++)
{
	var _char = enemyUnits[i];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		if (_char.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY,y+170+(i*12),_char.name);
	}
}

//Draw party info
for (var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _char = partyUnits[i];
	if (_char.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+170+(i*12),_char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if (_char.hp < (_char.hpMax * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+50,y+170+(i*12),string(_char.hp) + "/" + string(_char.hpMax));
	
	draw_set_color(c_white);
	if (_char.mp < (_char.mpMax * 0.5)) draw_set_color(c_orange);
	if (_char.mp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_MP+50,y+170+(i*12),string(_char.mp) + "/" + string(_char.mpMax));
}

//draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		if (activeTarget != noone)
		{
			if (!is_array(activeTarget))
			{
				draw_sprite(spr_menu_arrow,0,activeTarget.x,activeTarget.y);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1);
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(spr_menu_arrow,0,activeTarget[i].x,activeTarget[i].y);	
				}
				draw_set_alpha(1.0);
			}
		}
	}
}
























