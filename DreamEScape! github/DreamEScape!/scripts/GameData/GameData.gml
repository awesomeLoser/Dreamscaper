//Action Library (the stuff people can do in battle)

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
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : sAttackBonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
		show_debug_message("Attack happened");
		 var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
		 BattleChangeHP(_targets[0], -_damage, 0);
		  show_debug_message(_user.name + " dealt " + string(_damage) + " damage to " + _targets[0].name);
		 show_debug_message("Targets length: " + string(array_length(_targets)));


if (array_length(_targets) > 0) {
    show_debug_message("First target hp: " + string(_targets[0].hp));
}
else {
    show_debug_message("No valid targets!");
}

		}
	},
	ice:
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired : true,
		targetEnemyByDeafult : true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite : sAttackIce,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(15,20);
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
			//BattleChangeMP(_user, -mpCost)
		}
	}


}





//party data 
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

 global.enemies =
{
    tree_test: 
    {
        enemyKey: "tree_test",   // Added this key
        name: "Tree_test",    
        hp: 18,
        hpMax: 18,
        mp: 0,
        mpMax: 0,
        strength: 5,
        sprites: {idle: test_tree_idle, attack: test_tree_attack},
        actions: [global.actionLibrary.attack],
        xpValue: 15,
        AIscript: function()
        {
            // Attack random party member
            var _action = actions[0];
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];
            return [_action, _target];
        }
    },
    
    bug_test: 
    {
        enemyKey: "bug_test",   // Added this key (consistent naming)
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
            // Attack random party member
            var _action = actions[0];
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];
            return [_action, _target];
        }
    }
};
