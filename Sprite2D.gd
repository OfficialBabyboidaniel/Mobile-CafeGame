extends CharacterBody2D

const lines: Array[String] = [
	"hey i want a coffe",
	"A cafe latte please",
	"Extra sugar",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.start_dialog(global_position, lines)# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move_local_y(5 * delta);
	pass
	#if at specific point stop moving and open text bubble


