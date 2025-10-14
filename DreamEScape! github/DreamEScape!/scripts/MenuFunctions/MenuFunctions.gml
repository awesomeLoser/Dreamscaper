/// @desc Menu - makes a menu, options provided in the form [["name", function, argument], [...]]
function Menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined) {
    with (instance_create_depth(_x, _y, -99999, oMenu)) {
        options = _options;
        description = _description;
        var _optionsCount = array_length(_options);
        visibleOptionsMax = _optionsCount;

        // Set up size
        xmargin = 10;
        ymargin = 8;
        draw_set_font(global.font_main);
        heightLine = 12;

        // Auto Width
        if (_width == undefined) {
            width = 1;
            if (_description != -1) width = max(width, string_width(_description));
            for (var i = 0; i < _optionsCount; i++) {
                width = max(width, string_width(_options[i][0]));
            }
            widthFull = width + xmargin * 2;
        } else {
            widthFull = _width;
        }

        // Auto Height
        if (_height == undefined) {
            height = heightLine * (_optionsCount + !(description == -1));
            heightFull = height + ymargin * 2;
        } else {
            heightFull = _height;

            // Scrolling support
            if (heightLine * (_optionsCount + !(description == -1)) > _height - (ymargin * 2)) {
                scrolling = true;
                visibleOptionsMax = (_height - ymargin * 2) div heightLine;
            }
        }
    }
}

function SubMenu(_options) {
    optionsAbove[subMenuLevel] = options;
    subMenuLevel++;
    options = _options;
    hover = 0;
}

function MenuGoBack() {
    subMenuLevel--;
    options = optionsAbove[subMenuLevel];
    hover = 0;
}

/// @desc Called when a player selects an action (like Attack)
function MenuSelectAction(_user, _action) {
    with (oMenu) active = false;

    // Activate targeting cursor if needed
    with (oBattle) {
        if (_action.targetRequired) {
            with (cursor) {
                active = true;
                confirmDelay = 0;
                activeAction = _action;
                activeUser = _user;

                // Initialize targeting mode
                targetAll = (_action.targetAll == MODE.ALWAYS);

                // Determine default target side
                if (_action.targetEnemyByDeafult) {
                    targetSide = "enemy";
                    var _enemies = array_filter(oBattle.enemyUnits, function(e) { return e.hp > 0; });
                    if (array_length(_enemies) > 0) {
                        targetIndex = 0;
                        activeTarget = _enemies[targetIndex];
                    } else {
                        activeTarget = [];
                        show_debug_message("No valid enemies to target.");
                        active = false;
                        BeginAction(_user, _action, []);
                    }
                } else {
                    targetSide = "party";
                    var _allies = array_filter(oBattle.partyUnits, function(p) { return p.hp > 0; });
                    targetIndex = array_find_index(_allies, function(p) { return p == _user; });
                    activeTarget = _user;
                }
            }
        } else {
            // No target needed, just perform the action
            BeginAction(_user, _action, []);
            with (oMenu) instance_destroy();
        }
    }
}
