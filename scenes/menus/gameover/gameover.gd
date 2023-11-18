extends Control

var current_button
var is_opened = false
@export var game_manager: GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_over", _on_game_manager_dead)
	get_viewport().connect("gui_focus_changed", _on_focus_changed)

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _process(_delta):
	pass

func _on_focus_changed(button):
	if button != null:
		current_button = button

func _on_game_manager_dead(is_dead: bool):
	if get_tree().paused == false:
		get_tree().paused = true
	if (is_dead):
		show()
		if not is_opened:
			current_button = get_node("Panel/VBoxContainer/TryAgainButton")
			current_button.grab_focus()
			is_opened = true
	else:
		hide()

func _on_try_again_button_pressed():
	MainMenuAudio.stop()
	get_tree().paused = false
	GlobalVars.global_gold += GlobalVars.level_gold
	GlobalVars.level_gold = 0
	GlobalVars.save_gold()
	GlobalVars.current_level = "res://scenes/level1/level1_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/loadscreen/load.tscn")

func _on_return_button_pressed():
	MainMenuAudio.play()
	get_tree().paused = false
	GlobalVars.global_gold += GlobalVars.level_gold
	GlobalVars.level_gold = 0
	GlobalVars.save_gold()
	while GlobalVars.preloaded_scenes["menu"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes['menu'])
