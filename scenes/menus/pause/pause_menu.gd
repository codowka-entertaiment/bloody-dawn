extends Control

@export var game_manager: GameManager
var current_button

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_paused)
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

func _on_game_manager_paused(is_paused: bool):
	if (is_paused):
		show()
		current_button = get_node("Panel/VBoxContainer/ContinueButton")
		current_button.grab_focus()
	else:
		hide()

func _on_continue_button_pressed():
	game_manager.game_paused = false

func _on_exit_button_pressed():
	game_manager.game_paused = false
	GlobalVars.global_gold += GlobalVars.level_gold
	GlobalVars.level_gold = 0
	GlobalVars.save_gold()
	MainMenuAudio.play()
	get_tree().change_scene_to_file("res://scenes/menus/main/main.tscn")

func _on_focus_entered():
	pass # Replace with function body.
