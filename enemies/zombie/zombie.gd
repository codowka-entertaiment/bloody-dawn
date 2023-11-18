extends CharacterBody2D


var speed = 50
@export var hp = 5
@export var experience = 1
var player_pos
var target_pos
@onready var player = get_parent().get_parent().get_node("PlayerNode/Player")
@onready var lootBase = get_tree().get_first_node_in_group("loot")

var expGem = preload("res://scenes/loot/experience_gem.tscn")

func _physics_process(_delta):
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
		var gem = expGem.instantiate()
		gem.global_position = position
		gem.experience = experience
		lootBase.call_deferred("add_child", gem)
		queue_free()#replece with death animation
