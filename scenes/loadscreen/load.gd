extends Control

@onready var loading = $ColorRect/ColorRect/Loading
@onready var scene = GlobalVars.current_level

func _ready():
	ResourceLoader.load_threaded_request(scene)
	MainMenuAudio.stop()
	loading.play()

func _process(_delta):
	if ResourceLoader.load_threaded_get_status(scene, []) == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
