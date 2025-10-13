// Run state machine (???)
battleState();

// Cursor control
if (cursor.active) {
    with (cursor) {
        // Input
        var _keyUp = keyboard_check_pressed(vk_up);
        var _keyDown = keyboard_check_pressed(vk_down);
        var _keyLeft = keyboard_check_pressed(vk_left);
        var _keyRight = keyboard_check_pressed(vk_right);
        var _keyToggle = false;
        var _keyConfirm = false;
        var _keyCancel = false;

        confirmDelay++;
        if (confirmDelay > 1) {
            _keyConfirm = keyboard_check_pressed(ord("Z"));
            _keyCancel = keyboard_check_pressed(ord("X"));
            _keyToggle = keyboard_check_pressed(vk_shift);
        }

        var _moveH = _keyRight - _keyLeft;
        var _moveV = _keyDown - _keyUp;

        // Assuming targetSide is a string or enum indicating side: "party" or "enemy"
        if (_moveH == -1) targetSide = "party";
        if (_moveH == 1) targetSide = "enemy";

        // Assign targetSide array based on selected side
        var targetArray = [];
        if (targetSide == "enemy") {
            targetArray = array_filter(oBattle.enemyUnits, function(_element, _index) {
                return _element.hp > 0;
            });
        } else if (targetSide == "party") {
            targetArray = array_filter(oBattle.partyUnits, function(_element, _index) {
                return _element.hp > 0;
            });
        }

        // Move between targets
        if (targetAll == false) {  // single target mode
            if (_moveV == 1) targetIndex++;
            if (_moveV == -1) targetIndex--;

            // Wrap around
            var _targets = array_length(targetArray);
            if (targetIndex < 0) targetIndex = _targets - 1;
            if (targetIndex >= _targets) targetIndex = 0;

            // Identify target
            activeTarget = targetArray[targetIndex];

            // Toggle all mode
            if ((activeAction.targetAll == MODE.VARIES) && (_keyToggle)) {
                targetAll = true;    
                show_debug_message("Switched to all-target mode");
            }
        } else {  // target all mode
            activeTarget = targetArray;

            // Toggle single mode
            if ((activeAction.targetAll == MODE.VARIES) && (_keyToggle)) {
                targetAll = false;    
                show_debug_message("Switched to single-target mode");
            }
        }

        // Confirm action
        if (_keyConfirm) {
            with (oBattle) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
            with (oMenu) instance_destroy();
            active = false;
            confirmDelay = 0;
        }

        // Cancel and return to menu
        if ((_keyCancel) && (!_keyConfirm)) {
            with (oMenu) active = true;
            active = false;
            confirmDelay = 0;
        }
    }
}

		
		
		
		


