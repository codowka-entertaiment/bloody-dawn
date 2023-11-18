extends Control

@export var game_manager: GameManager
var current_button
var is_opened = false
var quotes: Array[String] = [
	'In the realm of champions, you stand alone. Congratulations, mighty warrior!',
	'A symphony of victory plays in your honor! Congratulations on your triumphant conquest!',
	'Behold, a legend in the making! Congratulations on your epic journey!',
	'The path to glory is paved with your triumphs. Congratulations, valiant hero!',
	'The cosmos itself applauds your excellence. Congratulations, celestial champion!',
	'The cheers of a thousand warriors resound in your honor. Congratulations on your epic triumph!',
	'The heavens themselves open to celebrate your celestial victory. Congratulations, divine champion!'
]

func _ready():
	hide()
	$Panel/VBoxContainer/Label2.text = quotes.pick_random()
	game_manager.connect("toggle_game_ended", _on_game_manager_ended)
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

func _on_game_manager_ended(is_completed: bool):
	if get_tree().paused == false:
		get_tree().paused = true
	if (is_completed):
		show()
		if not is_opened:
			current_button = get_node("Panel/VBoxContainer/ReturnButton")
			current_button.grab_focus()
			is_opened = true
	else:
		hide()

func _on_focus_changed(button):
	if button != null:
		current_button = button

func _on_return_button_pressed():
	MainMenuAudio.play()
	get_tree().paused = false
	GlobalVars.global_gold += GlobalVars.level_gold
	GlobalVars.level_gold = 0
	GlobalVars.save_gold()
	while GlobalVars.preloaded_scenes["menu"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes['menu'])

