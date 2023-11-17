extends CharacterBody2D


var speed = 50
var hp = 5
var player_pos
var target_pos
@onready var player = get_parent().get_parent().get_node("PlayerNode/Player")

func _physics_process(delta):
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	velocity = target_pos * speed
	if (velocity.x < 0):
		$ZombieSprite2D.flip_h = false
	else:
		$ZombieSprite2D.flip_h = true
	move_and_slide()

func _on_hurt_box_hurt(damage):
	hp -= damage
	set_modulate(Color(1, 0, 0, 1))
	await get_tree().create_timer(0.2).timeout
	set_modulate(Color(1, 1, 1, 1))
	if hp <= 0:
		queue_free()#replece with death animation
