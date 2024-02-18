extends Node2D

var filename
var parent
var pos_x
var pos_y

var has_made_coffe: bool = false

#HUD values
var money: int
var gems: int
var level: int
var expererience: int


func _process(_delta):
	print("save file is processing")
	if GlobalSingleton.has_initialized and !SaveSystem.is_processing() and !GlobalSingleton.save_file_loaded:
		print("setting save file var")
		GlobalSingleton.save_file_loaded = true  
		GlobalSingleton.money = money
		GlobalSingleton.gems = gems
		GlobalSingleton.level = level
		GlobalSingleton.expererience = expererience
		print(money, gems, level, expererience)
		set_process(false)
		return
	if	GlobalSingleton.save_file_loaded: 
		set_process(false)


func save():
	print("saving global variables")
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": "/root/StartScene",
		"pos_x": self.position.x,
		"pos_y": self.position.y,
		"money": GlobalSingleton.money,
		"gems": GlobalSingleton.gems,
		"level": GlobalSingleton.level,
		"expererience": GlobalSingleton.expererience
	}
	return save_dict
