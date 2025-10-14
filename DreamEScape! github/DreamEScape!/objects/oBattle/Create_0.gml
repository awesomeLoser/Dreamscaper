
audio_play_sound(mus_battle,0,true);
// -----------------------------
// Battle Setup
// -----------------------------
instance_deactivate_all(true);
instance_create_layer(0,0,"Bullets",obj_battle_trans);

units = [];
enemyUnits = [];
partyUnits = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
battleText = "";

currentUser = noone;
currentAction = -1;
currentTargets = noone;

subMenuLevel = 0;

// Bullet hell control
bulletHellActive = false;
firstEnemyThisRound = true;
bulletTime = 3 * room_speed;
bulletTimer = bulletTime;

// Cursor setup
cursor = {
    activeUser: noone,
    activeTarget: noone,
    activeAction: -1,
    targetSide: -1,
    targetIndex: 0,
    targetAll: false,
    confirmDelay: 0,
    active: false
};

// -----------------------------
// Create enemies
// -----------------------------
for (var i = 0; i < array_length(enemies); i++) {
    var inst = instance_create_depth(
        x + 250 + (i*10),
        y + 68 + (i*20),
        depth - 10,
        oBattleUnitEnemy,
        enemies[i]
    );
    enemyUnits[i] = inst;
    array_push(units, inst);
}

// -----------------------------
// Create party units (only 1 member)
// -----------------------------
partyUnits = [];
if (array_length(global.party) > 0) {
    var inst = instance_create_depth(
        x + 70,         // X position
        y + 68,         // Y position
        depth - 10,     // Depth
        oBattleUnitPC,  // Object
        global.party[0] // Data struct
    );
    array_push(partyUnits, inst); // ✅ push, do NOT assign to index 0
    array_push(units, inst);
}

// -----------------------------
// Shuffle turn order safely
// -----------------------------
var shuffledParty = array_shuffle(partyUnits);
var shuffledEnemies = array_shuffle(enemyUnits);

// manually combine
unitTurnOrder = [];
for (var i = 0; i < array_length(shuffledParty); i++) array_push(unitTurnOrder, shuffledParty[i]);
for (var i = 0; i < array_length(shuffledEnemies); i++) array_push(unitTurnOrder, shuffledEnemies[i]);



	


// -----------------------------
// Render order
// -----------------------------
RefreshRenderOrder = function() {
    unitRenderOrder = [];
    array_copy(unitRenderOrder, 0, units, 0, array_length(units));
    array_sort(unitRenderOrder, function(a,b){ return a.y - b.y; });
};
RefreshRenderOrder();

// -----------------------------
// Health order functions
// -----------------------------
RefreshPartyHealthOrder = function() {
    partyUnitsByHP = [];
    array_copy(partyUnitsByHP, 0, partyUnits, 0, array_length(partyUnits));
    array_sort(partyUnitsByHP, function(a,b){ return b.hp - a.hp; });
};

RefreshEnemyHealthOrder = function() {
    enemyUnitsByHP = [];
    array_copy(enemyUnitsByHP, 0, enemyUnits, 0, array_length(enemyUnits));
    array_sort(enemyUnitsByHP, function(a,b){ return b.hp - a.hp; });
};

AreAllEnemiesDead = function() {
    for (var i=0; i<array_length(enemyUnits); i++)
        if (instance_exists(enemyUnits[i]) && enemyUnits[i].hp > 0) return false;
    return true;
};

// -----------------------------
// Battle states
// -----------------------------
BattleStateSelectAction = function() {
    if (!instance_exists(oMenu)) {
        var _unit = unitTurnOrder[turn];

        if (!instance_exists(_unit) || _unit.hp <= 0 || AreAllEnemiesDead()) {
            battleState = BattleStateVictoryCheck;
            return;
        }

        // Player controlled unit
        if (_unit.object_index == oBattleUnitPC) {
            var _menuOptions = [];
            var _subMenus = {};
            var _actionlist = _unit.actions;

            for (var i=0; i<array_length(_actionlist); i++) {
                var _action = _actionlist[i];
                var _available = true;
                var _name = _action.name;

                if (_action.subMenu == -1) {
                    array_push(_menuOptions, [_name, MenuSelectAction, [_unit,_action], _available]);
                } else {
                    if (is_undefined(_subMenus[$ _action.subMenu]))
                        variable_struct_set(_subMenus, _action.subMenu, [[_name, MenuSelectAction, [_unit,_action], _available]]);
                    else
                        array_push(_subMenus[$ _action.subMenu], [_name, MenuSelectAction, [_unit,_action], _available]);
                }
            }

            var _subNames = variable_struct_get_names(_subMenus);
            for (var i=0; i<array_length(_subNames); i++) {
                array_push(_subMenus[$ _subNames[i]], ["Back", MenuGoBack, -1, true]);
                array_push(_menuOptions, [_subNames[i], SubMenu, [_subMenus[$ _subNames[i]]], true]);
            }

            Menu(x+10, y+110, _menuOptions, undefined, 74, 60);
        }
// Enemy unit
else if (_unit.object_index == oBattleUnitEnemy) {
    currentUser = _unit; // assign the enemy so it can be processed

    if (firstEnemyThisRound) {
        // First enemy triggers bullet hell
        firstEnemyThisRound = false;
        bulletHellActive = true;
        bulletTimer = bulletTime;
				
		// Spawn bullet pattern based on enemy key
    switch (currentUser.enemyKey) {
        case "tree_test":
            attack = instance_create_layer(100, 12, "soul", obj_Bullet_Formation_Rain);
            break;
        case "bug_test":
           attack = instance_create_layer(100, 12, "soul", obj_Bullet_Formation_Rain);
            break;
        default:
            attack = instance_create_layer(100, 12, "soul", obj_Bullet_Formation_Rain);
            break;
    }


				
		soul = instance_create_layer(120, 80, "soul", obj_Player_Soul);
		soul.image_yscale = 0.3
		soul.image_xscale = 0.3
		
		global.box = instance_create_layer(100, 12, "soul", obj_Action_Box);
		global.box.image_xscale = 1;
		global.box.image_yscale = 0.8;

        // Begin its action normally
        BeginAction(currentUser, currentUser.actions[0], partyUnits);
    }
    else {
        // Other enemies: skip their turn completely
        // Do NOT call BeginAction or show attack animation/text
        battleState = BattleStateTurnProgression;
        return;
    }
}


    }
};

