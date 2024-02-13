extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("loading game")
	load_game()


func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	print(save_game)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	if save_nodes.is_empty():
		print("save_nodes is empty")
		return
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		print("saving item")
		var node_data = node.call("save")
		print("writing data to json string")
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		print("Json Stringify" + json_string)

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)


# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("Error! We don't have a save to load.")
		return  # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		print(i, "i in save nodes")
		i.queue_free()


func _process(_delta):
	print("save system is processing")
	var all_freed = true
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		print(i, "i in save nodes")
		if !i.is_queued_for_deletion():
			all_freed = false
			break
	if all_freed:
		# All nodes have been queued for deletion, proceed with the rest of the code
		load_and_process_save_data()
		set_process(false)
		

func load_and_process_save_data():
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print(
				"JSON Parse Error: ",
				json.get_error_message(),
				" in ",
				json_string,
				" at line ",
				json.get_error_line()
			)
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_tree().root.add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			print("i: ", i, " node data : ", node_data[i])
			new_object.set(i, node_data[i])
