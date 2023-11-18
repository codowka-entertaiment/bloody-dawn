extends CharacterBody2D

var move_speed = 120.0
var hp = 20.0
var max_hp = hp
const max_speed = 200
const accel = 1500
const friction = 10000

var input = Vector2.ZERO

func _physics_process(delta):
	movement(delta)

func movement(delta):
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	
	
	if Input.is_action_pressed("up"):
		pass
		
	if Input.is_action_pressed("down"):
		pass
		
	if Input.is_action_pressed("left"):
		$PlayerAnimation2D.flip_h = true 
		pass
		
	if Input.is_action_pressed("right"):
		$PlayerAnimation2D.flip_h = false
		pass
		
	if velocity != Vector2.ZERO:
		$PlayerAnimation2D/AnimationPlayer.play("movement")
	else: 
		$PlayerAnimation2D/AnimationPlayer.pause()
	
	# diagonal movement speed should be the same as vertical/horizontal movement, so we should normalize it
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	$HpBar.value = (hp / max_hp) * 100.0
	set_modulate(Color(1, 0, 0, 1))
	await get_tree().create_timer(0.2).timeout
	set_modulate(Color(1, 1, 1, 1))
	print(hp)
