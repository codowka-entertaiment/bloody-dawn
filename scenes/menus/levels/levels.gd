extends Control

var is_gamepad_connected
var current_button

@onready var return_button = $MenuBar/ReturnButton
@onready var lvl_button_lst: Array = [
	$MenuBar/VBoxContainer/Level1Button,
	$MenuBar/VBoxContainer/Level2Button,
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

func _on_return_button_pressed():
	while GlobalVars.preloaded_scenes["menu"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes['menu'])

func _on_level_1_button_pressed():
	MainMenuAudio.stop()
	GlobalVars.current_level = "res://scenes/level1/level1_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/loadscreen/load.tscn")


func _on_level_2_button_pressed():
	pass # Replace with function body.
