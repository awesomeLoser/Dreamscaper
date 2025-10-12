
//run state machine (???)
battleState();


//Cursor control
if (cursor.active)
{
	with (cursor)
	{
		//input
		var _keyUp = keyboard_check_pressed(vk_up);
		var _keyDown = keyboard_check_pressed(vk_down);
		var _keyLeft = keyboard_check_pressed(vk_left);
		var _keyRight = keyboard_check_pressed(vk_right);
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		confirmDelay++
		if (confirmDelay > 1)
		{
			_keyConfirm = keyboard_check_pressed(ord("Z"));
			_keyCancel = keyboard_check_pressed(ord("X"));
			_keyToggle = keyboard_check_pressed(vk_shift);

		}
		var _moveH = _keyRight - _keyLeft;
		var _moveV = _keyDown - _keyUp;
		

		if ( _moveH == -1) targetSide = oBattle.partyUnits;
		if ( _moveH == 1) targetSide = oBattle.enemyUnits;

		
		//Verify Target List
		if (targetSide == oBattle.enemyUnits)
		{

			targetSide = array_filter(targetSide, function(_element, _index)
			{
				return _element.hp > 0;

			});
		}


		//move between targets
		//show_debug_message("trapes")
		
		
		
		
		
		
		if (targetAll == true) // single target mode
		{
			
			if (_moveV == 1) targetIndex++;
			if (_moveV == -1) targetIndex--;
			//show_debug_message("IM Old!")
			
			//wrap
			var _targets = array_length(targetSide);
			if (targetIndex < 0) targetIndex = _targets - 1;
			if (targetIndex > (_targets - 1)) targetIndex = 0;
			//show_debug_message("I Loled!")
			
			//identify target
			activeTarget = targetSide[targetIndex];
			//show_debug_message("crazy i was vtrazu omne")
			
			//toggle all mode
			if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) // switch to all mode
			{
				targetAll = true;	
				show_debug_message("IM droll!")
			}
		}
			else //target all mode
			{
				activeTarget = targetSide;
				if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) //switch to single mode
				{
					targetAll = false;	
						show_debug_message("bannana")
				}
			}
			
			//confirm action
			if (_keyConfirm)
			{
				//show_debug_message("vjhdgsd")
				with (oBattle) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
				with (oMenu) instance_destroy();
				active = false;
				confirmDelay = 0;
			}
			
			//cancel and return to menu
			if (_keyCancel) && (!_keyConfirm)
			{
				with (oMenu) active = true;
				active = false;
				confirmDelay = 0;
			}

		
	}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

