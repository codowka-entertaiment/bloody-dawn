extends Node2D

var mob_preload = preload("res://Enemy/Zombie.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func EnemySpawn ():
	var enemy = mob_preload.instantiate()
	enemy.position = Vector2(352, 120)
	$Mobs.add_child(enemy)


func _on_spawner_timeout():
	EnemySpawn()
	pass # Replace with function body.
