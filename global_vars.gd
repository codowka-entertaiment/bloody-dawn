extends Node

var current_level = null
var volume = 50
var vsync = true
var player_hp = 100
const FILE_NAME = "res://settings.dat"
const SAVE_NAME = "res://save.dat"

var global_gold = 0
var level_gold = 0

var preloaded_scenes = {
	"selector": null,
	"settings": null,
	"shop": null,
	"credits": null,
	"menu": null,
}

var settings: Dictionary = {
	"music": -20,
	"effects": -20
}

var save: Dictionary = {
	"passed_levels": [],
	"unlocked_weapons": [],
	"gold": 0
}

var preview_textures = [
	load('res://assets/floor/grass_3.png'),
	load('res://assets/floor/rock.png'),
	load('res://assets/floor/fabric.png')
]

func save_gold():
	save['gold'] = global_gold
	var save_json = JSON.stringify(save)
	var file = FileAccess.open(GlobalVars.SAVE_NAME, FileAccess.WRITE)
	file.store_string(save_json)
