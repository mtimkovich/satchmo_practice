extends Node2D

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		$Timer.start()
		
func _input(event):
	if event is InputEventKey and event.scancode == KEY_ENTER:
		$Timer.start()
		
func _process(delta):
	if $Timer.is_stopped():
		$Label.visible = false
		return
	
	$Label.visible = true
	$Label.text = '%.3f' % $Timer.time_left
