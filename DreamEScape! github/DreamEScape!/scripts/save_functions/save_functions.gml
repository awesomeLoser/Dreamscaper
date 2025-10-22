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


