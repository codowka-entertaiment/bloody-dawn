extends Control

var current_button

func _ready():
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	$ReturnButton.grab_focus()
	current_button = $ReturnButton
	
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
