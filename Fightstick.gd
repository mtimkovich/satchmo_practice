extends Node2D

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
	$Toot.pitch_scale = 1
	
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

	# We don't actually have wavs for C3.
	if 'C' in note and pitch == 3:
		pitch += 1
		$Toot.pitch_scale = .5
		
	if '#' in note:
		note = '%s%s#' % [note[0], pitch]
	else:
		note = '%s%s' % [note[0], pitch]

	$Toot.stream = load('res://trumpet/%s.wav' % note)
	$Toot.play()
	# Cut the toots short.
	$Toot/Timer.start()
	
func _on_Timer_timeout():
	$Toot.stop()

func _fingering():
	current = [0, 0]
	var n = 0
	for row in [$Top, $Bottom]:
		for i in range(row.get_child_count()):
			if row.get_child(i).pressed:
				current[n] += pow(2, i)
		n += 1
	play()

func _on_Button_pressed():
	# Buffer inputs for when multiple buttons are pressed.
	if $InputBuffer.is_stopped():
		$InputBuffer.start()