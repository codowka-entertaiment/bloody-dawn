extends Control

@onready var modes_option_button = $TabContainer/Video/HBoxContainer/DisplayModes

const SAVE_FILE = "res://savefile.save"
var game_data = {}

var modes: Array = ["Fullscreen", "Windowed"]

func _ready():
	add_resolutions()
	
func add_resolutions():
	for mode in modes:
		modes_option_button.add_item(mode)

func _on_option_button_item_selected(index):
	pass
