extends Node2D

@export var spawms: Array[SpawnInfo] = []

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0



func _on_timer_timeout():
	time += 1
	var enemySpawns = spawms
	for i in enemySpawns:
		if time >= i.timeStart and time <= i.timeEnd:
			if i.spawnDelayCounter < i.enemySpawnDelay:
				i.spawnDelayCounter += 1
			else:
					i.spawnDelayCounter = 0
					var newEnemy = load(str(i.enemy.resource_path))
					var counter = 0
					while counter < i.enemyNum:
						var enemySpawn = newEnemy.instantiate()
						enemySpawn.global_position = enemyPosition()
						add_child(enemySpawn)
						counter += 1


func enemyPosition ():
	return player.position + Vector2(get_viewport_rect().size.x / 2, 0).rotated(randf_range(0, 2 * PI))

