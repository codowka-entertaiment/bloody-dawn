extends Area2D

@export var experience = 1 

var spriteGem = preload("res://assets/loot/Gems.png")

var target = null
var speed = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $soundCollected

func _ready():
	if experience  < 5:
		sprite.set_frame(22)
	elif experience < 25:
		sprite.set_frame(21)
	else:
		sprite.set_frame(20)

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta

func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return experience

func collectFinished():
	queue_free()
