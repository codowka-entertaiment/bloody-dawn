extends Control

var current_button

@onready var exit_button = $TextureRect/ColorRect/VBoxContainer/HBoxContainer/ExitButton
@onready var save_button = $TextureRect/ColorRect/VBoxContainer/HBoxContainer/SaveButton
@onready var music_slider = $TextureRect/ColorRect/VBoxContainer/MenuBar/VBoxContainer/Music/HSlider
@onready var effects_slider = $TextureRect/ColorRect/VBoxContainer/MenuBar/VBoxContainer/Effects/HSlider

func _ready():
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	music_slider.grab_focus()
	current_button = music_slider

func _on_focus_changed(button):
	current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_save_button_pressed():
	# Logic for saving settings
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
