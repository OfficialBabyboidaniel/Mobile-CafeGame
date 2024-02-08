extends Node2D

var filename
var parent
var pos_x
var pos_y

var AI_transform_pos_x = 0
var AI_transform_pos_y = 0
var AI_transform_scale_x: float = 0
var AI_transform_scale_y: float = 0

var has_made_coffe: bool = false

#HUD values
var money = 0
var gems = 0
var level = 1
var expererience = 0


func _ready():
	GlobalSingleton.money = money
	GlobalSingleton.expererience = expererience
	GlobalSingleton.level = level
	GlobalSingleton.gems = gems
	GlobalSingleton.AI_transform_pos_x = AI_transform_pos_x
	GlobalSingleton.AI_transform_pos_y = AI_transform_pos_y
	GlobalSingleton.AI_transform_scale_x = AI_transform_scale_x
	GlobalSingleton.AI_transform_scale_y = AI_transform_scale_y


func save():
	print("saving global variables")
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": self.position.x,
		"pos_y": self.position.y,
		"money": GlobalSingleton.money,
		"gems": GlobalSingleton.gems,
		"level": GlobalSingleton.level,
		"expererience": GlobalSingleton.expererience,
		"AI_transform_pos_x": GlobalSingleton.AI_transform_pos_x,
		"AI_transform_pos_y": GlobalSingleton.AI_transform_pos_y,
		"AI_transform_scale_x": GlobalSingleton.AI_transform_scale_x,
		"AI_transform_scale_y": GlobalSingleton.AI_transform_scale_y
	}
	return save_dict
