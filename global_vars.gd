extends Node

var current_level = null
var volume = 50
var vsync = true
var player_hp = 100
const FILE_NAME = "res://settings.dat"

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

var preview_textures = [
	load('res://assets/floor/grass_3.png'),
	load('res://assets/floor/rock.png'),
	load('res://assets/floor/fabric.png')
]
