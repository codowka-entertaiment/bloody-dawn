extends CharacterBody2D

var move_speed = 300.0

func _physics_process(delta):
	movement()

func movement():
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	var move = Vector2(x, y)
	
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
	$PlayerAnimation2D/AnimationPlayer.play("movement")
	
	# diagonal movement speed should be the same as vertical/horizontal movement, so we should normalize it
	velocity = move.normalized() * move_speed
	move_and_slide()
