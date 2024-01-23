extends MarginContainer

# Called when the node enters the scene tree for the first time.
@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH: int = 256

var text = ""
var letter_index: int = 0

#displaying text variables
@export var letter_time = 0.05
@export var space_time = 0.08
@export var punctuation_time = 0.3

signal finished_displaying()

#code has to be reviewed, wtf is going on
func display_text(text_to_display: String) -> void:
	text = text_to_display
	label.text = text_to_display
	await  resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #wait for x resize
		await resized #wait for y resize
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	label.text = ""
	_display_letter()

func _display_letter() -> void:
	if letter_index < text.length():
		label.text += text[letter_index]
		letter_index += 1
	
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void :
	_display_letter() # Replace with function body.
