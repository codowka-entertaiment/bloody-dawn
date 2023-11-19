extends ProgressBar

var current_level = 1

func _on_player_experience_changed(value_signal: Dictionary):
	var current: float = value_signal['current']
	var required: float = value_signal['required']
	value = (current / required) * 100.0


func _on_player_level_changed():
	current_level += 1
	$Level.text = "LV %d" % current_level
