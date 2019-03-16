extends Node2D

var previous = 0

func _get_fingering(row):
	var fingering = 0
	for i in range(row.get_child_count()-1, -1, -1):
		if row.get_child(i).pressed:
			fingering += pow(2, i)
	return fingering
	
func _process(delta):
	var top = _get_fingering($Top)
	var bottom = _get_fingering($Bottom)
	if top != previous:
		if top != 0:
			print(top)
		previous = top