extends CharacterBody2D


var speed = 100
var player_pos
var target_pos
@onready var player = get_parent().get_parent().get_node("PlayerNode/Player")

func _physics_process(delta):
	
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	velocity = target_pos * speed
	if (velocity.x < 0 ):
		$ZombieSprite2D.flip_h = false
	else:
		$ZombieSprite2D.flip_h = true
	move_and_slide()
