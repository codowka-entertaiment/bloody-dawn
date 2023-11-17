extends Node2D

var mob_preload = preload("res://enemies/zombie/zombie.tscn")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var texture: ParallaxBackground = get_node("ParallaxBackground")
var proj_preload = preload("res://player/weapons/mrs/magician_red_staff.tscn") # todo: change this

var last_position


func _ready():
	pass # Replace with function body.


func _process(_delta):
	var player = get_node("PlayerNode/Player")
	if last_position == null:
		last_position = player.position
	if abs(last_position.x - player.position.x) >= 1 || abs(last_position.y - player.position.y) >= 1:
		camera.position.x = player.position.x
		camera.position.y = player.position.y
		last_position = player.position

func spawnProj (): #remove this
	var proj = proj_preload.instantiate()
	proj.position = get_node("PlayerNode/Player").position
	add_child(proj)

func _on_test_attack_timer_timeout():#remove timer and add something better
	spawnProj()
