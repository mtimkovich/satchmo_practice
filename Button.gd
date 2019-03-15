extends Node2D

onready var released_img = preload('res://button_up.png')
onready var pressed_img = preload('res://button_down.png')
var pressed = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action('leftclick'):
		if event.is_pressed():
			$Sprite.texture = pressed_img
			pressed = true
		else:
			$Sprite.texture = released_img
			pressed = false