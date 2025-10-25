//room saving
function save_room()
{
// get individual count of each saveable object	
var _coinNum = instance_number(obj_coin)
var _speakblockNum = instance_number(obj_speakblock)
var _cutsceneNum = instance_number(obj_cutscene)

var _roomStruct =
	{
		coinNum : _coinNum,
		coinData : array_create(_coinNum),
		
		speakblockNum : _speakblockNum,
		speakblockData : array_create(_speakblockNum),
		
		cutsceneNum : _cutsceneNum,
		cutsceneData : array_create(_cutsceneNum),
		
	}
	
	//get the data from the different saveable objects
		
		//coins
		for (var i = 0; i < _coinNum; i++)
		{
			var _inst = instance_find(obj_coin, i);
			
			_roomStruct.coinData[i] =
			{
				x: _inst.x,	
				y: _inst.y,
			}
		}
		
		//speakblocks
			for (var i = 0; i < _speakblockNum; i++)
		{
			var _inst = instance_find(obj_speakblock, i);
			
			_roomStruct.speakblockData[i] =
			{
				text_id: _inst.text_id,
				x: _inst.x,	
				y: _inst.y,
			}
		}
		
		
		//cutscenes
				//speakblocks
			for (var i = 0; i < _cutsceneNum; i++)
		{
			var _inst = instance_find(obj_cutscene, i);
			
			_roomStruct.cutsceneData[i] =
			{
				text_id: _inst.text_id,
				x: _inst.x,	
				y: _inst.y,
				inst_width: _inst.image_xscale,
				inst_height: _inst.image_yscale,
			}
		}
		
		
		
	//store the room specific struct in global.leveldata's variable for that level
	if room == save_test_LV1 {global.levelData.level_1 = _roomStruct;};
	if room == save_test_LV2{global.levelData.level_2 = _roomStruct;};
}

function load_room()
{
	var _roomStruct =0;
	
	//get the correct struct for the room you're in
	if room == save_test_LV1 {_roomStruct = global.levelData.level_1;};
	if room == save_test_LV2 {_roomStruct = global.levelData.level_2;};
	
	//exit if _roomStruct isnt a struct
	if !is_struct(_roomStruct) {exit;};
	
	//COINS: get rid of deafult coins and make new coins based on saved data
	if (instance_exists(obj_coin)) {instance_destroy(obj_coin);};
	for (var i = 0; i < _roomStruct.coinNum; i++)
	{
		instance_create_layer(_roomStruct.coinData[i].x,_roomStruct.coinData[i].y, layer, obj_coin)	
	}
	
	//SPEAKBLOCKS: get rid of deafult speakblock and make new speakblock based on saved data
	if (instance_exists(obj_speakblock)) {instance_destroy(obj_speakblock);};
	for (var i = 0; i < _roomStruct.speakblockNum; i++)
	{
		with (instance_create_layer(_roomStruct.speakblockData[i].x,_roomStruct.speakblockData[i].y, layer, obj_speakblock))	
		{
				text_id = _roomStruct.speakblockData[i].text_id;
		}
	}
	
		//SPEAKBLOCKS: get rid of deafult speakblock and make new speakblock based on saved data
	if (instance_exists(obj_cutscene)) {instance_destroy(obj_cutscene);};
	for (var i = 0; i < _roomStruct.cutsceneNum; i++)
	{
		with (instance_create_layer(_roomStruct.cutsceneData[i].x,_roomStruct.cutsceneData[i].y, layer, obj_cutscene))	
		{
				text_id = _roomStruct.cutsceneData[i].text_id;
				image_xscale = _roomStruct.cutsceneData[i].inst_width
				image_yscale = _roomStruct.cutsceneData[i].inst_height 
		}
	}
}

//overall saving
function save_game(_fileNum = 0)
{
	var _saveArray = array_create(0)
	
	//save room you are in
	save_room();	
	
	//set and save stat related stuff
	global.statData.save_x = obj_player.x;
	global.statData.save_y = obj_player.y;
	global.statData.save_rm = room_get_name(room);
	
	global.statData.coinCount = global.coinCount;
	
	global.statData.party = global.party;
	
	array_push(_saveArray, global.statData)
	
	//save all room data
	array_push(_saveArray, global.levelData)
	
	//actual saving dont ask me how this works
	var _filename = "savedata" + string(_fileNum) + ".sav";
	var _json = json_stringify(_saveArray);
	var _buffer = buffer_create( string_byte_length(_json) + 1, buffer_fixed, 1 );
	buffer_write(_buffer, buffer_string, _json);
	
	buffer_save(_buffer, _filename);
	
	buffer_delete(_buffer);
	

	
}

function load_game(_fileNum = 0)
{
	//loading our saved data
		var _filename = "savedata" + string(_fileNum) + ".sav";
		if !file_exists(_filename) exit;
		
		//load the buffer, get the json, and delete buffer again to save memory
		var _buffer = buffer_load(_filename);
		var _json = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		//"unstringify" and get the data array
		var _loadArray = json_parse(_json);
		
	//set the data in game to match loaded data
		global.statData = array_get(_loadArray, 0);
		global.levelData = array_get(_loadArray, 1);
		
		global.coinCount = global.statData.coinCount;
		global.party = global.statData.party;
		
	//use our new data to get back to where we were in the game
		//go to the correct room
		var _loadRoom = asset_get_index(global.statData.save_rm);
		room_goto(_loadRoom);
				//make sure object saveload doesnt save the area we're exiting from
				obj_saveLoad.skipRoomSave = true;
		
		//create the player object
		if instance_exists(obj_player) {instance_destroy(obj_player);};
		instance_create_depth(global.statData.save_x,global.statData.save_y,layer, obj_player)
		
		//manually load room
		load_room();
		
		
		
	
}
