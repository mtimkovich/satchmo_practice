extends Node2D

onready var released_img = preload('res://button_up.png')
onready var pressed_img = preload('res://button_down.png')
export (String) var key
var pressed = false

func scancode():
	if key == null:
		return
	return OS.find_scancode_from_string(key)

func press(is_pressed):
	if is_pressed:
		$Sprite.texture = pressed_img
		pressed = true
	else:
		$Sprite.texture = released_img
		pressed = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		press(event.is_pressed())
		
func _input(event):
	if event is InputEventKey and event.scancode == scancode():
		press(event.is_pressed())
		
func _ready():
	var event = InputEventKey.new()
	event.scancode = scancode()
	InputMap.add_action('fightstick')
	InputMap.action_add_event('fightstick', event)