BeginAction = function(_user,_action,_targets) {
    currentUser = _user;
    currentAction = _action;
    currentTargets = is_array(_targets) ? _targets : [_targets];
    battleText = string_ext(_action.description, [_user.name]);
    battleWaitTimeRemaining = battleWaitTimeFrames;

    with (_user) {
        acting = true;
        if (!is_undefined(_action[$ "userAnimation"]) && !is_undefined(_user.sprites[$ _action.userAnimation])) {
            sprite_index = sprites[$ _action.userAnimation];
            image_index = 0;
        }
    }

    battleState = BattleStatePerformAction;
};

BattleStatePerformAction = function() {
    if (!instance_exists(currentUser)) return;

    if (currentUser.acting) {
        if (currentUser.image_index >= currentUser.image_number-1) {
            with (currentUser) {
                sprite_index = sprites.idle;
                image_index = 0;
                acting = false;
            }

            if (currentUser.object_index == oBattleUnitEnemy) {
                bulletHellActive = true;
            } else {
                if (variable_struct_exists(currentAction, "effectSprite")) {
                    for (var i=0; i<array_length(currentTargets); i++) {
                        instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1, oBattleEffect, {sprite_index: currentAction.effectSprite});
                    }
                }
       
;
            }
        }
    } else {
// Bullet hell freeze
if (currentUser.object_index == oBattleUnitEnemy && bulletHellActive) {
    bulletTimer--;

    // Only end bullet hell when timer runs out
    if (bulletTimer <= 0) {
        bulletHellActive = false;

        // Stop bullet spawner
		if (instance_exists(attack)) {
		    for (var i = 0; i < 12; i++) attack.alarm[i] = -1; // stop any pending alarms
		    instance_destroy(attack);
		}


        // Destroy box and soul
        if (instance_exists(global.box)) instance_destroy(global.box);
        if (instance_exists(soul)) instance_destroy(soul);

		with (all) {
    if (variable_instance_exists(id, "is_bullet") && is_bullet) {
        instance_destroy();
    }
}



        // Proceed to next battle state
        currentUser = noone;
        battleState = BattleStateTurnProgression;

        // Exit step early
        return;
    }

    // If timer > 0, just freeze the rest
    return;
}



        // Wait for normal frames
        battleWaitTimeRemaining--;
        if (battleWaitTimeRemaining <= 0) {
            currentUser = noone;
            battleState = BattleStateTurnProgression;
        }
    }
};

BattleStateTurnProgression = function() {
    battleText = "";
    turn++;
    if (turn >= array_length(unitTurnOrder)) {
        turn = 0;
        roundCount++;
        firstEnemyThisRound = true;
    }
    battleState = BattleStateSelectAction;
};

BattleStateVictoryCheck = function() {
    RefreshPartyHealthOrder();
    RefreshEnemyHealthOrder();

    if (partyUnitsByHP[0].hp <= 0) {
        room_goto(rm_title_screen);
		audio_stop_all();
    }

    if (enemyUnitsByHP[0].hp <= 0) {
        for (var i=0; i<array_length(global.party); i++)
            global.party[i].hp = partyUnits[i].hp;
			
        audio_stop_all();
        instance_activate_all();
        instance_destroy(creator);
        instance_destroy();
    } else {
        battleState = BattleStateTurnProgression;
    }
};

// Initialize state machine
battleState = BattleStateSelectAction;

// Refresh health at start
RefreshPartyHealthOrder();
RefreshEnemyHealthOrder();
