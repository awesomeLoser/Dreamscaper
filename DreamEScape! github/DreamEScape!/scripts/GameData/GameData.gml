//Action Library (the stuff people can do in battle)
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
		 var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
		 with (_targets[0]) hp = max(0, hp - _damage);
		}
	}


}

enum MODE 
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
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
	 sprites: {idle: test_battle_idle, attack: test_battle_attack, defend: test_battle_defend, down: test_battle_down},
	 actions: [],
	 

	}
	,
	{
	 name: "test_char_2",
	 hp: 89,
	 hpMax: 89,
	 mp: 10,
	 mpMax: 15,
	 strength: 16,
	 sprites: {idle: test_battle_idle, attack: test_battle_attack, defend: test_battle_defend, down: test_battle_down},
	 actions: []
	}
	

];
 //enemy data
 global.enemies =
	 {

		 
		  tree_test: 
		 {
		  name: "Tree_test",	
		  hp: 30,
		  hpMax: 30,
		  mp: 0,
		  mpMax: 0,
		  strength: 5,
		  sprites: {idle: test_tree_idle, attack: test_tree_attack},
		  actions: [],
		  xpValue: 15,
		  AIScript: function()
		  {
			  //enemy turn ai goes here
		  }
		 },
		 
		 bug_test: 
		 {
		  name: "BedBug_test",	
		  hp: 15,
		  hpMax: 15,
		  mp: 0,
		  mpMax: 0,
		  strength: 4,
		  sprites: {idle: test_bug_idle, attack: test_bug_attack},
		  actions: [],
		  xpValue: 18,
		  AIScript: function()
		  {
			  //enemy turn ai goes here
		  }
		  
		  
		 }
		 
		 
	 }
 ;