extends Control

var is_gamepad_connected
var current_button

@onready var return_button = $ReturnButton
@onready var lvl_button_lst: Array = [
	$MenuBar/Forest,
	$MenuBar/Rooocks
]

func _ready():
	is_gamepad_connected = true if Input.get_connected_joypads().size() == 1 else false
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	lvl_button_lst[0].grab_focus()
	current_button = lvl_button_lst[0]
	
func _on_focus_changed(button):
	current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_forest_pressed():
	MainMenuAudio.stop()
	GlobalVars.current_level = "res://scenes/level_1_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/load_screen.tscn")

func _on_rooocks_pressed():
	pass # Replace with function body.

func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
