extends Node

class_name GameManager

signal toggle_game_paused(is_paused: bool)
signal toggle_game_over(is_dead: bool)
signal toggle_game_ended(is_completed: bool)

func _ready():
	MainMenuAudio.stop()
	
func _process(_delta):
	$GUI/TimerLabel.text = "%d:%02d" % [floor($GUI/TimerLabel/Timer.time_left / 60), int($GUI/TimerLabel/Timer.time_left) % 60]
	if get_tree().get_first_node_in_group("player").hp <= 0:
		game_over = true

var game_over: bool = false:
	get:
		return game_over
	set(value):
		game_over = value
		emit_signal("toggle_game_over", game_over)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _input(event: InputEvent):
	if (event.is_action_pressed("escape")):
		game_paused = !game_paused


func _on_timer_timeout():
	emit_signal("toggle_game_ended", true)
