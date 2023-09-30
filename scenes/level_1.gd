extends Node2D

var mob_preload = preload("res://Enemy/Zombie.tscn")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var texture: ParallaxBackground = get_node("ParallaxBackground")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_node("PlayerNode/Player")
	camera.position.x = player.position.x
	camera.position.y = player.position.y
	pass

func EnemySpawn ():
	var enemy = mob_preload.instantiate()
	enemy.position = get_node("PlayerNode/Player").position + Vector2(get_viewport_rect().size.x / 2, 0).rotated(randf_range(0, 2 * PI))
	$Mobs.add_child(enemy)


func _on_spawner_timeout():
	EnemySpawn()
	pass # Replace with function body.
