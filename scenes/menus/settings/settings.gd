extends Control

var current_button

@onready var exit_button = $TextureRect/ColorRect/VBoxContainer/HBoxContainer/ExitButton
@onready var save_button = $TextureRect/ColorRect/VBoxContainer/HBoxContainer/SaveButton
@onready var music_slider = $TextureRect/ColorRect/VBoxContainer/MenuBar/VBoxContainer/Music/HSlider
@onready var effects_slider = $TextureRect/ColorRect/VBoxContainer/MenuBar/VBoxContainer/Effects/HSlider
@onready var music_volume = MainMenuAudio.volume_db

func _ready():
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	music_slider.grab_focus()
	current_button = music_slider
	music_slider.value = db_to_linear(MainMenuAudio.volume_db) * 50

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
	var settings = GlobalVars.settings
	settings['music'] = MainMenuAudio.volume_db
	if is_inf(settings['music']):
		settings['music'] = -100
	if is_inf(settings['effects']):
		settings['effects'] = -100
	settings = JSON.stringify(settings)
	var file = FileAccess.open(GlobalVars.FILE_NAME, FileAccess.WRITE)
	file.store_string(settings)
	get_tree().change_scene_to_file("res://scenes/menus/main/main.tscn")

func _on_exit_button_pressed():
	MainMenuAudio.volume_db = music_volume
	get_tree().change_scene_to_file("res://scenes/menus/main/main.tscn")

func _on_h_slider_value_changed(value):
	MainMenuAudio.volume_db = linear_to_db(value / 50)
