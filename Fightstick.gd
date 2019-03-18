extends Node2D

var previous = [0, 0]
var current = [0, 0]
var top_notes = {
	1: 'F',
	2: 'F#',
	3: 'E',
	4: 'C',
	5: 'D',
	6: 'D#',
	7: 'C#'
}
var bottom_notes = {
	1: 'A#',
	2: 'B',
	3: 'A',
	4: 'G',
	6: 'G#'
}
	
func play():
	var pitch = 4
	var note
	
	if current[0] != 0:
		note = top_notes.get(int(current[0]))
	elif current[1] != 0:
		note = bottom_notes.get(int(current[1]))
		
	if note == null:
		return
		
	if $Stick/Up.pressed:
		pitch += 1
	if $Stick/Down.pressed:
		pitch -= 1
		
	if '#' in note:
		note = '%s%s#' % [note[0], pitch]
	else:
		note = '%s%s' % [note[0], pitch]
	
	$Toot.stream = load('res://trumpet/%s.wav' % note)
	$Toot.play()
	$Toot/Timer.start()
	
func _on_Timer_timeout():
	$Toot.stop()

func _is_pressed():
	return current != [0, 0]

func _get_fingering():
	var current = [0, 0]
	var n = 0
	for row in [$Top, $Bottom]:
		for i in range(row.get_child_count()):
			if row.get_child(i).pressed:
				current[n] += pow(2, i)
		n += 1
	return current
	
func _process(delta):
	if Input.is_action_just_pressed('leftclick'):
		current = _get_fingering()
		if current != previous and _is_pressed():
			play()
		previous = current
	elif Input.is_action_just_released('leftclick'):
		previous = [0, 0]