extends Node2D

onready var released_img = preload('res://button_up.png')
onready var pressed_img = preload('res://button_down.png')
export (String) var key
var pressed = false
var scancode

signal pressed

func press(is_pressed):
	if pressed == is_pressed:
		return

	if is_pressed:
		$Sprite.texture = pressed_img
		pressed = true
		emit_signal('pressed')
	else:
		$Sprite.texture = released_img
		pressed = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		press(event.is_pressed())
		
func _input(event):
	if event is InputEventKey and event.scancode == scancode:
		press(event.is_pressed())
		
func _ready():
	if key != null:
		scancode = OS.find_scancode_from_string(key)
	connect('pressed', get_node('/root/Fightstick'), '_on_Button_pressed')
