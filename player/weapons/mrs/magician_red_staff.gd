extends Node2D

var speed = 100
var damage = 5
var distance = 500

var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
var close_enemy

func _ready():
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	if all_enemy:
		close_enemy = all_enemy[0]
	for enemy in all_enemy:
		var gun2enemy_distance = player.position.distance_to(enemy.position)
		if gun2enemy_distance < distance and close_enemy and gun2enemy_distance < player.position.distance_to(close_enemy.position):
			close_enemy = enemy
	if close_enemy == null:
		queue_free()
	else:
		angle = player.position.direction_to(close_enemy.position)
		rotation = angle.angle() + deg_to_rad(133)
		

func _process(delta):
	position += angle * speed * delta


func _on_timer_timeout():
	queue_free()