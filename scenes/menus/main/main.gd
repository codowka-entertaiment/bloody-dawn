extends Control

var is_gamepad_connected
var current_button

@onready var start_button = $VBoxContainer/StartButton
@onready var shop_button = $VBoxContainer/ShopButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var exit_button = $VBoxContainer/ExitButton

var preload_scenes = {
	"selector": "res://scenes/menus/levels/levels.tscn",
	"shop": "res://scenes/menus/shop/shop.tscn",
	"credits": "res://scenes/menus/credits/credits.tscn",
	"settings": "res://scenes/menus/settings/settings.tscn",
	"menu": "res://scenes/menus/main/main.tscn",
}

func _ready():
	print("main menu")
	for scene in preload_scenes:
		if GlobalVars.preloaded_scenes[scene] == null:
			ResourceLoader.load_threaded_request(preload_scenes[scene])
	while not are_preloaded():
		for scene in preload_scenes:
			if ResourceLoader.load_threaded_get_status(preload_scenes[scene], []) == ResourceLoader.THREAD_LOAD_LOADED:
				GlobalVars.preloaded_scenes[scene] = ResourceLoader.load_threaded_get(preload_scenes[scene])
	is_gamepad_connected = true if Input.get_connected_joypads().size() == 1 else false
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	start_button.grab_focus()
	current_button = start_button
	var file
	var settings = false
	var save
	if FileAccess.file_exists(GlobalVars.FILE_NAME):
		file = FileAccess.open(GlobalVars.FILE_NAME, FileAccess.READ)
		settings = file.get_as_text()
		settings = JSON.parse_string(settings)
	if FileAccess.file_exists(GlobalVars.SAVE_NAME):
		file = FileAccess.open(GlobalVars.SAVE_NAME, FileAccess.READ)
		save = file.get_as_text()
		save = JSON.parse_string(save)
		GlobalVars.global_gold = save['gold']
	if not MainMenuAudio.playing:
		if settings:
			MainMenuAudio.volume_db = settings['music']
		MainMenuAudio.play()

func are_preloaded() -> bool:
	var result = true
	for scene in GlobalVars.preloaded_scenes:
		if GlobalVars.preloaded_scenes[scene] == null:
			result = false
	return result

func _on_focus_changed(button):
	current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_start_button_pressed():
	while GlobalVars.preloaded_scenes["selector"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes["selector"])

func _on_exit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	while GlobalVars.preloaded_scenes["credits"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes["credits"])

func _on_shop_button_pressed():
	while GlobalVars.preloaded_scenes["shop"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes["shop"])

func _on_settings_button_pressed():
	while GlobalVars.preloaded_scenes["settings"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes["settings"])
