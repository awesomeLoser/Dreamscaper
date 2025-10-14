 /// @desc Menu - makes a menu, options provided in the form [["name", function, argument], [...]]
function Menu(_x,_y, _options, _description = -1, _width = undefined, _height = undefined)
{
	with (instance_create_depth(_x,_y,-99999,oMenu))
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//set up size
		xmargin = 10;
		ymargin = 8;
		draw_set_font(global.font_main);
		heightLine = 12;
		
		//Auto Width
		if (_width == undefined)
		{
			width = 1;
			if (_description != -1) width = max(width, string_width(_description));
			for (var i = 0; i < _optionsCount; i++)
			{
				width = max(width, string_width(_options[1][0]));	
			}
			widthFull = width + xmargin * 2;
		} else widthFull = _width;
		
		//auto height
		if (_height == undefined)
		{
			height = heightLine * (_optionsCount + !(description == -1));
			heightFull = height + ymargin * 2;
		}
		else
		{
			heightFull 	= _height
			//scrolling??????
			if (heightLine * (_optionsCount + !(description == -1)) > _height - (ymargin*2))
			{
				scrolling = true;
				visibleOptionsMax = (_height - ymargin * 2) div heightLine;
			}
		}
	}
}

function SubMenu(_options)
{
	//store old options in array and increase submenu level
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction(_user, _action)
{
	with (oMenu) active = false;
	
	//activate targeting cursor if needed, or begin action
	with (oBattle) 
	{
		if (_action.targetRequired)
		{
			with (cursor)
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if (targetAll == MODE.VARIES)	targetAll = true; //"toggle" starts as
				activeUser = _user;
				
				//Which side to target by deafult
				if (_action.targetEnemyByDeafult) //target enemy by deafult (go figure)
				{
					targetIndex = 0;
					targetSide = oBattle.enemyUnits;
					activeTarget = oBattle.enemyUnits[targetIndex];
				}
				else //target self by deafult
				{
					targetSide = oBattle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element) 
					{
						return (_element == activeTarget)
					}
					targetIndex = array_find_index(oBattle.partyUnits, _findSelf);
				}
				
			}

          }
	else
			{
				// if no target needed begin the action and exit the menu
				BeginAction(_user, _action, -1);
				with (oMenu) instance_destroy();
			}

	}

}