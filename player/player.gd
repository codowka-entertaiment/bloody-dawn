extends CharacterBody2D

var move_speed = 120.0
var hp = 20.0
var max_hp = hp

var experience = 0 
var experienceLevel = 1
var collectedExperience = 0

var gold = 0

const max_speed = 200
const accel = 1500
const friction = 10000

var input = Vector2.ZERO

signal experienceChanged
signal goldCollected

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


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		if area.is_in_group("exp"):
			var gemExp = area.collect()
			area.collectFinished()
			calculateExp(gemExp)
			emit_signal("experienceChanged")
		elif area.is_in_group("gold"):
			gold += area.collect()

func calculateExp(gemExp):
	var expReq = calculateExpReq()
	collectedExperience += gemExp
	while experience + collectedExperience >= expReq:
		collectedExperience -= expReq - experience
		experienceLevel += 1
		experience = 0
		expReq = calculateExpReq()
		emit_signal("experienceChanged")
		levelup()
	experience += collectedExperience
	collectedExperience = 0

func calculateExpReq():
	var expCap = experienceLevel
	if experienceLevel < 20:
		expCap = experienceLevel * 5
	elif experienceLevel < 40:
		expCap = 95 * (experienceLevel - 19) * 8
	else:
		expCap = 255 + (experienceLevel - 39) * 12
	return expCap

func levelup(): # todo: weapon choice screen, upgrades etc.
	print(experienceLevel)
