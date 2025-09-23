// -----------------------------
// Battle Setup
// -----------------------------
instance_deactivate_all(true);

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

currentUser = noone;
currentAction = -1;
currentTargets = noone;

// -----------------------------
// Create Enemies (array-safe)
// -----------------------------
for (var i = 0; i < array_length(enemies); i++)
{
    var enemyData = enemies[i]; // already a struct
    var inst = instance_create_depth(
        x + 250 + (i * 10),
        y + 68 + (i * 20),
        depth - 10,
        oBattleUnitEnemy,
        enemyData
    );
    enemyUnits[i] = inst;
    array_push(units, inst);
}

// -----------------------------
// Create Party Units
// -----------------------------
for (var i = 0; i < array_length(global.party); i++)
{
    var inst = instance_create_depth(
        x + 70 + (i * 10),
        y + 68 + (i * 15),
        depth - 10,
        oBattleUnitPC,
        global.party[i]
    );
    partyUnits[i] = inst;
    array_push(units, inst);
}

// -----------------------------
// Shuffle Turn Order
// -----------------------------
unitTurnOrder = array_shuffle(units);

// -----------------------------
// Render Order
// -----------------------------
RefreshRenderOrder = function()
{
    unitRenderOrder = [];
    array_copy(unitRenderOrder, 0, units, 0, array_length(units));
    array_sort(unitRenderOrder, function(_1, _2)
    {
        return _1.y - _2.y;
    });
}
RefreshRenderOrder();

// -----------------------------
// Battle States
// -----------------------------

// Select current unit and begin action
function BattleStateSelectAction()
{
    var _unit = unitTurnOrder[turn];

    if (!instance_exists(_unit) || (_unit.hp <= 0))
    {
        battleState = BattleStateVictoryCheck;
        return;
    }

    // every unit attacks itself if below code uncommented
    //BeginAction(_unit.id, global.actionLibrary.attack, _unit.id);
	
	//if unit is player controlled
	if (_unit.object_index == oBattleUnitPC)
	{
		 //attack random enemy (will be changed or removed when options can be selected)
			  var _action = global.actionLibrary.attack;
			  var _possibleTargets = array_filter(oBattle.enemyUnits, function(_unit, _index) 
			  {
				  return (_unit.hp > 0);
			  });
			  var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)]
			  BeginAction(_unit.id, _action, _target);
	}
	else
	{
		//if unit is ai controlled	
		var _enemyAction = _unit.AIscript();
		if (_enemyAction != 1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1])
	}
}

// Begin the action (animation + target setup)
function BeginAction(_user, _action, _targets)
{
    currentUser = _user;
    currentAction = _action;
    currentTargets = _targets;

    if (!is_array(currentTargets)) currentTargets = [currentTargets];

    battleWaitTimeRemaining = battleWaitTimeFrames;

    with (_user)
    {
        acting = true;

        if (!is_undefined(_action[$ "userAnimation"]) && !is_undefined(_user.sprites[$ _action.userAnimation]))
        {
            sprite_index = sprites[$ _action.userAnimation];
            image_index = 0;
        }
    }

    battleState = BattleStatePerformAction;
}

// Perform action: animation, effect, damage, then advance turn
function BattleStatePerformAction()
{
    if (!instance_exists(currentUser)) return;

    if (currentUser.acting)
    {
        // Wait until animation ends
        if (currentUser.image_index >= currentUser.image_number - 1)
        {
            with (currentUser)
            {
                sprite_index = sprites.idle;
                image_index = 0;
                acting = false;
            }

            // Spawn effect if defined
            if (variable_struct_exists(currentAction, "effectSprite"))
            {
                for (var i = 0; i < array_length(currentTargets); i++)
                {
                    instance_create_depth(
                        currentTargets[i].x,
                        currentTargets[i].y,
                        currentTargets[i].depth - 1,
                        oBattleEffect,
                        {sprite_index: currentAction.effectSprite}
                    );
                }
            }

            // Apply the action effect
            currentAction.func(currentUser, currentTargets);

            // Reset currentUser **after action fully completes**
            currentUser = noone;

            // Progress to next turn
            battleState = BattleStateTurnProgression;
        }
    }
    else
    {
        // Countdown wait time if no animation is running
        if (!instance_exists(oBattleEffect))
        {
            battleWaitTimeRemaining--;
            if (battleWaitTimeRemaining <= 0)
            {
                currentUser = noone;
                battleState = BattleStateTurnProgression;
            }
        }
    }
}

// Victory check (unchanged)
function BattleStateVictoryCheck()
{
    battleState = BattleStateTurnProgression;
}

// Turn progression (fixed)
function BattleStateTurnProgression()
{
    turn++;

    // Loop back to first unit if needed
    if (turn >= array_length(unitTurnOrder))
    {
        turn = 0;
        roundCount++;
    }

    // Pick the next unit to act
    battleState = BattleStateSelectAction;
}

// -----------------------------
// Start the battle
// -----------------------------
battleState = BattleStateSelectAction;
