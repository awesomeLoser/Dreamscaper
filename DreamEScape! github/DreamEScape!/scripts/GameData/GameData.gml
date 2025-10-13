// -----------------------------
// Action Library
// -----------------------------
enum MODE 
{
    NEVER = 0,
    ALWAYS = 1,
    VARIES = 2
}

global.actionLibrary =
{
    attack:
    {
        name : "Attack",
        description : "{0} Attacks!",
        subMenu : -1,
        targetRequired : true,
        targetEnemyByDeafult : true,
        targetAll : MODE.ALWAYS,
        userAnimation : "attack",
        effectSprite : sAttackBonk,
        effectOnTarget : MODE.ALWAYS,
        func : function(_user, _targets)
        {
            var _damage = ceil(_user.strength + random_range(-_user.strength*0.25, _user.strength*0.25));
            BattleChangeHP(_targets[0], -_damage, 0);
        }
    },
    ice:
    {
        name : "Ice",
        description : "{0} casts Ice!",
        subMenu : "Magic",
        mpCost : 4,
        targetRequired : true,
        targetEnemyByDeafult : true,
        targetAll: MODE.ALWAYS,
        userAnimation : "cast",
        effectSprite : sAttackIce,
        effectOnTarget: MODE.ALWAYS,
        func : function(_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
                var _damage = irandom_range(15,20);
                if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
                BattleChangeHP(_targets[i], -_damage);
            }
        }
    }
}

// -----------------------------
// Party Data
// -----------------------------
global.party =
[
    {
        name: "test_char",
        hp: 89,
        hpMax: 89,
        mp: 10,
        mpMax: 15,
        strength: 16,
        sprites: {idle: test_battle_idle, attack: test_battle_attack, defend: test_battle_defend, down: test_battle_down, cast: test_battle_cast},
        actions: [global.actionLibrary.attack, global.actionLibrary.ice]
    }
];

// -----------------------------
// Enemy Data
// -----------------------------
global.enemies =
{
    tree_test:
    {
        enemyKey: "tree_test",
        name: "Tree_test",
        hp: 20,
        hpMax: 20,
        mp: 0,
        mpMax: 0,
        strength: 5,
        sprites: {idle: test_tree_idle, attack: test_tree_attack},
        actions: [global.actionLibrary.attack],
        xpValue: 15,
        AIscript: function()
        {
            var _action = actions[0];
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit,_index){ return _unit.hp > 0; });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
            return [_action,_target];
        }
    },
    
    bug_test:
    {
        enemyKey: "bug_test",
        name: "BedBug_test",
        hp: 20,
        hpMax: 15,
        mp: 0,
        mpMax: 0,
        strength: 4,
        sprites: {idle: test_bug_idle, attack: test_bug_attack},
        actions: [global.actionLibrary.attack],
        xpValue: 18,
        AIscript: function()
        {
            var _action = actions[0];
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit,_index){ return _unit.hp > 0; });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
            return [_action,_target];
        }
    }
};
