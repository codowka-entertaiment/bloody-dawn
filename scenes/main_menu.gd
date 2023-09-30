extends Control

var is_gamepad_connected
var current_button: TextureButton

@onready var start_button = $StartButton
@onready var shop_button = $ShopButton
@onready var settings_button = $SettingsButton
@onready var credits_button = $CreditsButton
@onready var exit_button = $ExitButton

func _ready():
	is_gamepad_connected = true if Input.get_connected_joypads().size() == 1 else false
	start_button.grab_focus()
	current_button = start_button
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	
func _on_focus_changed(button):
	if button != null:
		current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_shop_button_pressed():
	pass # Replace with function body.


func _on_settings_button_pressed():
	pass # Replace with function body.
